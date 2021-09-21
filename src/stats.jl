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

function normal_dist(mean, std; seed=123)
    Random.seed!(seed)
    d = Distributions.Normal(mean, std)
    return d, rand(d, 1_000)
end

function lognormal_dist(mean, std; seed=123)
    Random.seed!(seed)
    d = LogNormal(log(mean), log(std))
    return d, rand(d, 1_000)
end


dens(ax, rand_d, color) = density!(ax, rand_d; color=color, strokewidth=1.5, strokecolor=(:black, 0.5))

function plot_central()
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1, rand_d1 = normal_dist(10, 1) 
    d2, rand_d2 = lognormal_dist(10, 1.5)
    dens(ax1, rand_d1, (:silver, 0.15))
    dens(ax2, rand_d2, (:grey, 0.25))
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
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1, rand_d1 = normal_dist(10, 1) 
    d2, rand_d2 = lognormal_dist(10, 1.5)
    dens(ax1, rand_d1, (:silver, 0.15))
    dens(ax2, rand_d2, (:grey, 0.25))
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
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1, rand_d1 = normal_dist(10, 1) 
    d2, rand_d2 = lognormal_dist(10, 1.5)
    dens(ax1, rand_d1, (:silver, 0.15))
    dens(ax2, rand_d2, (:grey, 0.25))
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
        [median(d1) - mad(rand_d1), median(d1) + mad(rand_d1)];
        ymax=Distributions.pdf(d1, [median(d1) - mad(rand_d1), median(d1) + mad(rand_d1)]) ./ ylim_ax1,
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
        [median(d2) - mad(rand_d2), median(d2) + mad(rand_d2)];
        ymax=Distributions.pdf(d2, [median(d2) - mad(rand_d2), median(d2) + mad(rand_d2)]) ./ ylim_ax2,
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
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((3, 20), nothing))
    ax2 = Axis(fig[2, 1]; limits=((3, 20), nothing))
    d1, rand_d1 = normal_dist(10, 1) 
    d2, rand_d2 = lognormal_dist(10, 1.5)
    dens(ax1, rand_d1, (:silver, 0.15))
    dens(ax2, rand_d2, (:grey, 0.25))
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

function plot_normal_lognormal()
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; limits=((3, 20), nothing))
    _, rand_d1 = normal_dist(10, 1) 
    _, rand_d2 = lognormal_dist(10, 1.3)
    density!(ax, rand_d1; color=(:dodgerblue, 0.15), strokewidth=1.5, strokecolor=(:black, 0.5), label="normal")
    density!(ax, rand_d2; color=(:red, 0.15), strokewidth=1.5, strokecolor=(:black, 0.5), label="non-normal")
    axislegend(ax, position = :rt)
    return fig
end

function plot_discrete_continuous()
    Random.seed!(123)
    discrete = Binomial(10, 0.6)
    continuous = Distributions.Normal(6, 2)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; limits=((0.5, 10.5), nothing), title="Discrete", titlesize=20)
    ax2 = Axis(fig[1, 2]; limits=((-1, 13), nothing), title="Continuous", titlesize=20)
    hist!(ax1, rand(discrete, 1_000); color=(:dodgerblue, 0.5), strokewidth=1.5, strokecolor=(:black, 0.5), bins=10, normalization=:pdf)
    density!(ax2, rand(continuous, 1_000); color=(:red, 0.5), strokewidth=1.5, strokecolor=(:black, 0.5))
    hidedecorations!(ax1)
    hidedecorations!(ax2)
    return fig
end

function plot_pmf()
    dice = DiscreteUniform(1, 6)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; xticks=1:6, limits=(nothing, (0, 0.2)))
    barplot!(ax, 1:6, Distributions.pdf(dice, 1:6); color=(:grey, 0.25), strokewidth=1.5, strokecolor=(:black, 0.5))
    return fig
end

function plot_pdf()
    d = Distributions.Normal()
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; xticks=-3:3)
    range = -3:0.01:3.0
    subset = 1:0.01:2.0
    band!(ax, range, fill(0, length(range)), Distributions.pdf(d, range); color=(:grey, 0.25), strokewidth=1.5, strokecolor=(:black, 0.5))
    band!(ax, subset, fill(0, length(subset)), Distributions.pdf(d, subset); color=(:red, 0.25), strokewidth=1.5, strokecolor=(:black, 0.5))
    return fig
end

function plot_cdf(type::AbstractString)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 400))
    if type == "discrete"
        d = Distributions.DiscreteUniform(1,6)
        range = 1:6
        ax = Axis(fig[1, 1]; xticks=1:6)
    elseif type == "continuous"
        d = Distributions.Normal()
        range = -3:0.01:3.0
        ax = Axis(fig[1, 1]; xticks=-3:3)
    end
    lines!(ax, range, Distributions.cdf(d, range); linewidth=4, color=(:black, 0.5))
    return fig
end

function calculate_pdf(a, b; d=Distributions.Normal())
    return round(cdf(d, b) - cdf(d, a); digits=2)
end

function anscombe_quartet(;type="long")
    dataset = repeat(1:4; inner=11)
    x = [10.0  8.0  13.0  9.0  11.0  14.0  6.0  4.0  12.0  7.0  5.0;
         8.0  8.0  8.0  8.0  8.0  8.0  8.0  19.0  8.0  8.0  8.0]
    y = [8.04 9.14 7.46 6.58;
         6.95 8.14 6.77 5.76;
         7.58 8.74 12.74 7.71;
         8.81 8.77 7.11 8.84;
         8.33 9.26 7.81 8.47;
         9.96 8.1  8.84 7.04;
         7.24 6.13 6.08 5.25;
         4.26 3.1  5.39 12.5;
         10.84 9.13 8.15 5.56;
         4.82 7.26 6.42 7.91;
         5.68 4.74 5.73 6.89]
    if type == "long"
        x = vcat(repeat(x[1, :]; outer=3), x[2, :])
        y = (reshape(y, 11 * 4))
        return DataFrame(; dataset, x, y)
    elseif type == "wide"
        return DataFrame(; x_1=x[1, :], y_1=y[:, 1], x_2=x[1, :], y_2=y[:, 2],
                         x_3=x[1, :], y_3=y[:, 3], x_4=x[2, :], y_4=y[:, 4])
    else
        return nothing
    end
end

function plot_anscombe()
    df = anscombe_quartet()
    filter_anscombe(idx) = filter(row -> row.dataset == idx, df)
    CairoMakie.activate!() # hide
    fig = Figure(; resolution=(600, 600))
    axs = [Axis(fig[i, j]; limits=((3, 20), (2.5, 14)),
                xticks=4:2:20, yticks=2:14)
           for i in 1:2, j in 1:2]
    for i in 1:4
        df_filter = Matrix(filter_anscombe(i)[!, 2:3])
        abline!(axs[i], 3, 0.5; linewidth=2, linestyle=:dash, color=:red)
        scatter!(axs[i], df_filter; marker=:circle, color=:dodgerblue)
        hidedecorations!(axs[i]; grid=false, ticks=false)
    end
    rowgap!(fig.layout, 8)
    colgap!(fig.layout, 8)
    return fig
end

