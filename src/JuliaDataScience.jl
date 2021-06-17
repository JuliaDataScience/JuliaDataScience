module JuliaDataScience

using AlgebraOfGraphics
using CairoMakie
using Makie
using Plots

greet() = print("Hello World!")

function myplot()
    I = 1:30
    xy = mapping([I] => :x, [I.*2] => :y)

    draw(xy)
end

# TODO: Add workaround.

function myplots()
    p = Plots.plot(rand(10, 10))
    savefig(p, "tmp.svg")
end

end # module
