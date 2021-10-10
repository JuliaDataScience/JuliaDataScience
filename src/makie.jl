function custom_plot()
    CairoMakie.activate!() # hide
    caption = "An example plot with Makie.jl."
    label = missing
    x = 1:10
    fig, ax, _ = lines(x, x .^ 2, color=:black, linewidth=2, linestyle=".-",
        label="x²", figure=(; resolution=(700, 450), fontsize=18,
            backgroundcolor="#D0DFE6FF"), axis=(xlabel="x", ylabel="x²",
            backgroundcolor=:white))
    axislegend("legend", position=:lt)
    limits!(ax, 0, 10, 0, 100)
    fig
    filename = "customPlot"
    Options(fig; filename, caption, label)
end

function custom_plot2()
    CairoMakie.activate!() # hide
    x = 1:10
    lines(x, x .^ 2, color=:black, linewidth=2, linestyle=".-",
        label="x²", figure=(; resolution=(700, 450), fontsize=18,
            backgroundcolor="#D0DFE6FF"), axis=(xlabel="x", ylabel="x²",
            backgroundcolor=:white))
    axislegend("legend", position=:lt)
    limits!(0, 10, 0, 100)
    caption = "An example plot with Makie.jl."
    label = missing
    Options(current_figure(); caption, label)
end

function areaUnder()
    CairoMakie.activate!() # hide
    x = 0:0.05:1
    y = x .^ 2
    fig = Figure(resolution=(700, 450))
    ax = Axis(fig, xlabel="x", ylabel="y")
    linea = lines!(x, y, color=:dodgerblue)
    fillB = band!(x, fill(0, length(x)), y; color=(:dodgerblue, 0.1))
    leg = Legend(fig, [[linea, fillB]], ["Label"], halign=:left, valign=:top,
        tellheight=false, tellwidth=false, margin=(10, 10, 10, 10))
    fig[1, 1] = ax
    fig[1, 1] = leg
    fig
    caption = "An example plot with Makie.jl."
    label = missing
    Options(fig; caption, label)
end

function makiejl()
    CairoMakie.activate!() # hide
    x = range(0, 10, length=100)
    y = sin.(x)
    p = lines(x, y)
    caption = "An example plot with Makie.jl." # hide
    label = missing # hide
    Options(p; caption, label) # hide
end

function LaTeX_Strings()
    CairoMakie.activate!() # hide
    x = 0:0.05:4π
    lines(x, x -> sin(3x) / (cos(x) + 2) / x; label=L"\frac{\sin(3x)}{x(\cos(x)+2)}",
        figure=(; resolution=(600, 400)), axis=(; xlabel=L"x"))
    lines!(x, x -> cos(x) / x; label=L"\cos(x)/x")
    lines!(x, x -> exp(-x); label=L"e^{-x}")
    limits!(-0.5, 13, -0.6, 1.05)
    axislegend(L"f(x)")
    current_figure()
end

publication_theme() = Theme(
    fontsize=16, font="CMU Serif",
    Axis=(xlabelsize=20, xgridstyle=:dash, ygridstyle=:dash,
        xtickalign=1, ytickalign=1, yticksize=10, xticksize=10,
        xlabelpadding=-5, xlabel="x", ylabel="y"),
    Legend=(framecolor=(:black, 0.5), bgcolor=(:white, 0.5)),
    Colorbar=(ticksize=16, tickalign=1, spinewidth=0.5),
)

function plot_with_legend_and_colorbar()
    CairoMakie.activate!() # hide
    fig, ax, _ = scatterlines(1:10; label="line")
    hm = heatmap!(ax, LinRange(6, 9, 15), LinRange(2, 5, 15), randn(15, 15);
        colormap=:Spectral_11)
    axislegend("legend"; position=:lt)
    Colorbar(fig[1, 2], hm, label="values")
    ax.title = "my custom theme"
    fig
end

function multiple_lines()
    CairoMakie.activate!() # hide
    x = collect(0:10)
    fig = Figure(resolution=(600, 400), font="CMU Serif")
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"f(x,a)")
    for i = 0:10
        lines!(ax, x, i .* x; label=latexstring("$(i) x"))
    end
    axislegend(L"f(x)"; position=:lt, nbanks=2, labelsize=14)
    text!(L"f(x,a) = ax", position=(4, 80))
    fig
    caption = "Multiple lines." # hide
    label = "multiple_lines" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function multiple_scatters_and_lines()
    CairoMakie.activate!() # hide
    x = collect(0:10)
    cycle = Cycle([:color, :linestyle, :marker], covary=true)
    set_theme!(Lines=(cycle=cycle,), Scatter=(cycle=cycle,))
    fig = Figure(resolution=(600, 400), font="CMU Serif")
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"f(x,a)")
    for i in x
        lines!(ax, x, i .* x; label=latexstring("$(i) x"))
        scatter!(ax, x, i .* x; markersize=13, strokewidth=0.25,
            label=latexstring("$(i) x"))
    end
    axislegend(L"f(x)"; merge=true, position=:lt, nbanks=2, labelsize=14)
    text!(L"f(x,a) = ax", position=(4, 80))
    set_theme!() # reset to default theme
    fig
    caption = "Multiple Scatters and Lines." # hide
    label = "multiple_scatters_and_lines" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function demo_themes(y, xv, yv, matrix)
    CairoMakie.activate!() # hide
    fig, _ = series(y; labels=["$i" for i = 1:6], markersize=10,
        color=:Set1, figure=(; resolution=(600, 300)),
        axis=(; xlabel="time (s)", ylabel="Amplitude",
            title="Measurements"))
    hmap = heatmap!(xv, yv, matrix; colormap=:plasma)
    limits!(-3.1, 8.5, -6, 5.1)
    axislegend("legend"; merge=true)
    Colorbar(fig[1, 2], hmap)
    fig
end

function multiple_example_themes()
    CairoMakie.activate!() # hide
    filenames = ["theme_dark()", "theme_black()", "theme_ggplot2()", # hide
        "theme_minimal()", "theme_light()"] # hide
    function demo_theme()
        Random.seed!(123)
        n = 6
        y = cumsum(randn(n, 10), dims=2)
        labels = ["$i" for i = 1:n]
        fig, _ = series(y; labels=labels, markersize=10, color=:Set1,
            axis=(; xlabel="time (s)", ylabel="Amplitude",
                title="Measurements"), figure=(; resolution=(600, 300)))
        xh = LinRange(-3, 0.5, 20)
        yh = LinRange(-3.5, 3.5, 20)
        hmap = heatmap!(xh, yh, randn(20, 20); colormap=:plasma)
        limits!(-3.1, 13, -6, 5.1)
        axislegend("legend"; merge=true)
        Colorbar(fig[1, 2], hmap)
        current_figure()
    end

    objects = [
        with_theme(demo_theme, theme_dark())
        with_theme(demo_theme, theme_black())
        with_theme(demo_theme, theme_ggplot2())
        with_theme(demo_theme, theme_minimal())
        with_theme(demo_theme, theme_light())
    ]
    #Options.(objects, filenames) # hide
end

function set_colors_and_cycle()
    CairoMakie.activate!() # hide
    # Epicycloid lines
    x(r, k, θ) = r * (k .+ 1.0) .* cos.(θ) .- r * cos.((k .+ 1.0) .* θ)
    y(r, k, θ) = r * (k .+ 1.0) .* sin.(θ) .- r * sin.((k .+ 1.0) .* θ)
    θ = LinRange(0, 6.2π, 1000)
    axis = (; xlabel=L"x(\theta)", ylabel=L"y(\theta)",
        title="Epicycloid", aspect=DataAspect())
    figure = (; resolution=(600, 400), font="CMU Serif")
    fig, ax, _ = lines(x(1, 1, θ), y(1, 1, θ); color="firebrick1", # string
        label=L"1.0", axis=axis, figure=figure)
    lines!(ax, x(4, 2, θ), y(4, 2, θ); color=:royalblue1, #symbol
        label=L"2.0")
    for k = 2.5:0.5:5.5
        lines!(ax, x(2k, k, θ), y(2k, k, θ); label=latexstring("$(k)")) #cycle
    end
    Legend(fig[1, 2], ax, latexstring("k, r = 2k"), merge=true)
    fig
end

function new_cycle_theme()
    # https://nanx.me/ggsci/reference/pal_locuszoom.html
    my_colors = ["#D43F3AFF", "#EEA236FF", "#5CB85CFF", "#46B8DAFF",
        "#357EBDFF", "#9632B8FF", "#B8B8B8FF"]
    cycle = Cycle([:color, :linestyle, :marker], covary=true) # alltogether
    my_markers = [:circle, :rect, :utriangle, :dtriangle, :diamond,
        :pentagon, :cross, :xcross]
    my_linestyle = [nothing, :dash, :dot, :dashdot, :dashdotdot]
    Theme(
        fontsize=16, font="CMU Serif",
        colormap=:linear_bmy_10_95_c78_n256,
        palette=(color=my_colors, marker=my_markers, linestyle=my_linestyle),
        Lines=(cycle=cycle,), Scatter=(cycle=cycle,),
        Axis=(xlabelsize=20, xgridstyle=:dash, ygridstyle=:dash,
            xtickalign=1, ytickalign=1, yticksize=10, xticksize=10,
            xlabelpadding=-5, xlabel="x", ylabel="y"),
        Legend=(framecolor=(:black, 0.5), bgcolor=(:white, 0.5)),
        Colorbar=(ticksize=16, tickalign=1, spinewidth=0.5),
    )
end

function scatters_and_lines()
    CairoMakie.activate!() # hide
    x = collect(0:10)
    xh = LinRange(4, 6, 25)
    yh = LinRange(70, 95, 25)
    h = randn(25, 25)
    fig = Figure(resolution=(600, 400), font="CMU Serif")
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"f(x,a)")
    for i in x
        lines!(ax, x, i .* x; label=latexstring("$(i) x"))
        scatter!(ax, x, i .* x; markersize=13, strokewidth=0.25,
            label=latexstring("$(i) x"))
    end
    hm = heatmap!(xh, yh, h)
    axislegend(L"f(x)"; merge=true, position=:lt, nbanks=2, labelsize=14)
    Colorbar(fig[1, 2], hm, label="new default colormap")
    limits!(ax, -0.5, 10.5, -5, 105)
    colgap!(fig.layout, 5)
    fig
end

function first_layout()
    CairoMakie.activate!() # hide
    Random.seed!(123)
    x, y, z = randn(6), randn(6), randn(6)
    fig = Figure(resolution=(600, 400), backgroundcolor=:grey90)
    ax = Axis(fig[1, 1], backgroundcolor=:white)
    pltobj = scatter!(ax, x, y; color=z, label="scatters")
    lines!(ax, x, 1.1y; label="line")
    Legend(fig[2, 1:2], ax, "labels", orientation=:horizontal)
    Colorbar(fig[1, 2], pltobj, label="colorbar")
    fig
    caption = "First Layout." # hide
    label = "first_layout" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function first_layout_fixed()
    CairoMakie.activate!() # hide
    Random.seed!(123)
    x, y, z = randn(6), randn(6), randn(6)
    fig = Figure(figure_padding=(0, 3, 5, 2), resolution=(600, 400),
        backgroundcolor=:grey90, font="CMU Serif")
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"y",
        title="Layout example", backgroundcolor=:white)
    pltobj = scatter!(ax, x, y; color=z, label="scatters")
    lines!(ax, x, 1.1y, label="line")
    Legend(fig[2, 1:2], ax, "Labels", orientation=:horizontal,
        tellheight=true, titleposition=:left)
    Colorbar(fig[1, 2], pltobj, label="colorbar")
    # additional aesthetics
    Box(fig[1, 1, Right()], color=(:slateblue1, 0.35))
    Label(fig[1, 1, Right()], "protrusion", textsize=18,
        rotation=pi / 2, padding=(3, 3, 3, 3))
    Label(fig[1, 1, TopLeft()], "(a)", textsize=18, padding=(0, 3, 8, 0))
    colgap!(fig.layout, 5)
    rowgap!(fig.layout, 5)
    fig
    caption = "First Layout Fixed." # hide
    label = "first_layout_fixed" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end


function complex_layout_double_axis()
    CairoMakie.activate!() # hide
    Random.seed!(123)
    x = LinRange(0, 1, 10)
    y = LinRange(0, 1, 10)
    z = rand(10, 10)
    fig = Figure(resolution=(600, 400), font="CMU Serif", backgroundcolor=:grey90)
    ax1 = Axis(fig, xlabel=L"x", ylabel=L"y")
    ax2 = Axis(fig, xlabel=L"x")
    heatmap!(ax1, x, y, z; colorrange=(0, 1))
    series!(ax2, abs.(z[1:4, :]); labels=["lab $i" for i = 1:4], color=:Set1_4)
    hm = scatter!(10x, y; color=z[1, :], label="dots", colorrange=(0, 1))
    hideydecorations!(ax2, ticks=false, grid=false)
    linkyaxes!(ax1, ax2)
    #layout
    fig[1, 1] = ax1
    fig[1, 2] = ax2
    Label(fig[1, 1, TopLeft()], "(a)", textsize=18, padding=(0, 6, 8, 0))
    Label(fig[1, 2, TopLeft()], "(b)", textsize=18, padding=(0, 6, 8, 0))
    Colorbar(fig[2, 1:2], hm, label="colorbar", vertical=false, flipaxis=false)
    Legend(fig[1, 3], ax2, "Legend")
    colgap!(fig.layout, 5)
    rowgap!(fig.layout, 5)
    fig
    caption = "Complex layout double axis." # hide
    label = "complex_layout_double_axis" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function squares_layout()
    CairoMakie.activate!() # hide
    Random.seed!(123)
    letters = reshape(collect('a':'d'), (2, 2))
    fig = Figure(resolution=(600, 400), fontsize=14, font="CMU Serif",
        backgroundcolor=:grey90)
    axs = [Axis(fig[i, j], aspect=DataAspect()) for i = 1:2, j = 1:2]
    hms = [heatmap!(axs[i, j], randn(10, 10), colorrange=(-2, 2))
           for i = 1:2, j = 1:2]
    Colorbar(fig[1:2, 3], hms[1], label="colorbar")
    [Label(fig[i, j, TopLeft()], "($(letters[i,j]))", textsize=16,
        padding=(-2, 0, -20, 0)) for i = 1:2, j = 1:2]
    colgap!(fig.layout, 5)
    rowgap!(fig.layout, 5)
    fig
    caption = "Squares layout." # hide
    label = "squares_layout" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function mixed_mode_layout()
    CairoMakie.activate!() # hide
    Random.seed!(123)
    longlabels = ["$(today() - Day(1))", "$(today())", "$(today() + Day(1))"]
    fig = Figure(resolution=(600, 400), fontsize=12,
        backgroundcolor=:grey90, font="CMU Serif")
    ax1 = Axis(fig[1, 1])
    ax2 = Axis(fig[1, 2], xticklabelrotation=pi / 2, alignmode=Mixed(bottom=0),
        xticks=([1, 5, 10], longlabels))
    ax3 = Axis(fig[2, 1:2])
    ax4 = Axis(fig[3, 1:2])
    axs = [ax1, ax2, ax3, ax4]
    [lines!(ax, 1:10, rand(10)) for ax in axs]
    hidexdecorations!(ax3; ticks=false, grid=false)
    Box(fig[2:3, 1:2, Right()], color=(:slateblue1, 0.35))
    Label(fig[2:3, 1:2, Right()], "protrusion", rotation=pi / 2, textsize=14,
        padding=(3, 3, 3, 3))
    Label(fig[1, 1:2, Top()], "Mixed alignmode", textsize=16,
        padding=(0, 0, 15, 0))
    colsize!(fig.layout, 1, Auto(2))
    rowsize!(fig.layout, 2, Auto(0.5))
    rowsize!(fig.layout, 3, Auto(0.5))
    rowgap!(fig.layout, 1, 15)
    rowgap!(fig.layout, 2, 0)
    colgap!(fig.layout, 5)
    fig
    caption = "Mixed mode layout." # hide
    label = "mixed_mode_layout" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function nested_sub_plot!(fig)
    color = rand(RGBf0)
    ax1 = Axis(fig[1, 1], backgroundcolor=(color, 0.25))
    ax2 = Axis(fig[1, 2], backgroundcolor=(color, 0.25))
    ax3 = Axis(fig[2, 1:2], backgroundcolor=(color, 0.25))
    ax4 = Axis(fig[1:2, 3], backgroundcolor=(color, 0.25))
    return (ax1, ax2, ax3, ax4)
end

function main_figure()
    Random.seed!(123) # hide
    CairoMakie.activate!() # hide
    fig = Figure()
    Axis(fig[1, 1])
    nested_sub_plot!(fig[1, 2])
    nested_sub_plot!(fig[1, 3])
    nested_sub_plot!(fig[2, 1:3])
    fig
    caption = "Main figure." # hide
    label = "main_figure" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function nested_Grid_Layouts()
    CairoMakie.activate!() # hide
    fig = Figure(backgroundcolor=RGBf0(0.96, 0.96, 0.96))
    ga = fig[1, 1] = GridLayout()
    gb = fig[1, 2] = GridLayout()
    gc = fig[1, 3] = GridLayout()
    gd = fig[2, 1:3] = GridLayout()
    gA = Axis(ga[1, 1])
    nested_sub_plot!(gb)
    axsc = nested_sub_plot!(gc)
    nested_sub_plot!(gd)
    [hidedecorations!(axsc[i], grid=false, ticks=false) for i = 1:length(axsc)]
    colgap!(gc, 5)
    rowgap!(gc, 5)
    rowsize!(fig.layout, 2, Auto(0.5))
    colsize!(fig.layout, 1, Auto(0.5))
    fig
    caption = "Nested Grid Layouts." # hide
    label = "nested_Grid_Layouts" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function add_box_inset(fig; left=100, right=250, bottom=200, top=300,
    bgcolor=:grey90)
    # https://discourse.julialang.org/t/makie-inset-axes-and-their-drawing-order/60987 # hide
    inset_box = Axis(fig, bbox=BBox(left, right, bottom, top),
        xticklabelsize=12, yticklabelsize=12, backgroundcolor=bgcolor)
    # bring content upfront
    translate!(inset_box.scene, 0, 0, 10)
    elements = keys(inset_box.elements)
    filtered = filter(ele -> ele != :xaxis && ele != :yaxis, elements)
    foreach(ele -> translate!(inset_box.elements[ele], 0, 0, 9), filtered)
    return inset_box
end

function add_axis_inset(; pos=fig[1, 1], halign=0.1, valign=0.5,
    width=Relative(0.5), height=Relative(0.35), bgcolor=:lightgray)
    inset_box = Axis(pos, width=width, height=height,
        halign=halign, valign=valign, xticklabelsize=12, yticklabelsize=12,
        backgroundcolor=bgcolor)
    # bring content upfront
    translate!(inset_box.scene, 0, 0, 10)
    elements = keys(inset_box.elements)
    filtered = filter(ele -> ele != :xaxis && ele != :yaxis, elements)
    foreach(ele -> translate!(inset_box.elements[ele], 0, 0, 9), filtered)
    return inset_box
end

function figure_axis_inset()
    CairoMakie.activate!() # hide
    fig = Figure(resolution=(600, 400))
    ax = Axis(fig[1, 1], backgroundcolor=:white)
    inset_ax1 = add_axis_inset(; pos=fig[1, 1], halign=0.1, valign=0.65,
        width=Relative(0.3), height=Relative(0.3), bgcolor=:grey90)
    inset_ax2 = add_axis_inset(; pos=fig[1, 1], halign=1, valign=0.25,
        width=Relative(0.25), height=Relative(0.3), bgcolor=(:white, 0.65))
    lines!(ax, 1:10)
    lines!(inset_ax1, 1:10)
    scatter!(inset_ax2, 1:10, color=:black)
    fig
    caption = "Figure axis inset." # hide
    label = "figure_axis_inset" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function figure_box_inset()
    CairoMakie.activate!() # hide
    fig = Figure(resolution=(600, 400))
    ax = Axis(fig[1, 1], backgroundcolor=:white)
    inset_ax1 = add_box_inset(fig; left=100, right=250, bottom=200, top=300,
        bgcolor=:grey90)
    inset_ax2 = add_box_inset(fig; left=500, right=600, bottom=100, top=200,
        bgcolor=(:white, 0.65))
    lines!(ax, 1:10)
    lines!(inset_ax1, 1:10)
    scatter!(inset_ax2, 1:10, color=:black)
    fig
    caption = "Figure box inset." # hide
    label = "figure_box_inset" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function scatters_in_3D()
    GLMakie.activate!() # hide
    Random.seed!(123)
    xyz = randn(10, 3)
    x, y, z = xyz[:, 1], xyz[:, 2], xyz[:, 3]
    fig = Figure(resolution=(1600, 400))
    ax1 = Axis3(fig[1, 1]; aspect=(1, 1, 1), perspectiveness=0.5)
    ax2 = Axis3(fig[1, 2]; aspect=(1, 1, 1), perspectiveness=0.5)
    ax3 = Axis3(fig[1, 3]; aspect=:data, perspectiveness=0.5)
    scatter!(ax1, x, y, z; markersize=50)
    meshscatter!(ax2, x, y, z; markersize=0.25)
    hm = meshscatter!(ax3, x, y, z; markersize=0.25,
        marker=FRect3D(Vec3f0(0), Vec3f0(1)), color=1:size(xyz)[2],
        colormap=:plasma, transparency=false)
    Colorbar(fig[1, 4], hm, label="values", height=Relative(0.5))
    fig
end

function lines_in_3D()
    GLMakie.activate!() # hide
    Random.seed!(123)
    xyz = randn(10, 3)
    x, y, z = xyz[:, 1], xyz[:, 2], xyz[:, 3]
    fig = Figure(resolution=(1600, 400))
    ax1 = Axis3(fig[1, 1]; aspect=(1, 1, 1), perspectiveness=0.5)
    ax2 = Axis3(fig[1, 2]; aspect=(1, 1, 1), perspectiveness=0.5)
    ax3 = Axis3(fig[1, 3]; aspect=:data, perspectiveness=0.5)
    lines!(ax1, x, y, z; color=1:size(xyz)[2], linewidth=3)
    scatterlines!(ax2, x, y, z; markersize=50)
    hm = meshscatter!(ax3, x, y, z; markersize=0.2, color=1:size(xyz)[2])
    lines!(ax3, x, y, z; color=1:size(xyz)[2])
    Colorbar(fig[2, 1], hm; label="values", height=15, vertical=false,
        flipaxis=false, ticksize=15, tickalign=1, width=Relative(3.55 / 4))
    fig
end

# written by Josef Heinen from GR.jl
"""
    peaks([n=49])

Return a nonlinear function on a grid.  Useful for test cases.
x, y, z
"""
function peaks(; n=49)
    x = LinRange(-3, 3, n)
    y = LinRange(-3, 3, n)
    a = 3 * (1 .- x') .^ 2 .* exp.(-(x' .^ 2) .- (y .+ 1) .^ 2)
    b = 10 * (x' / 5 .- x' .^ 3 .- y .^ 5) .* exp.(-x' .^ 2 .- y .^ 2)
    c = 1 / 3 * exp.(-(x' .+ 1) .^ 2 .- y .^ 2)
    return (x, y, a .- b .- c)
end

function plot_peaks_function()
    GLMakie.activate!() # hide
    x, y, z = peaks()
    x2, y2, z2 = peaks(; n=15)
    fig = Figure(resolution=(1600, 400), fontsize=26)
    axs = [Axis3(fig[1, i]; aspect=(1, 1, 1)) for i = 1:3]
    hm = surface!(axs[1], x, y, z)
    wireframe!(axs[2], x2, y2, z2)
    contour3d!(axs[3], x, y, z; levels=20)
    Colorbar(fig[1, 4], hm, height=Relative(0.5))
    fig
end

function heatmap_contour_and_contourf()
    GLMakie.activate!() # hide
    x, y, z = peaks()
    fig = Figure(resolution=(1600, 400), fontsize=26)
    axs = [Axis(fig[1, i]; aspect=DataAspect()) for i = 1:3]
    hm = heatmap!(axs[1], x, y, z)
    contour!(axs[2], x, y, z; levels=20)
    contourf!(axs[3], x, y, z)
    Colorbar(fig[1, 4], hm, height=Relative(0.5))
    fig
end

function heatmap_contour_and_contourf_in_a_3d_plane()
    GLMakie.activate!() # hide
    x, y, z = peaks()
    fig = Figure(resolution=(1600, 400), fontsize=26)
    axs = [Axis3(fig[1, i]) for i = 1:3]
    hm = heatmap!(axs[1], x, y, z)
    contour!(axs[2], x, y, z; levels=20)
    contourf!(axs[3], x, y, z)
    Colorbar(fig[1, 4], hm, height=Relative(0.5))
    fig
end

function mixing_surface_contour3d_contour_and_contourf()
    GLMakie.activate!() # hide
    img = testimage("coffee.png")
    x, y, z = peaks()
    cmap = :Spectral_11
    fig = Figure(resolution=(1200, 800), fontsize=26)
    ax1 = Axis3(fig[1, 1]; aspect=(1, 1, 1), elevation=pi / 6, xzpanelcolor=(:black, 0.75),
        perspectiveness=0.5, yzpanelcolor=:black, zgridcolor=:grey70,
        ygridcolor=:grey70, xgridcolor=:grey70)
    ax2 = Axis3(fig[1, 3]; aspect=(1, 1, 1), elevation=pi / 6, perspectiveness=0.5)
    hm = surface!(ax1, x, y, z; colormap=(cmap, 0.95), shading=true)
    contour3d!(ax1, x, y, z .+ 0.02; colormap=cmap, levels=20, linewidth=2)
    xmin, ymin, zmin = minimum(ax1.finallimits[])
    xmax, ymax, zmax = maximum(ax1.finallimits[])
    contour!(ax1, x, y, z; colormap=cmap, levels=20, transformation=(:xy, zmax))
    contourf!(ax1, x, y, z; colormap=cmap, transformation=(:xy, zmin))
    Colorbar(fig[1, 2], hm, width=15, ticksize=15, tickalign=1, height=Relative(0.35))
    # transformations into planes
    heatmap!(ax2, x, y, z; colormap=:viridis, transformation=(:yz, 3.5))
    contourf!(ax2, x, y, z; colormap=:CMRmap, transformation=(:xy, -3.5))
    contourf!(ax2, x, y, z; colormap=:bone_1, transformation=(:xz, 3.5))
    image!(ax2, -3 .. 3, -3 .. 2, rotr90(img); transformation=(:xy, 3.8))
    xlims!(ax2, -3.8, 3.8)
    ylims!(ax2, -3.8, 3.8)
    zlims!(ax2, -3.8, 3.8)
    fig
    caption = "Mixing surface, contour3d, contour and contourf." # hide
    label = "mixing_surface_contour3d_contour_and_contourf" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

url = "https://raw.githubusercontent.com/JuliaImages/TestImages.jl/images/images/monarch_color_256.png"
img = load(Downloads.download(url))

function arrows_and_streamplot_in_3d()
    ps = [Point3f0(x, y, z) for x = -3:1:3 for y = -3:1:3 for z = -3:1:3]
    ns = map(p -> 0.1 * rand() * Vec3f0(p[2], p[3], p[1]), ps)
    lengths = norm.(ns)
    flowField(x, y, z) = Point(-y + x * (-1 + x^2 + y^2)^2, x + y * (-1 + x^2 + y^2)^2,
        z + x * (y - z^2))
    fig = Figure(resolution=(1200, 800), fontsize=26)
    axs = [Axis3(fig[1, i]; aspect=(1, 1, 1), perspectiveness=0.5) for i = 1:2]
    # http://makie.juliaplots.org/stable/plotting_functions/arrows.html # hide
    arrows!(axs[1], ps, ns, color=lengths, arrowsize=Vec3f0(0.2, 0.2, 0.3),
        linewidth=0.1)
    streamplot!(axs[2], flowField, -4 .. 4, -4 .. 4, -4 .. 4, colormap=:plasma,
        gridsize=(7, 7), arrow_size=0.25, linewidth=1)
    fig
    caption = "Arrows and streamplot in 3d." # hide
    label = "arrows_and_streamplot_in_3d" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function mesh_volume_contour()
    # mesh objects
    rectMesh = FRect3D(Vec3f0(-0.5), Vec3f0(1))
    recmesh = GeometryBasics.mesh(rectMesh)
    sphere = Sphere(Point3f0(0), 1)
    # https://juliageometry.github.io/GeometryBasics.jl/stable/primitives/
    spheremesh = GeometryBasics.mesh(Tesselation(sphere, 64))
    # uses 64 for tesselation, a smoother sphere
    colors = [rand() for v in recmesh.position]
    # cloud points for volume
    x = y = z = 1:10
    vals = randn(10, 10, 10)
    fig = Figure(resolution=(1600, 400))
    axs = [Axis3(fig[1, i]; aspect=(1, 1, 1), perspectiveness=0.5) for i = 1:3]
    mesh!(axs[1], recmesh; color=colors, colormap=:rainbow, shading=false)
    mesh!(axs[1], spheremesh; color=(:white, 0.25), transparency=true)
    volume!(axs[2], x, y, z, vals; colormap=Reverse(:plasma))
    contour!(axs[3], x, y, z, vals; colormap=Reverse(:plasma))
    fig
end

function filled_line_and_linesegments_in_3D()
    xs = LinRange(-3, 3, 10)
    lower = [Point3f0(i, -i, 0) for i in LinRange(0, 3, 100)]
    upper = [Point3f0(i, -i, sin(i) * exp(-(i + i))) for i in range(0, 3, length=100)]
    fig = Figure(resolution=(1200, 800))
    axs = [Axis3(fig[1, i]; elevation=pi / 6, perspectiveness=0.5) for i = 1:2]
    band!(axs[1], lower, upper, color=repeat(norm.(upper), outer=2), colormap=:CMRmap)
    lines!(axs[1], upper, color=:black)
    linesegments!(axs[2], cos.(xs), xs, sin.(xs), linewidth=5, color=1:length(xs))
    fig
    caption = "Filled line and linesegments in 3D." # hide
    label = "filled_line_and_linesegments_in_3D" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end


function first_animation()
    CairoMakie.activate!() # hide
    Random.seed!(123)
    npts = 100
    initms = 8 * rand(npts) # initial marker size
    msize = Node(initms) # this is the variable that will change
    # first frame, initial plot
    fig, ax = scatter(2 * rand(npts), rand(npts); markersize=msize,
        color=initms, colormap=(:viridis, 0.75), strokewidth=0.5,
        strokecolor=:white, figure=(; resolution=(600, 400)),
        axis=(xlabel="x", ylabel="y"))
    limits!(ax, 0, 2, 0, 1)
    # the animation is done by updating the node values
    record(fig, "animScatters.mp4") do io
        for i = 1:0.1:8
            msize[] = i * initms
            recordframe!(io)  # record a new frame
        end
    end
end

function grid_spheres_and_rectangle_as_plate()
    Random.seed!(123)
    rectMesh = FRect3D(Vec3f0(-1, -1, 2.1), Vec3f0(22, 11, 0.5))
    recmesh = GeometryBasics.mesh(rectMesh)
    colors = [RGBA(rand(4)...) for v in recmesh.position]
    fig = with_theme(theme_dark()) do
        fig = Figure(resolution=(1200, 800))
        ax1 = Axis3(fig[1, 1]; aspect=:data, perspectiveness=0.5, azimuth=0.72)
        ax2 = Axis3(fig[1, 2], aspect=:data, perspectiveness=0.5)
        for i = 1:2:10, j = 1:2:10, k = 1:2:10
            sphere = Sphere(Point3f0(i, j, k), 1)
            spheremesh = GeometryBasics.mesh(Tesselation(sphere, 32))
            mesh!(ax1, spheremesh; color=RGBA(i * 0.1, j * 0.1, k * 0.1, 0.75), shading=false)
        end
        cbarPal = :plasma
        cmap = get(colorschemes[cbarPal], LinRange(0, 1, 50))
        for i = 1:2.5:20, j = 1:2.5:10, k = 1:2.5:4
            sphere = Sphere(Point3f0(i, j, k), 1)
            spheremesh = GeometryBasics.mesh(Tesselation(sphere, 32))
            mesh!(ax2, spheremesh; color=cmap[rand(1:50)], lightposition=Vec3f0(10, 5, 2),
                ambient=Vec3f0(0.95, 0.95, 0.95), backlight=1.0f0)
        end
        mesh!(recmesh; color=colors, colormap=:rainbow, shading=false)
        fig
    end
    fig
    caption = "Grid spheres and rectangle as plate." # hide
    label = "grid_spheres_and_rectangle_as_plate" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end

function histogram_or_bars_in_3d()
    x, y, z = peaks(; n=15)
    δx = (x[2] - x[1]) / 2
    δy = (y[2] - y[1]) / 2
    cbarPal = :Spectral_11
    ztmp = (z .- minimum(z)) ./ (maximum(z .- minimum(z)))
    cmap = get(colorschemes[cbarPal], ztmp)
    cmap2 = reshape(cmap, size(z))
    ztmp2 = abs.(z) ./ maximum(abs.(z)) .+ 0.15
    fig = Figure(resolution=(1200, 800), fontsize=26)
    ax1 = Axis3(fig[1, 1]; aspect=(1, 1, 1), elevation=π / 6, perspectiveness=0.5)
    ax2 = Axis3(fig[1, 2]; aspect=(1, 1, 1), perspectiveness=0.5)
    for (idx, i) in enumerate(x), (idy, j) in enumerate(y)
        rectMesh = FRect3D(Vec3f0(i - δx, j - δy, 0), Vec3f0(2δx, 2δy, z[idx, idy]))
        recmesh = GeometryBasics.mesh(rectMesh)
        mesh!(ax1, recmesh; color=cmap2[idx, idy], shading=false)
    end
    for (idx, i) in enumerate(x), (idy, j) in enumerate(y)
        rectMesh = FRect3D(Vec3f0(i - δx, j - δy, 0), Vec3f0(2δx, 2δy, z[idx, idy]))
        recmesh = GeometryBasics.mesh(rectMesh)
        lines!(ax2, recmesh; color=(cmap2[idx, idy], ztmp2[idx, idy]))
        mesh!(ax2, recmesh; color=(cmap2[idx, idy], 0.25), shading=false, transparency=true)
    end
    fig
    caption = "Histogram or bars in 3d." # hide
    label = "histogram_or_bars_in_3d" # hide
    link_attributes = "width=60%" # hide
    Options(fig; caption, label, link_attributes) # hide
end
