module JDS

import XLSX
import Pkg

using Reexport
@reexport using AlgebraOfGraphics
@reexport using Books
@reexport using CairoMakie
@reexport using CSV
@reexport using DataFrames
@reexport using Dates
@reexport using Downloads
@reexport using InteractiveUtils
@reexport using Makie
@reexport using Plots
@reexport using Random

export sce, trim_last_n_lines

plot = Plots.plot

include("df.jl")
include("environment.jl")
include("plots.jl")

function myplot()
    I = 1:30
    xy = mapping([I] => :x, [I .* 2] => :y)

    draw(xy)
end

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
    build()

This method is called during CI.
"""
function build()
    println("Building JDS")
    Books.gen(; fail_on_error=true)
    extra_head = """
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-2RKMTDS1S8"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());  gtag('config', 'G-2RKMTDS1S8');
    </script>
    """
    Books.build_all(; extra_head)
end

end # module
