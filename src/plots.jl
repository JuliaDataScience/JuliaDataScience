function guess_my_plot()
    Random.seed!(123)
    p1 = plot()                             # empty Plot object
    p2 = plot(4)                            # initialize with 4 empty series
    p3 = plot(rand(10))                     # 1 series... x = 1:10
    p4 = plot(rand(10, 5))                   # 5 series... x = 1:10
    p5 = plot(rand(10), rand(10))           # 1 series
    p6 = plot(rand(10, 5), rand(10))         # 5 series... y is the same for all
    p7 = plot(cos, rand(10))                # y = sin.(x)
    p8 = plot(rand(10), cos)                # same... y = sin.(x)
    p9 = plot([cos, sin], 0:0.1:π)           # 2 series, cos.(x) and sin.(x)
    p10 = plot([cos, sin], 0, π)             # cos and sin on the range [0, π]
    fig = plot(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
    caption = "Guess my plot." # hide
    label = "guess_my_plot" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function test_plots_attributes()
    x = LinRange(0, 2π, 50)
    plt1 = plot(x, sin.(x), st=:scatter, label="sin(x)",
        m=(3, :black, stroke(0)), leg=:bottomleft,
        fg_legend=:black, bg_legend=nothing)
    plt2 = plot(x, sin.(x), c=:black, m=(3, :d, :black, stroke(0)),
        label="sin(x)", leg=:bottomleft, fg_legend=:black,
        bg_legend=nothing)
    plt3 = plot(x, [sin.(x), cos.(x)], c=:black, leg=:topright,
        m=(3, [:d :o], [:black :orangered], stroke(0)),
        label=["sin(x)" "cos(x)"], fg_legend=nothing,
        bg_legend=:white, xlab=L"x")
    plt4 = plot(x, [sin.(x), cos.(x), -sin.(x), -cos.(x)], lw=1.5,
        c=[:viridis :plasma :magma :inferno], linez=x,
        colorbar=false, legend=:false, xlab=L"x")
    fig = plot(plt1, plt2, plt3, plt4, layout=(2, 2), legendfont=(8,))
    caption = "Plot's attributes." # hide
    label = "test_plots_attributes" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end
