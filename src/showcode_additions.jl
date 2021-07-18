function get_error(expr::String)
    try
        sco(expr)
    catch e
        exc, bt = last(Base.catch_stack())
        stacktrace = sprint(Base.showerror, exc, bt)::String
        stacktrace = Books.clean_stacktrace(stacktrace)
        lines = split(stacktrace, '\n')
        lines = lines[1:end-8]
        join(lines, '\n')
    end
end

function trim_last_n_lines(s::String, n::Int)
    lines = split(s, '\n')
    lines = lines[1:end-n]
    lines = [lines; "  ..."]
    join(lines, '\n')
end
trim_last_n_lines(n::Int) = s -> trim_last_n_lines(s, n)

"""
    sce(expr::String)

Show code and error.
"""
function sce(expr::String; post::Function=identity)
    code = code_block(expr)
    err = JDS.get_error(expr)
    err = post(err)
    out = output_block(err)
    """
    $code
    $out
    """
end

"""
    scsob(expr::String)

Source code string output block.
Abbreviation for `sco(s; process=string, post=output_block)`.
"""
function scsob(expr::String)
    sco(expr; process=string, post=output_block)
end
