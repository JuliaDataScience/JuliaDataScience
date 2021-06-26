module JDS

import Pkg

using Reexport
@reexport using AlgebraOfGraphics
@reexport using Books
@reexport using CairoMakie
@reexport using Makie
@reexport using Plots

plot = Plots.plot

include("environment.jl")
include("plots.jl")

function myplot()
    I = 1:30
    xy = mapping([I] => :x, [I .* 2] => :y)

    draw(xy)
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

    <!-- Highlight.js -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.0.1/build/styles/default.min.css">
    <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.0.1/build/highlight.min.js"></script>
    <!-- and it's easy to individually load additional languages -->
    <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.0.1/build/languages/julia.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.0.1/build/languages/julia-repl.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.0.1/build/languages/python.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.0.1/build/languages/python-repl.min.js"></script>
    <script>hljs.highlightAll();</script>
    """
    Books.build_all(; extra_head)
end

end # module
