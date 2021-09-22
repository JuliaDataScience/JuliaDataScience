module FormatJDS

using JuliaFormatter: format_file

const JDS_DIR = dirname(dirname(@__DIR__))

const SOURCE_FILE_EXTENSIONS = [".jl", ".md", ".bib"]

export source_files
export project_has_trailing_whitespace, remove_trailing_whitespace

function is_source_file_extension(file::String)
    _, ext = splitext(file)
    return ext in SOURCE_FILE_EXTENSIONS
end

function source_files()
    subdirs = [
        "contents",
        "pandoc",
        "src"
    ]
    files = [readdir(joinpath(JDS_DIR, dir); join=true) for dir in subdirs]
    files = collect(Iterators.flatten(files))
    files = filter(is_source_file_extension, files)
    return files
end

include("whitespace.jl")
include("juliaformatter.jl")

end # module
