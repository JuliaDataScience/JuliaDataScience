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
    println("Building tools")
    Books.gen(; M=JuliaDataScience, fail_on_error=true)
    Books.build_all()
end

end # module
