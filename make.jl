title = "Julia Data Science"
link = "https://juliadatascience.io"
description = "An interactive guide to data science with Julia"

# Load packages
using BonitoBook, Makie
using BonitoBook.Bonito

# Include the book configuration
# TODO, make this a proper BonitoBook plugin
include("src/JDS.jl")
include("contents/.bonitobook/book.jl")

# Function to get all chapter files from contents directory
function get_chapter_files()
    contents_dir = joinpath(@__DIR__, "contents")
    md_files = filter(f -> endswith(f, ".md"), readdir(contents_dir))

    # Extract chapter names (without .md extension)
    chapters = [splitext(f)[1] for f in md_files]

    # Filter out any files that shouldn't be individual chapters
    exclude_files = ["index", "notation"]  # These might be handled specially
    chapters = filter(c -> !(c in exclude_files), chapters)

    return chapters
end

# Function to add chapter routes
function add_chapter_routes!(routes)
    contents_dir = joinpath(@__DIR__, "contents")

    # Add individual chapter routes
    for (i, (filename, title)) in enumerate(BOOK_STRUCTURE)
        file_path = joinpath(contents_dir, "$(filename).md")
        if isfile(file_path)
            # First chapter gets the root route
            route_name = i == 1 ? "/" : "/$(filename)"
            routes[route_name] = App(title=title) do
                # Create a Page with JuliaDataScienceBook instance for this chapter
                return Page(JuliaDataScienceBook(file_path; auto_execute=false))
            end
        end
    end
    return routes
end

function create_routes()
    routes = Routes()
    # Add individual chapter pages (including root route for first chapter)
    add_chapter_routes!(routes)
    return routes
end

# Build and serve
function build_book()
    # Build static site
    build_dir = joinpath(@__DIR__, "build")
    !isdir(build_dir) && mkdir(build_dir)

    routes = create_routes()

    # Export static files
    Bonito.export_static(build_dir, routes)

    println("Book built successfully in: $(build_dir)")
    return build_dir
end
build_book()


# Development server
function serve_book(url="127.0.0.1", port=8080)
    routes = create_routes()
    # Start server
    server = Bonito.Server(url, port)
    route!(server, routes)
    server
end

# Interactive version:
server = serve_book()
