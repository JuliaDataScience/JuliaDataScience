"""
    cover()

Return the book cover.
"""
function cover()
    width = 2 * 2016
    height = (10 / 7) * width # Ratio 7 * 10 inch.
    fig = Figure(; size=(width, height))
    # fig[1, 2] = Scene(front_cover())
    # return fig

    filename = "cover.pdf"
    dir = joinpath(pkgdir(JDS), BUILD_DIR)
    pdf_path = joinpath(dir, filename)

    favicon_from = joinpath(pkgdir(JDS), "pandoc", "favicon.png")
    favicon_to = joinpath(pkgdir(JDS), BUILD_DIR, "favicon.png")
    cp(favicon_from, favicon_to; force=true)

    fig = front_cover()
    png_path = joinpath(dir, "front_cover.png")
    FileIO.save(png_path, fig; px_per_unit=1) # maybe do 3 here?

    # See https://kdp.amazon.com/cover-calculator for details.
    tex = raw"""
        \documentclass[
        coverwidth=11.417in,
        coverheight=16.233in,
        spinewidth=0.685in,
        bleedwidth=0.591in,
        12pt
        ]{bookcover}

        \usepackage[
        ]{geometry}

        \usepackage{graphicx}

        \begin{document}
        \begin{bookcover}
        \bookcovercomponent{color}{bg whole}{black}

        \bookcovercomponent{center}{spine}{
            \rotatebox[origin=c]{-90}{
                \large\textcolor{white}{Storopoli, Huijzer \& Alonso}
                \hspace*{7in}
                \Huge\bfseries\textcolor{white}{Julia Data Science}
            }
            \vspace*{1in}
            % Should be 0.75 or less. Checked with the Amazon Print Previewer.
            \includegraphics[height=0.75\textwidth]{favicon.png}
        }

        \bookcovercomponent{normal}{back}{
            \vspace*{1in}
            \hspace*{0.6in}
            \parbox[c]{0.85\textwidth}{\Large\textcolor{white}{
        There are many programming languages and each and every one of them has its strengths and weaknesses.
        Some languages are very quick, but verbose.
        Other languages are very easy to write in, but slow.
        This is known as the `two-language` problem and the Julia programming language aims at circumventing this problem.
        Even though all three of us come from different fields, we all found the Julia language more effective for our research than languages that we've used before.
        However, compared to other languages, Julia is one of the newest languages around.
        This means that the ecosystem around the language is sometimes difficult to navigate through.
        It's difficult to figure out where to start and how all the different packages fit together.
        That is why we decided to create this book!
        We wanted to make it easier for researchers, and especially our colleagues, to start using this awesome language.
            }}
        }

        \bookcovercomponent{normal}{front}{
            \vspace*{-0.5in}
            \hspace*{0.5in} % At minimum hinge size.
            \includegraphics[width=0.97\textwidth]{front_cover.png}
        }

        \end{bookcover}
        \end{document}
        """
    tex_path = joinpath(dir, "cover.tex")
    write(tex_path, tex)

    tectonic() do bin
        cd(dir) do
            run(`$bin --print $tex_path`)
        end
    end

    return "[PDF](/$(filename))"
end
