using BonitoBook, Bonito, Dates, Markdown

# Define the book structure and chapter ordering
const BOOK_STRUCTURE = [
    # Front matter
    ("index", "Welcome"),
    ("preface", "Preface"),
    ("notation", "Notation"),

    # Introduction
    ("why_julia", "Why Julia?"),
    ("julia_basics", "Julia Basics"),

    # DataFrames
    ("dataframes", "DataFrames.jl"),
    ("dataframes_load_save", "Loading and Saving Files"),
    ("dataframes_indexing", "Indexing"),
    ("dataframes_select", "Select"),
    ("dataframes_transform", "Transform"),
    ("dataframes_groupby_combine", "Split-Apply-Combine"),
    ("dataframes_join", "Joins"),
    ("dataframes_missing", "Missing Data"),
    ("dataframes_performance", "Performance Tips"),

    # DataFramesMeta
    ("dataframesmeta", "DataFramesMeta.jl"),
    ("dataframesmeta_macros", "DataFramesMeta Macros"),
    ("dataframesmeta_select", "DataFramesMeta Select"),
    ("dataframesmeta_subset", "DataFramesMeta Subset"),
    ("dataframesmeta_transform", "DataFramesMeta Transform"),
    ("dataframesmeta_combine", "DataFramesMeta Combine"),
    ("dataframesmeta_orderby", "DataFramesMeta Order By"),
    ("dataframesmeta_chain", "DataFramesMeta Chain"),

    # Statistics
    ("stats", "Statistics"),
    ("stats_distributions", "Probability Distributions"),
    ("stats_vis", "Statistical Visualization"),

    # Data Visualization - Makie
    ("data_vis_makie", "Data Visualization with Makie.jl"),
    ("data_vis_makie_create_figure", "Creating Figures"),
    ("data_vis_makie_cairo", "CairoMakie.jl"),
    ("data_vis_makie_glmakie", "GLMakie.jl"),
    ("data_vis_makie_layouts", "Layouts"),
    ("data_vis_makie_themes", "Themes"),
    ("data_vis_makie_colors", "Colors"),
    ("data_vis_makie_latex", "LaTeX"),
    ("data_vis_makie_recipe", "Recipe"),

    # Data Visualization - AlgebraOfGraphics
    ("data_vis_aog", "Data Visualization with AlgebraOfGraphics.jl"),
    ("data_vis_aog_custom", "Plot Customizations"),
    ("data_vis_aog_layouts", "Layouts"),
    ("data_vis_aog_stats", "Statistical Plotting"),
    ("data_vis_aog_makie", "AlgebraOfGraphics and Makie"),

    # Appendices
    ("makie_cheat_sheets", "Makie Cheat Sheets"),
    ("references", "References"),
    ("appendix", "Appendix"),
]

"""
    JuliaDataScienceBook

A specialized Book wrapper for the Julia Data Science book that provides:
- Automatic cell execution on load
- Julia-themed styling integration

This struct wraps the standard BonitoBook.Book and adds book-specific features.
"""
struct JuliaDataScienceBook
    book::BonitoBook.Book
end

function JuliaDataScienceBook(
    filename::String;
    auto_execute::Bool = true,
    book_kwargs...
)
    # Create the underlying Book from the markdown file
    book = BonitoBook.Book(filename; all_blocks_as_cell=true, book_kwargs...)
    if auto_execute
        # Execute all cells on load
        for cell in book.cells
            BonitoBook.run_sync!(cell.editor)
        end
    end

    return JuliaDataScienceBook(book)
end

"""
Custom jsrender for JuliaDataScienceBook that renders the book with styling.
"""
function Bonito.jsrender(session::Session, jds_book::JuliaDataScienceBook)
    book = jds_book.book
    # Render the book with styling applied
    return Bonito.jsrender(session, DOM.div(
        book.style_eval.last_valid_output,
        DOM.div(
            book.cells,
            class="book-cells-area"
        ),
        class="julia-data-science-chapter"
    ))
end

# TOC and utility functions for the main book page

"""
Extract chapter information from markdown files.
"""
function get_chapter_info(filename)
    filepath = joinpath(dirname(@__FILE__), "..", "$(filename).md")
    if !isfile(filepath)
        return nothing
    end

    content = read(filepath, String)
    lines = split(content, '\n')

    # Find the first heading
    title = nothing
    section_id = nothing

    for line in lines
        if startswith(line, "# ")
            # Extract title and ID
            if contains(line, "{#")
                # Parse title with ID: # Title {#sec:id}
                title_match = match(r"^# ([^{]+)\s*\{#([^}]+)\}", line)
                if title_match !== nothing
                    title = strip(title_match.captures[1])
                    section_id = title_match.captures[2]
                end
            else
                # Just title: # Title
                title = strip(line[3:end])
            end
            break
        end
    end

    return (title=title, section_id=section_id, filename=filename)
end

"""
Generate table of contents HTML from all chapters.
"""
function generate_toc()
    toc_items = []

    for (i, (filename, fallback_title)) in enumerate(BOOK_STRUCTURE)
        chapter_info = get_chapter_info(filename)
        if chapter_info === nothing
            continue
        end

        title = chapter_info.title !== nothing ? chapter_info.title : fallback_title
        link = i == 1 ? "/" : "/$(filename)"
        # Create navigation link
        toc_item = DOM.li(
            DOM.a(
                title,
                href=Bonito.Link(link),
                class="toc-link",
            ),
            class="toc-item"
        )
        push!(toc_items, toc_item)
    end

    return DOM.nav(
        DOM.h2("Contents", class="toc-title"),
        DOM.ul(toc_items..., class="toc-list"),
        class="book-toc"
    )
end


function Page(book)
    # Create sidebar with TOC
    sidebar = DOM.div(
        DOM.div(
            DOM.h1("Julia Data Science", class="book-title"),
            DOM.p("An Interactive Guide", class="book-subtitle"),
            class="book-header"
        ),
        generate_toc(),
        class="book-sidebar"
    )

    # Create main content area with the book
    content = DOM.div(
        book,
        class="book-content"
    )

    return DOM.div(
        sidebar,
        content,
        class="julia-data-science-book"
    )
end
