using JuliaFormatter: format_file

const JDS_DIR = dirname(@__DIR__)::String

# Unfortunately, JuliaFormatter doesn't accept .bib files.
const SOURCE_FILE_EXTENSIONS = [".jl", ".md"]

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

"""
    format()

Format all files in the book.
This removes trailing whitespace by default.
"""
function format()::BitVector
    args = [
        :verbose => true,
        :remove_extra_newlines => false,
        :whitespace_in_kwargs => false
    ]
    return format_file.(source_files(); args...)
end

"""
    is_formatted()

Return whether the files in the repository are formatted.
This method is used in CI.
"""
function is_formatted()
    return all(format())
end
