function custom_plot()
    caption = "An example plot with Makie.jl."
    label = missing
    x = 1:10
    fig, ax, _ = lines(x, x.^2, color = :black, linewidth = 2,linestyle=".-", 
        label = "x²", figure = (; resolution = (700,450), fontsize = 18, 
        backgroundcolor = "#D0DFE6FF"), axis = (xlabel = "x", ylabel = "x²", 
        backgroundcolor = :white))
    axislegend("legend", position = :lt)
    limits!(ax, 0,10,0,100)
    fig
    filename = "customPlot"
    Options(fig; filename, caption, label)
end

function custom_plot2()
    x = 1:10
    lines(x, x.^2, color = :black, linewidth = 2,linestyle=".-", 
        label = "x²", figure = (; resolution = (700,450), fontsize = 18, 
        backgroundcolor = "#D0DFE6FF"), axis = (xlabel = "x", ylabel = "x²", 
        backgroundcolor = :white))
    axislegend("legend", position = :lt)
    limits!( 0,10,0,100)
    caption = "An example plot with Makie.jl."
    label = missing
    Options(current_figure(); caption, label)
end

function areaUnder()
    x = 0:0.05:1
    y = x.^2
    fig = Figure(resolution = (700, 450))
    ax = Axis(fig, xlabel = "x", ylabel = "y")
    linea = lines!(x, y, color = :dodgerblue)
    fillB = band!(x, fill(0,length(x)), y; color = (:dodgerblue, 0.1))
    leg = Legend(fig, [[linea, fillB]], ["Label"], halign = :left, valign = :top,
                tellheight = false, tellwidth = false, margin = (10, 10, 10, 10))
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig
    caption = "An example plot with Makie.jl."
    label = missing
    Options(fig; caption, label)
end

function makiejl()
    x = range(0, 10, length=100)
    y = sin.(x)
    p = lines(x, y)
    caption = "An example plot with Makie.jl."
    label = missing
    Options(p; caption, label)
end

