function more_grades()
    df1 = all_grades()
    df2 = DataFrame(; name=["Bob", "Sally", "Hank"], grade=[6.5, 7.0, 6.0])
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
    density!(ax1, rand(d1, 1_000); strokewidth=1.5, strokecolor=:black, color=("#6EE2FF", 0.25))
    density!(ax2, rand(d2, 1_000); strokewidth=1.5, strokecolor=:black, color=("#FF410D", 0.25))
    # colorbrewer2 palettes
    ylim_ax1 = 0.38
    vlines!(ax1, mean(d1); ymax=Distributions.pdf(d1, mean(d1)) / ylim_ax1, color="#7FC97F", linewidth=3, label="mean")
    vlines!(ax1, median(d1); ymax=Distributions.pdf(d1, median(d1)) / ylim_ax1, color="#BEAED4", linewidth=3, label="median")
    vlines!(ax1, mode(d1); ymax=Distributions.pdf(d1, mode(d1)) / ylim_ax1, color="#FDC086", linewidth=3, label="mode")
    ylims!(ax1, 0, ylim_ax1)
    ylim_ax2 = 0.105
    vlines!(ax2, mean(d2); ymax=Distributions.pdf(d2, mean(d2)) / ylim_ax2, color="#7FC97F", linewidth=3, label="mean")
    vlines!(ax2, median(d2); ymax=Distributions.pdf(d2, median(d2)) / ylim_ax2, color="#BEAED4", linewidth=3, label="median")
    vlines!(ax2, mode(d2); ymax=Distributions.pdf(d2, mode(d2)) / ylim_ax2, color="#FDC086", linewidth=3, label="mode")
    ylims!(ax2, 0, ylim_ax2)
    hidedecorations!(ax1)
    hidedecorations!(ax2)
    fig[1:2, 2] = Legend(fig, ax1)
    return fig
end

