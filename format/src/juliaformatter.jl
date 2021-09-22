
"""
    format()

Format all files in the book.
This removes trailing whitespace by default.
"""
function format()::BitVector
    return format_file.(source_files();
        margin=500,
        verbose=true,
        whitespace_in_kwargs=false
    )
end

"""
    is_formatted()

Return whether the files in the repository are formatted.
This method is used in CI.
"""
function is_formatted()
    return all(format())
end

