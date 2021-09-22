"""
    line_has_trailing_whitespace(line::AbstractString)

Return whether `line` has trailing whitespace.
Assumes that `line` doesn't contain newlines.
"""
line_has_trailing_whitespace(line::AbstractString) = endswith(line, ' ')

"""
    file_has_trailing_whitespace(path) -> Bool

Check for trailing whitespace in a naive but reasonably effective way for the file at `path`.
Return whether the file contains trailing whitespace.

Not using exising tools for this simple procedure, because it's easier to fine tune this
code to our use-case.
"""
function file_has_trailing_whitespace(path)::Bool
    lines = split(read(path, String), '\n')
    return any(line_has_trailing_whitespace.(lines))
end

function project_has_trailing_whitespace()::Bool
    return any(file_has_trailing_whitespace.(source_files()))
end

function remove_trailing_whitespace(path)
    sep = '\n'
    text = read(path, String)
    lines = split(text, sep)
    updated_lines = rstrip.(lines, ' ')
    updated_text = join(updated_lines, sep)
    write(path, updated_text)
    return nothing
end

function remove_trailing_whitespace()
    remove_trailing_whitespace.(source_files())
    return nothing
end
