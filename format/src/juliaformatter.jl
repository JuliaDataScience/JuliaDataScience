"""
    format()

Format all files in the book.
This removes trailing whitespace by default.
"""
function format()::BitVector
    files = source_files()
    filter!(f -> !endswith(f, ".bib"), files)
    format_options = parse_config(joinpath(JDS_DIR, ".JuliaFormatter.toml"))
    results = format_file.(files; format_options...)
    # JuliaFormatter can introduce trailing whitespace.
    remove_trailing_whitespace()
    return results
end

"""
    is_formatted!()

Return whether the files in the repository are formatted.
This method is used in CI.
"""
function is_formatted!()
    return all(format())
end

