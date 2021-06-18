module JuliaDataScience

import Books

using AlgebraOfGraphics
using CairoMakie
using Makie
using Plots
using InteractiveUtils
using Pkg:dependencies

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
    println("Building JuliaDataScience")
    Books.gen(; M=JuliaDataScience, fail_on_error=true)
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
