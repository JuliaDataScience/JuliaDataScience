"""
    cover()

Return the book cover.
"""
function cover()
    width = 2 * 2016
    height = (10/7) * width # Ratio 7 * 10 inch.
    fig = Figure(; resolution=(width, height))
    # fig[1, 2] = Scene(front_cover())
    # return fig

    filename = "cover.pdf"
    dir = joinpath(pkgdir(JDS), BUILD_DIR)
    pdf_path = joinpath(dir, filename)
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
        \graphicspath{{im/}}

        \begin{document}
        \begin{bookcover}
        \bookcovercomponent{color}{bg whole}{black}

        \bookcovercomponent{center}{spine}{
            \rotatebox[origin=c]{-90}{
                \Huge\bfseries\textcolor{white}{Julia Data Science}
            }
        }

        \bookcovercomponent{normal}{back}{
            \vfill
            \textcolor{white}{foo}
        }

        \bookcovercomponent{normal}{front}{
            \vspace*{-0.5in}
            \hspace*{0.5in} % At minimum hinge size.
            \includegraphics[width=0.97\textwidth]{front_cover_.png}
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
