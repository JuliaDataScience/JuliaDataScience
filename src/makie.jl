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
    caption = "An example plot with Makie.jl." # hide 
    label = missing # hide 
    Options(p; caption, label) # hide 
end

function LaTeX_Strings()
    x = 0:0.05:4π
    lines(x,x -> sin(3x)/(cos(x)+2)/x; label=L"\frac{\sin(3x)}{x(\cos(x)+2)}", 
        figure=(;resolution=(600,400), ), axis = (; xlabel = L"x"))
    lines!(x,x-> cos(x)/x; label = L"\cos(x)/x")
    lines!(x,x-> exp(-x); label = L"e^{-x}")
    limits!(-0.5,13,-0.6,1.05)  
    axislegend(L"f(x)")
    current_figure()
end

publication_theme()= Theme(
        fontsize = 16,font="CMU Serif",
        Axis = (xlabelsize= 20,xgridstyle=:dash,ygridstyle=:dash,
            xtickalign = 1, ytickalign=1,yticksize=10, xticksize=10, 
            xlabelpadding = -5, xlabel = "x", ylabel = "y"),
        Legend = (framecolor = (:black, 0.5), bgcolor = (:white, 0.5)),
        Colorbar = (ticksize=16, tickalign = 1, spinewidth = 0.5)
    )

function plot_with_legend_and_colorbar()
    n = 15
    x = LinRange(6,9,n)
    y = LinRange(2,5,n)
    m = randn(n,n)
    fig, ax, _ = lines(1:10; label = "line")
    CairoMakie.scatter!(1:10; label = "line")
    heatObj = CairoMakie.heatmap!(ax, x, y, m; colormap = :Spectral_11)
    axislegend("legend"; position = :lt,  merge = true)
    Colorbar(fig[1,2], heatObj, label = "values")
    ax.title = "my custom theme"
    fig
end

function multiple_lines()
    fig = Figure(resolution = (600,400), font="CMU Serif")
    ax = Axis(fig[1,1], xlabel = L"x", ylabel = L"f(x,a)")
    for i in 0:10
        lines!(ax, 0:10, i .* collect(0:10); label = latexstring("$(i) x"))
    end
    axislegend(L"f(x)"; position = :lt, nbanks = 2, labelsize = 14)
    text!(L"f(x,a) = ax", position = (4,80))
    fig
end

function multiple_scatters_and_lines()
    cycle = Cycle([:color, :linestyle, :marker], covary = true)
    set_theme!(Lines = (cycle = cycle,), Scatter = (cycle = cycle,))

    fig = Figure(resolution = (600,400), font="CMU Serif")
    ax = Axis(fig[1,1], xlabel = L"x", ylabel = L"f(x,a)")
    x = collect(0:10)
    for i in x
        lines!(ax, x, i .* x; label = latexstring("$(i) x"))
        CairoMakie.scatter!(ax, x, i .* x; markersize = 13,
            strokewidth = 0.25, label = latexstring("$(i) x"))
    end
    axislegend(L"f(x)"; merge = true,position = :lt,nbanks=2,labelsize=14)
    text!(L"f(x,a) = ax", position = (4,80))
    set_theme!() # reset to default theme
    fig 
end

function demo_themes()
    Random.seed!(123)
    n = 6
    y = cumsum(randn(n, 10), dims = 2)
    labels = ["$i" for i in 1:n]
    fig, _ = series(y; labels = labels, markersize = 10, color=:Set1, 
        axis = (; xlabel = "time (s)", ylabel = "Amplitude", 
        title = "Measurements"), figure = (;resolution = (600,300)))
    xh = LinRange(-3,0.5,20)
    yh = LinRange(-3.5,3.5, 20)
    hmap = CairoMakie.heatmap!(xh, yh, randn(20,20); colormap = :plasma)
    limits!(-3.1,13,-6,5.1)
    axislegend("legend"; merge = true)
    Colorbar(fig[1,2], hmap)
    fig
end



function multiple_example_themes()
    filenames = ["theme_dark()", "theme_black()", "theme_ggplot2()", # hide 
        "theme_minimal()", "theme_light()"] # hide 
    function demo_theme()
        Random.seed!(123)
        n = 6
        y = cumsum(randn(n, 10), dims = 2)
        labels = ["$i" for i in 1:n]
        fig, _ = series(y; labels = labels, markersize = 10, color=:Set1, 
            axis = (; xlabel = "time (s)", ylabel = "Amplitude", 
            title = "Measurements"), figure = (;resolution = (600,300)))
        xh = LinRange(-3,0.5,20)
        yh = LinRange(-3.5,3.5, 20)
        hmap = CairoMakie.heatmap!(xh, yh, randn(20,20); colormap = :plasma)
        limits!(-3.1,13,-6,5.1)
        axislegend("legend"; merge = true)
        Colorbar(fig[1,2], hmap)
        current_figure()
    end

    objects = [  
        with_theme(demo_theme, theme_dark())
        with_theme(demo_theme, theme_black())
        with_theme(demo_theme, theme_ggplot2())
        with_theme(demo_theme, theme_minimal())
        with_theme(demo_theme, theme_light())
    ] 
    Options.(objects, filenames) # hide 
end

function set_colors_and_cycle()
    # Epicycloid lines 
    x(r,k,θ) = r*(k .+ 1.0).*cos.(θ) .- r*cos.((k .+ 1.0) .* θ)
    y(r,k,θ) = r*(k .+ 1.0).*sin.(θ) .- r*sin.((k .+ 1.0) .* θ)
    θ = LinRange(0,6.2π,1000)
    
    axis = (; xlabel = L"x(\theta)", ylabel = L"y(\theta)", 
        title = "Epicycloid", aspect= DataAspect())
    figure = (;resolution = (500,400), font= "CMU Serif")

    fig, ax, _ = lines(x(1,1,θ), y(1,1,θ); color = "firebrick1", #string 
        label = L"1.0", axis = axis, figure = figure)
    lines!(ax, x(4,2,θ), y(4,2,θ); color = :royalblue1, #symbol
        label = L"2.0")  
    for k in 2.5:0.5:5.5
        lines!(ax, x(2k,k,θ), y(2k,k,θ); label = latexstring("$(k)")) #cycle
    end
    Legend(fig[1, 2], ax, latexstring("k, r = 2k"), merge = true)
    fig
end

function new_cycle_theme()
    # https://nanx.me/ggsci/reference/pal_locuszoom.html
    my_colors = ["#D43F3AFF", "#EEA236FF", "#5CB85CFF", "#46B8DAFF", 
        "#357EBDFF", "#9632B8FF", "#B8B8B8FF"]
    cycle = Cycle([:color, :linestyle, :marker], covary = true) # alltogether 
    my_markers = [:circle, :rect, :utriangle, :dtriangle, :diamond, 
        :pentagon, :cross, :xcross]
    my_linestyle = [nothing, :dash, :dot, :dashdot, :dashdotdot]

    Theme(
        fontsize = 16, font="CMU Serif",
        colormap = :linear_bmy_10_95_c78_n256,
        palette=(color=my_colors,marker=my_markers,linestyle=my_linestyle),
        Lines = (cycle = cycle,), Scatter = (cycle = cycle,),

        Axis = (xlabelsize= 20,xgridstyle=:dash,ygridstyle=:dash,
            xtickalign = 1, ytickalign=1,yticksize=10, xticksize=10, 
            xlabelpadding = -5, xlabel = "x", ylabel = "y"),
        Legend = (framecolor = (:black, 0.5), bgcolor = (:white, 0.5)),
        Colorbar = (ticksize=16, tickalign = 1, spinewidth = 0.5)
    )
end

function scatters_and_lines()
    fig = Figure(resolution = (650,400), font="CMU Serif")
    ax = Axis(fig[1,1], xlabel = L"x", ylabel = L"f(x,a)")
    x = collect(0:10)
    for i in x
        lines!(ax, x, i .* x; label = latexstring("$(i) x"))
        CairoMakie.scatter!(ax, x, i .* x; markersize = 13,
            strokewidth = 0.25, label = latexstring("$(i) x"))
    end
    hm=CairoMakie.heatmap!(LinRange(4,6,25),LinRange(70,95,25),randn(25,25))
    axislegend(L"f(x)"; merge = true,position = :lt,nbanks=2,labelsize=14)
    Colorbar(fig[1,2], hm, label = "new default colormap")
    limits!(ax,-0.5,10.5,-5,105)
    colgap!(fig.layout, 5)
    fig 
end