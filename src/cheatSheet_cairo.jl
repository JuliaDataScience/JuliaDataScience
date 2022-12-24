using GLMakie, CairoMakie
using Random
using SparseArrays
using TestImages
using Pkg
using Dates
using FileIO

function dep_version(depname)
    deps = Pkg.dependencies()
    version = first(d for d in deps if d.second.name == depname).second.version
    "$depname: v$version"
end

function cheatsheet_cairomakie()
    packages = ["Makie", "CairoMakie"]
    Random.seed!(123)
    CairoMakie.activate!()
    x = 0:0.5:2π
    set_theme!(theme_light())

    fig = Figure(resolution=(1000, 1600))
    axs = [Axis(fig[i, j], aspect=1) for i = 1:7 for j = 1:5]

    lines!(axs[1], x, sin.(x))
    axs[1].title = "lines(x, y)"

    scatter!(axs[2], x, sin.(x); color=:black)
    axs[2].title = "scatter(x, y)"

    scatterlines!(axs[3], x, sin.(x); color=:red)
    axs[3].title = "scatterlines(x, y)"

    stem!(axs[4], x, sin.(x); color=x)
    axs[4].title = "stem(x, y)"

    linesegments!(axs[5],
        Point2f.(vec([[x, rand()] for i = 1:2, x in rand(10)]));
        color=1:20, colormap=:gnuplot)
    axs[5].title = "linesegments(positions)"

    series!(axs[6], rand(10, 5); color=resample_cmap(:plasma, 10))
    axs[6].title = "series(curves)"

    ablines!(axs[7], x, sin.(x); color=resample_cmap(:viridis, length(x)))
    axs[7].title = "ablines(inter, slopes)"

    stairs!(axs[8], -2.5:0.2:2.5, x -> exp(-x^2); color=:dodgerblue)
    axs[8].title = "stairs(x, y)"

    vlines!(axs[9], [pi, 2pi, 3pi]; color=:orangered)
    axs[9].title = "vlines(x, y)"

    hlines!(axs[10], [pi, 2pi, 3pi]; color=:black)
    axs[10].title = "hlines(x, y)"

    vspan!(axs[11], [0, 2pi, 4pi], [pi, 3pi, 5pi];
        color=1:3, colormap=(:blues, 0.5))
    axs[11].title = "vspan(xs_low, xs_high)"

    hspan!(axs[12], [0, 2pi, 4pi], [pi, 3pi, 5pi];
        color=1:3, colormap=(:reds, 0.5))
    axs[12].title = "hspan(ys_low, ys_high)"

    spy!(axs[13], 0 .. 1, 0 .. 1, sprand(100, 100, 0.05);
        markersize=4, marker=:rect,
        framecolor=:lightgrey,
        colormap=[:black, :red])
    axs[13].title = "spy(x, y, sparseArray)"

    rangebars!(axs[14], rand(5), -rand(5), rand(5);
        whiskerwidth=10, color=1:5)
    axs[14].title = "rangebars(vals, lo, hi)"

    errorbars!(axs[15], rand(5), -rand(5), rand(5);
        whiskerwidth=15)
    axs[15].title = "errorbars(vals, lo, hi)"

    band!(axs[16], x, sin.(x) .- 0.05 * rand(size(x)),
        sin.(x) .+ 0.05 * rand(size(x)), color=(:black, 0.25))
    axs[16].title = "band(x, y-σ, y+σ)"

    crossbar!(axs[17], [1, 2, 3, 4], [1, 2, 3, 4],
        [1, 2, 3, 4] .- 1, [1, 2, 3, 4] .+ 1;
        color=1:4, colormap=[:grey70, :red, :yellow],
        show_notch=true)
    axs[17].title = "crossbar(x,y,ymin,ymax)"

    barplot!(axs[18], [1, 2, 3], rand(3); color=1:3,
        colormap=[:black, :dodgerblue, :gold])
    axs[18].title = "barplot(x,y)"

    hist!(axs[19], randn(1000); color=:values,
        colormap=[:black, :dodgerblue, :grey95])
    axs[19].title = "hist(x)"

    density!(axs[20], randn(1000); normalization=:pdf,
        color=(:grey90, 0.35), strokewidth=2,
        strokecolor=:black, linestyle=:dash)
    axs[20].title = "density(x)"
    xbox = rand(1:3, 1000)
    boxplot!(axs[21], xbox, randn(1000), color=xbox,
        mediancolor=:black, colormap=[:grey, :dodgerblue, :yellow])
    axs[21].title = "boxplot(x, y)"

    violin!(axs[22], xbox, randn(1000), color=:black,
        show_median=true, mediancolor=:white)
    axs[22].title = "boxplot(x, y)"

    ecdfplot!(axs[23], randn(1000), color=:black, npoints=10)
    axs[23].title = "ecdfplot(x)"

    rainclouds!(axs[24], fill("A", 1000), randn(1000);
        orientation=:horizontal, color=(:snow3, 0.75))
    axs[24].title = "rainclouds(cat, y)"

    qqplot!(axs[25], randn(1000), randn(1000);
        qqline=:identity, color=:red, markercolor=:transparent,
        strokewidth=0.2, strokecolor=(:black, 0.5))
    axs[25].title = "qqplot(x, y)"

    poly!(axs[26], [Point2f(0.5, 0.0), Point2f(1, 0.5), Point2f(0.5, 1), Point2f(0, 0.5)];
        color=(:snow3, 0.5), strokewidth=3, strokecolor=:dodgerblue)
    axs[26].title = "poly(points)"

    pie!(axs[27], [0.1, 0.5, 0.2, 0.2];
        color=resample_cmap(:Hiroshige, 4), inner_radius=0.2)
    axs[27].title = "pie(fractions)"

    contour!(axs[28], 0 .. 1, 0 .. 1, rand(20, 20);
        colormap=:Hiroshige)
    axs[28].title = "contour(x,y,vals)"

    xs = LinRange(-4, 4, 15)
    ys = LinRange(-4, 4, 15)
    us = [x + y for x in xs, y in ys]
    vs = [y - x for x in xs, y in ys]
    strength = vec(sqrt.(us .^ 2 .+ vs .^ 2))

    arrows!(axs[29], xs, ys, us, vs;
        arrowsize=5, lengthscale=0.1,
        arrowcolor=strength, linecolor=strength,
        colormap=:Hiroshige)
    axs[29].title = "arrows(x,y,u,v)"

    semiStable(x, y) = Point2f(-y + x * (-1 + x^2 + y^2)^2, x + y * (-1 + x^2 + y^2)^2)
    streamplot!(axs[30], semiStable, -4 .. 4, -4 .. 4,
        gridsize=(24, 24), arrow_size=8)
    axs[30].title = "streamplot(f, x, y)"

    contourf!(axs[31], 0 .. 1, 0 .. 1, rand(20, 20);
        colormap=:plasma)
    axs[31].title = "contourf(x,y,vals)"

    heatmap!(axs[32], 0 .. 1, 0 .. 1, rand(20, 20), colormap=:linear_kbc_5_95_c73_n256)
    axs[32].title = "heatmap(x,y,vals)"

    image!(axs[33], 0 .. 1, 0 .. 1, rotr90(testimage("earth_apollo17")))
    axs[33].title = "image(x,y,img)"
    vertices = [
        0.0 0.0
        1.0 0.0
        1.0 1.0
        0.0 1.0
    ]
    facesm = [
        1 2 3
        3 4 1
    ]
    colors = [:black, :red, :dodgerblue, :orange]
    mesh!(axs[34], vertices, facesm; color=colors)
    axs[34].title = "mesh(v,f)"

    waterfall!(axs[35], randn(5); show_direction=true,
        color=:black)
    axs[35].title = "waterfall(x, y)"
    hidedecorations!.(axs, grid=false, ticks=false)

    Label(fig[end+1, :], rich("Learn more at ", rich("https://juliadatascience.io,", fontsize=18, color=:dodgerblue, font=:bold), " https://docs.makie.org, " * join([dep_version(x) for x in packages], " ") * ", Updated: $(today())"))
    Label(fig[0, :], rich("Plotting Functions in Makie.jl ::", rich(" CHEAT SHEET", fontsize=32, font=:bold, color=:black), fontsize=32))
    ax0 = Axis(fig[0, 1], aspect=1, height=60)
    image!(ax0, rotr90(load(joinpath("images", "logoMakie.png"))))
    lines!(fig.scene, [22, 978], [1520, 1520], linestyle=:dash)
    lines!(fig.scene, [22, 978], [37, 37], linestyle=:dot, color=:grey)
    hidedecorations!(ax0)
    colgap!(fig.layout, 5)
    rowgap!(fig.layout, 8)
    fig
end
#fig = cheatsheet_cairomakie()
#save("cheatsheet_cairo.png", fig)
