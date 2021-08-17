function test_plots_layout()
    x = LinRange(0,2π,50)
    plt1 = Plots.plot(x, sin.(x), st = :scatter, label = "sin(x)",
        m = (3, :black, Plots.stroke(0)), leg =:bottomleft,
        fg_legend = :black, bg_legend = nothing)
    plt2 = Plots.plot(x, sin.(x), c = :black, m=(3,:d,:black,Plots.stroke(0)),
        label = "sin(x)", leg =:bottomleft, fg_legend = :black,
        bg_legend = nothing)
    plt3 = Plots.plot(x, [sin.(x), cos.(x)], c = :black, leg =:topright,
        m = (3, [:d :o], [:black :orangered], Plots.stroke(0)), 
        label = ["sin(x)" "cos(x)"], fg_legend = nothing,
        bg_legend = :white, xlab =L"x")
    plt4 = Plots.plot(x, [sin.(x), cos.(x), -sin.(x), -cos.(x)], lw = 1.5, 
        c = [:viridis :plasma :magma :inferno], linez = x,
        colorbar = false, legend =:false, xlab =L"x")
    Plots.plot(plt1, plt2, plt3, plt4, layout = (2,2), legendfont=(8,))
end
