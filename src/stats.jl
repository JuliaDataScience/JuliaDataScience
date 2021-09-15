u = LinRange(0, 2π, 72)
a, b = 5.0, 2.0
function ellipse(u; a = 2, b = 3, h = 0, k = 0)
    Point2f(h + a/2*cos(u), k + b/2*sin(u))
end

# https://github.com/dronir/Bezier.jl
# it's not longer in the registery 
struct BezierCurve
    Xcoef::Vector{Float64}
    Ycoef::Vector{Float64}
end

function BezierCurve(r0::Vector, r1::Vector, t0::Vector, t1::Vector)
    X = bezier_coefs(r0[1], r1[1], t0[1], t1[1])
    Y = bezier_coefs(r0[2], r1[2], t0[2], t1[2])
    return BezierCurve(X, Y)
end

function (curve::BezierCurve)(t::Real)
    out = zeros(2)
    for i = 1:4
        out[1] += curve.Xcoef[i] * t^(4-i)
        out[2] += curve.Ycoef[i] * t^(4-i)
    end
    return out
end


# Give coefficients of one Bezier curve component
function bezier_coefs(x0::Real, x1::Real, t0::Real, t1::Real)
    a = 2(x0-x1) + t1 + t0
    b = 3(x1-x0) - t1 - 2t0
    c = t0
    d = x0
    return [a,b,c,d]
end

function statistics_graph()
    u = LinRange(0, 2π, 72)
    a, b = 5.0, 2.0
    # arrow lines 
    x0 = [1, 0] # start point
    x1 = [0.75, -5] # end point
    t0 = [2, 1.0] # starting tangent vector
    t1 = [-2, 1.0] # end tangent vector
    curve = BezierCurve(x0, x1, t0, t1)
    T = range(0, 1 ; length=100)
    points = [curve(t) for t in T]
    points = hcat(points...)';
    ##
    fig, ax, = lines(ellipse.(u);  
        figure = (;resolution = (600,400)),
        axis = (; aspect = 1))
    lines!(ellipse.(u; a = 1.5, b = 3, k = -5))
    lines!(points[:,1], points[:,2])
    lines!(-points[:,1], points[:,2])
    arrows!([points[end-5, 1]], [points[end-5, 2]], 
        [-0.1], [0],  arrowsize = 20, lengthscale = 0.2)
    arrows!([-points[5, 1]], [points[5, 2]], 
        [0.1], [0],  arrowsize = 20, lengthscale = 0.2)
     
    text!("Data\nGenerating\nProcess", position = (0,0), 
        align = (:center, :center), textsize = 24)
    text!("Observed\nData", position = (0,-5), 
        align = (:center, :center), textsize = 24)
    text!("Inference", position = (-1.2,-2.5), textsize = 24)
    text!("Probability", position = (0.65,-2.5), textsize = 24, 
        align = (:center, :center))
    hidedecorations!(ax)
    hidespines!(ax)
    return fig
end

function more_grades()
    df1 = all_grades()
    df2 = DataFrame(; name=["Bob", "Sally", "Hank", "Alice"], grade=[6.5, 7.0, 6.0, 5.5])
    return vcat(df1, df2)
end

function plot_central()
    Random.seed!(123)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1 = Distributions.Normal(10)
    d2 = LogNormal(log(10), log(1.5))
    density!(
        ax1, rand(d1, 1_000); strokewidth=1.5, strokecolor= (:black,0.5), color=(:silver, 0.15)
    )
    density!(
        ax2, rand(d2, 1_000); strokewidth=1.5, strokecolor= (:black,0.5), color=(:grey, 0.25)
    )
    # colorbrewer2 palettes
    ylim_ax1 = 0.38
    vlines!(
        ax1,
        mean(d1);
        ymax=Distributions.pdf(d1, mean(d1)) / ylim_ax1,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label="mean",
    )
    vlines!(
        ax1,
        median(d1);
        ymax=Distributions.pdf(d1, median(d1)) / ylim_ax1,
        color= :red,
        linewidth=3,
        linestyle = :dot,
        label="median",
    )
    vlines!(
        ax1,
        mode(d1);
        ymax=Distributions.pdf(d1, mode(d1)) / ylim_ax1,
        color="black",
        linewidth=3,
        linestyle = :dashdot,
        label="mode",
    )
    #ylims!(ax1, 0, ylim_ax1)
    ylim_ax2 = 0.105
    vlines!(
        ax2,
        mean(d2);
        ymax=Distributions.pdf(d2, mean(d2)) / ylim_ax2,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label="mean",
    )
    vlines!(
        ax2,
        median(d2);
        ymax=Distributions.pdf(d2, median(d2)) / ylim_ax2,
        color="red",
        linewidth=3,
        linestyle = :dot,
        label="median",
    )
    vlines!(
        ax2,
        mode(d2);
        ymax = Distributions.pdf(d2, mode(d2)) / ylim_ax2,
        color="black",
        linewidth=3,
        linestyle = :dashdot,
        label="mode",
    )
    #ylims!(ax2, 0, ylim_ax2)
    #ylims!(ax1, 0, ylim_ax1)

    hidexdecorations!(ax1; grid = false, ticks = false)
    #hideydecorations!(ax1; grid = false)
    #hideydecorations!(ax2; grid = false)
    #fig[1:2, 2] = Legend(fig, ax2)
    axislegend(ax1, position = :rt)
    rowgap!(fig.layout, 8)
    return fig
end

function plot_dispersion_std()
    Random.seed!(123)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1 = Distributions.Normal(10)
    d2 = LogNormal(log(10), log(1.5))
    density!(
        ax1, rand(d1, 1_000); strokewidth=1.5, strokecolor= (:black,0.5), color=(:silver, 0.15)
    )
    density!(
        ax2, rand(d2, 1_000); strokewidth=1.5, strokecolor= (:black,0.5), color=(:grey, 0.25)
    )
    # colorbrewer2 palettes
    ylim_ax1 = 0.38
    vlines!(
        ax1,
        mean(d1);
        ymax=Distributions.pdf(d1, mean(d1)) / ylim_ax1,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label=L"\mu",
    )
    vlines!(
        ax1,
        [mean(d1) - std(d1), mean(d1) + std(d1)];
        ymax=Distributions.pdf(d1, [mean(d1) - std(d1), mean(d1) + std(d1)]) ./ ylim_ax1,
        color= :red,
        linewidth=3,
        linestyle = :dot,
        label=L"1 \cdot \sigma",
    )
    #ylims!(ax1, 0, ylim_ax1)
    ylim_ax2 = 0.105
    vlines!(
        ax2,
        mean(d2);
        ymax=Distributions.pdf(d2, mean(d2)) / ylim_ax2,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label=L"\mu",
    )
    vlines!(
        ax2,
        [mean(d2) - std(d2), mean(d2) + std(d2)];
        ymax=Distributions.pdf(d2, [mean(d2) - std(d2), mean(d2) + std(d2)]) ./ ylim_ax2,
        color="red",
        linewidth=3,
        linestyle = :dot,
        label=L"1 \cdot \sigma",
    )
    #ylims!(ax2, 0, ylim_ax2)
    #ylims!(ax1, 0, ylim_ax1)

    hidexdecorations!(ax1; grid = false, ticks = false)
    #hideydecorations!(ax1; grid = false)
    #hideydecorations!(ax2; grid = false)
    #fig[1:2, 2] = Legend(fig, ax2)
    axislegend(ax1, position = :rt)
    rowgap!(fig.layout, 8)
    return fig
end

function plot_dispersion_mad()
    Random.seed!(123)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1 = Distributions.Normal(10)
    d2 = LogNormal(log(10), log(1.5))
    x1 = rand(d1, 1_000)
    x2 = rand(d2, 1_000)
    density!(
        ax1,x1; strokewidth=1.5, strokecolor= (:black,0.5), color=(:silver, 0.15)
    )
    density!(
        ax2,x2; strokewidth=1.5, strokecolor= (:black,0.5), color=(:grey, 0.25)
    )
    # colorbrewer2 palettes
    ylim_ax1 = 0.38
    vlines!(
        ax1,
        median(d1);
        ymax=Distributions.pdf(d1, median(d1)) / ylim_ax1,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label="median",
    )
    vlines!(
        ax1,
        [median(d1) - mad(x1), median(d1) + mad(x1)];
        ymax=Distributions.pdf(d1, [median(d1) - mad(x1), median(d1) + mad(x1)]) ./ ylim_ax1,
        color= :red,
        linewidth=3,
        linestyle = :dot,
        label=L"1 \cdot MAD",
    )
    #ylims!(ax1, 0, ylim_ax1)
    ylim_ax2 = 0.105
    vlines!(
        ax2,
        median(d2);
        ymax=Distributions.pdf(d2, median(d2)) / ylim_ax2,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label="median",
    )
    vlines!(
        ax2,
        [median(d2) - mad(x2), median(d2) + mad(x2)];
        ymax=Distributions.pdf(d2, [median(d2) - mad(x2), median(d2) + mad(x2)]) ./ ylim_ax2,
        color="red",
        linewidth=3,
        linestyle = :dot,
        label=L"1 \cdot MAD",
    )
    #ylims!(ax2, 0, ylim_ax2)
    #ylims!(ax1, 0, ylim_ax1)

    hidexdecorations!(ax1; grid = false, ticks = false)
    #hideydecorations!(ax1; grid = false)
    #hideydecorations!(ax2; grid = false)
    #fig[1:2, 2] = Legend(fig, ax2)
    axislegend(ax1, position = :rt)
    rowgap!(fig.layout, 8)
    return fig
end

function plot_dispersion_iqr()
    Random.seed!(123)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1 = Distributions.Normal(10)
    d2 = LogNormal(log(10), log(1.5))
    density!(
        ax1, rand(d1, 1_000); strokewidth=1.5, strokecolor= (:black,0.5), color=(:silver, 0.15)
    )
    density!(
        ax2, rand(d2, 1_000); strokewidth=1.5, strokecolor= (:black,0.5), color=(:grey, 0.25)
    )
    # colorbrewer2 palettes
    ylim_ax1 = 0.38
    vlines!(
        ax1,
        median(d1);
        ymax=Distributions.pdf(d1, median(d1)) / ylim_ax1,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label="median",
    )
    vlines!(
        ax1,
        quantile(d1, 0.25);
        ymax=Distributions.pdf(d1, quantile(d1, 0.25)) / ylim_ax1,
        color= :red,
        linewidth=3,
        linestyle = :dot,
        label="Q1",
    )
    vlines!(
        ax1,
        quantile(d1, 0.75);
        ymax=Distributions.pdf(d1, quantile(d1, 0.75)) / ylim_ax1,
        color="black",
        linewidth=3,
        linestyle = :dashdot,
        label="Q3",
    )
    vspan!(
        ax1,
        quantile(d1, 0.25),
        quantile(d1, 0.75);
        color=(:green, 0.3),
        #linewidth=3,
        #linestyle = :dashdot,
        label="IQR",
    )
    #ylims!(ax1, 0, ylim_ax1)
    ylim_ax2 = 0.105
    vlines!(
        ax2,
        median(d2);
        ymax=Distributions.pdf(d2, median(d2)) / ylim_ax2,
        color= :dodgerblue,
        linewidth=3,
        linestyle = :solid,
        label="median",
    )
    vlines!(
        ax2,
        quantile(d2, 0.25);
        #ymax=Distributions.pdf(d2, quantile(d2, 0.25)) / ylim_ax1,
        color="red",
        linewidth=3,
        linestyle = :dot,
        label="Q1",
    )
    vlines!(
        ax2,
        quantile(d2, 0.75);
        #ymax=Distributions.pdf(d2, quantile(d2, 0.75)) / ylim_ax1,
        color="black",
        linewidth=3,
        linestyle = :dashdot,
        label="Q3",
    )
    vspan!(
        ax2,
        quantile(d2, 0.25),
        quantile(d2, 0.75);
        color=(:green, 0.3),
        #linewidth=3,
        #linestyle = :dashdot,
        label="IQR",
    )
    #ylims!(ax2, 0, ylim_ax2)
    #ylims!(ax1, 0, ylim_ax1)

    hidexdecorations!(ax1; grid = false, ticks = false)
    #hideydecorations!(ax1; grid = false)
    #hideydecorations!(ax2; grid = false)
    #fig[1:2, 2] = Legend(fig, ax2)
    axislegend(ax1, position = :rt)
    rowgap!(fig.layout, 8)
    return fig
end
