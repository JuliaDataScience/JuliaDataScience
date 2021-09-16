function statistics_graph()
    u = LinRange(0, 2π, 72)
    a, b = 5.0, 2.0
    # arrow lines 
    x0 = [1, 0] # start point
    x1 = [0.75, -5] # end point
    t0 = [2, 1.0] # starting tangent vector
    t1 = [-2, 1.0] # end tangent vector
    curve = BezierCurve(x0, x1, t0, t1)
    T = range(0, 1; length=100)
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
strokewidth = 1.5
strokecolor = (:black, 0.5)
dens(ax, d, color) = density!(ax, rand(d, 1_000); strokewidth, strokecolor, color)
dens(ax1, d1, (:silver, 0.15))
dens(ax2, d2, (:grey, 0.25))
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
        ax1, rand(d1, 1_000); strokewidth=1.5, strokecolor= (:black, 0.5), color=(:silver, 0.15)
    )
    density!(
        ax2, rand(d2, 1_000); strokewidth=1.5, strokecolor= (:black, 0.5), color=(:grey, 0.25)
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
    msd = [mean(d1) - std(d1), mean(d1) + std(d1)]
    vlines!(
        ax1,
        msd;
        ymax=Distributions.pdf(d1, msd) ./ ylim_ax1,
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
        ax1,x1; strokewidth=1.5, strokecolor= (:black, 0.5), color=(:silver, 0.15)
    )
    density!(
        ax2,x2; strokewidth=1.5, strokecolor= (:black, 0.5), color=(:grey, 0.25)
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
        ax1, rand(d1, 1_000); strokewidth=1.5, strokecolor= (:black, 0.5), color=(:silver, 0.15)
    )
    density!(
        ax2, rand(d2, 1_000); strokewidth=1.5, strokecolor= (:black, 0.5), color=(:grey, 0.25)
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

function plot_corr()
    Random.seed!(123)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 600))
    corrs = [0.5, -0.5, 0.8, -0.8]
    ds = [MvNormal([1 i; i 1]) for i in corrs]
    d0 = MvNormal(2, 1)
    ax1 = Axis(
               fig[1, 1:2]; title="Correlation = $(corrs[1])", titlesize=20, limits=((-2, 2), (-2, 2))
               )
    ax2 = Axis(
               fig[1, 3:4]; title="Correlation = $(corrs[2])", titlesize=20, limits=((-2, 2), (-2, 2))
               )
    ax3 = Axis(
               fig[2, 2:3]; title="Correlation = 0", titlesize=20, limits=((-2, 2), (-2, 2))
               )
    ax4 = Axis(
               fig[3, 1:2]; title="Correlation = $(corrs[3])", titlesize=20, limits=((-2, 2), (-2, 2))
               )
    ax5 = Axis(
               fig[3, 3:4]; title="Correlation = $(corrs[4])", titlesize=20, limits=((-2, 2), (-2, 2))
               )
    scatter!(ax1, rand(ds[1], 50)'; marker=:circle, color=:dodgerblue)
    scatter!(ax2, rand(ds[2], 50)'; marker=:circle, color=:dodgerblue)
    scatter!(ax3, rand(d0, 50)'; marker=:circle, color=:dodgerblue)
    scatter!(ax4, rand(ds[3], 50)'; marker=:circle, color=:dodgerblue)
    scatter!(ax5, rand(ds[4], 50)'; marker=:circle, color=:dodgerblue)
    abline!(ax1, 0, corrs[1]; linewidth=2,linestyle=:dash, color=:red)
    abline!(ax2, 0, corrs[2]; linewidth=2,linestyle=:dash, color=:red)
    abline!(ax3, 0, 0; linewidth=2,linestyle=:dash, color=:red)
    abline!(ax4, 0, corrs[3]; linewidth=2,linestyle=:dash, color=:red)
    abline!(ax5, 0, corrs[4]; linewidth=2,linestyle=:dash, color=:red)
    rowgap!(fig.layout, 8)
    hidexdecorations!(ax1; grid=false, ticks=false)
    hidexdecorations!(ax2; grid=false, ticks=false)
    hideydecorations!(ax2; grid=false, ticks=false)
    hideydecorations!(ax5; grid=false, ticks=false)
    #hidedecorations!(ax3; grid=false, ticks=false)
    colgap!(fig.layout, 8)
    return fig
end
