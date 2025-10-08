const NOTO_SANS_BOLD = assetpath("fonts", "NotoSans-Bold.ttf")
const JuliaColors = Colors.JULIA_LOGO_COLORS
const Set1 = ColorSchemes.Set1_4
seed!(123)

myrand(x, y, z) = rand()

const FRONTX = 1:11
const FRONTY = 1:10
const FRONTZ = 1:11

function mypeaks(; n=49)
    x = LinRange(-3, 3, n)
    y = LinRange(-3, 3, n)
    a = 3 * (1 .- x') .^ 2 .* exp.(-(x' .^ 2) .- (y .+ 1) .^ 2)
    b = 10 * (x' / 5 .- x' .^ 3 .- y .^ 5) .* exp.(-x' .^ 2 .- y .^ 2)
    c = 1 / 3 * exp.(-(x' .+ 1) .^ 2 .- y .^ 2)
    return (x, y, a .- b .- c)
end

arr = [(i, j, k) for i in FRONTX[1:end-1], j in FRONTY, k in FRONTZ[1:end-1]]
positions = vec(arr)
#posRandom = vec([(i,j , k) for i in rand(12:20,5),j in rand(1:10,5), k in rand(1:10,5)])
arrTop = [(i, j, k) for i in FRONTY[1:end-1], j in FRONTY, k in FRONTZ[end]]
posTops = vec(arrTop)
arrSides = [(i, j, k) for i in FRONTZ[end], j in FRONTY, k in FRONTZ[1:end-1]]
posSides = vec(arrSides)


vals = [randn() for ix in FRONTX[1:end-1], iy in FRONTY, iz in FRONTZ[1:end-1]]
valsTop = [myrand(ix, iy, iz) for ix in FRONTY[1:end-1], iy in FRONTY, iz in FRONTZ[end]]
valsSides = [myrand(ix, iy, iz) for ix in FRONTZ[end], iy in FRONTY, iz in FRONTZ[1:end-1]]
colorTop = vec(valsTop[:, end])
colorSides = vec(valsSides[end, :])

# Based on https://github.com/JuliaPlots/Makie.jl/pull/1796.
text_element(label::Makie.Label) = only(label.blockscene.plots)

"""
    front_cover()

Return the Julia Data Science book front cover.
"""
function front_cover()
    # Probably it will be good to have two versions, one black and one white.
    # font sizes
    pipisize = 16
    titlefontsize = 48
    authorfontsize = 28
    # Markers
    ms = 14
    with_theme(theme_black(); Axis=(; ygridcolor=:grey70, xgridcolor=:grey70,
            xgridstyle=:dashdot, ygridstyle=:dashdot),
        Axis3=(; xgridcolor=:grey70, ygridcolor=:grey70, zgridcolor=:grey70)) do

        width = 2016 ÷ 3
        height = (10 / 7) * width # Ratio 7 * 10 inch.
        fig = Figure(; figure_padding=(50, 15, 5, 5), size=(width, height))
        # Colors
        colors = ColorSchemes.Set1_6
        # Axis
        ax11 = Axis3(fig[1, 1], perspectiveness=0.5, azimuth=7.19, elevation=0.57,
            xlabel="x label", ylabel="y label", zlabel="z label",
            xgridvisible=false, ygridvisible=false, zgridvisible=false,
            aspect=(1, 1, 1))
        #ax12 = Axis3(fig[1,2]; perspectiveness = 0.5, aspect = (1,1,1)) # empty is ok, that's the idea... Q, how could u plot this kind of data
        ax21 = Axis(fig[2, 1], aspect=AxisAspect(1)) # xgridvisible=false, ygridvisible=false) # we can include this on the theme
        ax31 = Axis(fig[3, 1], aspect=AxisAspect(1)) # xgridvisible=false, ygridvisible=false)
        ax41 = Axis(fig[4, 1], aspect=AxisAspect(1)) # xgridvisible=false, ygridvisible=false)
        ax22 = Axis3(fig[2, 2], perspectiveness=0.5, aspect=(1, 1, 1)) # xgridvisible=false, ygridvisible=false, zgridvisible=false)
        #ax23 = Axis3(fig[2,3]; perspectiveness = 0.5, aspect = (1,1,1)) # empty is ok, that's the idea... Q, how could u plot this kind of data, alternatives
        ax32 = Axis(fig[3, 2], aspect=1) # xgridvisible=false, ygridvisible=false)
        ax33 = Axis(fig[3, 3], aspect=1) # xgridvisible=false, ygridvisible=false)
        ax42 = Axis(fig[4, 2], aspect=1) # xgridvisible=false, ygridvisible=false)
        ax43 = Axis(fig[4, 3], aspect=1) # xgridvisible=false, ygridvisible=false)
        ax44 = Axis(fig[4, 4], aspect=1) # xgridvisible=false, ygridvisible=false)
        ax45 = Axis(fig[4, 5], aspect=1) # xgridvisible=false, ygridvisible=false)
        axBubbles = Axis(fig[1:end, 1:end]; xgridvisible=false, ygridvisible=false)
        axs = [ax11, ax21, ax31, ax41,
            ax22, #ax23,
            ax32, ax33,
            ax42, ax43, ax44, ax45,
            axBubbles,
        ]
        # First Column 1,1 to 4,1
        meshscatter!(ax11, positions, color=vec(vals),
            marker=Rect3d(Vec3f(0), Vec3f(7)), # here, if you use less than 10, you will see smaller squares.
            colormap=:linear_grey_10_95_c0_n256, colorrange=(-2, 2),
            transparency=false,
            shading=NoShading)
        meshscatter!(ax11, posTops, color=vec(valsTop), marker=Rect3d(Vec3f(0), Vec3f(7)),
            transparency=false, colormap=(:plasma, 0.65),
            shading=NoShading, colorrange=(0, 1))
        meshscatter!(ax11, posSides, color=vec(valsSides), marker=Rect3d(Vec3f(0), Vec3f(7)),
            transparency=false, colormap=(:viridis, 0.65),
            shading=NoShading)
        meshscatter!(ax21, vec(arrTop[:, end]), color=colorTop[end:-1:1], shading=NoShading,
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:plasma, colorrange=(0, 1))
        meshscatter!(ax21, vec([(0, i) for i = 0:9]), color=colorSides, shading=NoShading,
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:viridis, colorrange=(0, 1))
        meshscatter!(ax21, vec([(j, i) for i = 0:9, j = 1:10]), shading=NoShading,
            color=vec(vals[end:-1:1, end, :]'),
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:linear_grey_10_95_c0_n256, colorrange=(-2, 2))
        meshscatter!(ax31, vec(arrTop[1:2, end]), color=colorTop[end:-1:1][1:2], shading=NoShading,
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:plasma, colorrange=(0, 1))
        meshscatter!(ax31, vec([(0, i) for i = 0:9]), color=colorSides, shading=NoShading,
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:viridis, colorrange=(0, 1))
        meshscatter!(ax31, vec([(j, i) for i = 0:9, j = 1:2]), shading=NoShading,
            color=vec(vals[end:-1:1, end, :]')[1:20],
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:linear_grey_10_95_c0_n256, colorrange=(-2, 2))
        meshscatter!(ax41, vec(arrTop[1:1, end]), color=colorTop[end:-1:1][1:1], shading=NoShading,
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:plasma, colorrange=(0, 1))
        meshscatter!(ax41, vec([(0, i) for i = 0:9]), color=colorSides, shading=NoShading,
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:viridis, colorrange=(0, 1))
        meshscatter!(ax41, vec([(j, i) for i = 0:9, j = 1:1]), shading=NoShading,
            color=vec(vals[end:-1:1, end, :]')[1:10],
            marker=Rect3d(Vec3f(0), Vec3f(7)), colormap=:linear_grey_10_95_c0_n256, colorrange=(-2, 2))
        # Limits
        xlims!(ax11, -1, 12)
        ylims!(ax11, -1, 11)
        zlims!(ax11, -1, 12)
        xlims!(ax21, -0.5, 11)
        ylims!(ax21, -1, 11)
        xlims!(ax31, -0.5, 11)
        ylims!(ax31, -1, 11)
        xlims!(ax41, -0.5, 11)
        ylims!(ax41, -1, 11)
        # Second Columns 2,2 to 4,2
        x, y, z = mypeaks()
        surface!(ax22, x, y, z; colormap=:plasma)
        # contourf!(ax23, x, y, z; colormap = :bone_1)
        x = rand(10)
        y = rand(10)
        z = rand(10)
        # Third Row 3,2 to to 3,3
        scatter!(ax32, rand(10), rand(10); color="Yellow", markersize=16)
        lines!(ax33, 0 .. 10, x -> exp(-x); color=JuliaColors.red, linewidth=4)
        limits!(ax32, -0.1, 1.1, -0.1, 1.1)
        limits!(ax33, -1, 11, -0.1, 1.1)
        # Fourt Row 4,2 to 4,5
        hist!(ax42, randn(1000), bins=32; color="Yellow", strokewidth=1.5,
            strokecolor=:grey80)
        density!(ax43, randn(1000); color=JuliaColors.red,
            strokewidth=2, strokecolor=JuliaColors.red)
        violin!(ax44, fill(1, 1000), randn(1000); color=(JuliaColors.purple, 0.5),
            strokewidth=2, strokecolor=JuliaColors.purple, show_median=true)
        boxplot!(ax45, fill(1, 1000), randn(1000); color=JuliaColors.green, strokecolor=:grey80,
            whiskercolor=JuliaColors.green, whiskerwidth=1, strokewidth=1)
        scatter!(axBubbles, rand(Distributions.Normal(1, 1), 1500), rand(Distributions.Normal(1, 1), 1500);
            color=1:1500, markersize=8 * rand(1500),
            colormap=tuple.(to_colormap(:thermal), rand(256) .+ 0.15),
            marker=:rect)
        limits!(axBubbles, -2.2, 2, -3.3, 2)
        xlims!(ax44, 0.1, 1.9)
        xlims!(ax45, 0.1, 1.9)
        ylims!(ax42, 0, 150)
        ylims!(ax43, 0, 0.55)
        ylims!(ax44, -5.6, 5.5)
        ylims!(ax45, -5.6, 5.5)
        # Pipes for First Column
        Label(fig[1, 1, Bottom()], "|>", fontsize=pipisize,
            rotation=-π / 2, padding=(0, 0, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[2, 1, Bottom()], "|>", fontsize=pipisize,
            rotation=-π / 2, padding=(0, 0, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[3, 1, Bottom()], "|>", fontsize=pipisize,
            rotation=-π / 2, padding=(0, 0, 0, 0), font=NOTO_SANS_BOLD)
        # Pipes between columns
        Label(fig[2, 1, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[3, 1, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[3, 2, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[4, 1, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[4, 2, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[4, 3, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)
        Label(fig[4, 4, Right()], "|>", fontsize=pipisize,
            rotation=0π, padding=(5, 5, 0, 0), font=NOTO_SANS_BOLD)

        legJ = Label(fig[1, 3:5], "Julia", fontsize=titlefontsize * 3,
            tellheight=false, halign=:left, font=NOTO_SANS_BOLD)
        translate!(text_element(legJ), 0, 0, 9)
        legD = Label(fig[1, 3:5], "\n\n\n\nData Science", fontsize=titlefontsize,
            tellheight=false, halign=:left, font=NOTO_SANS_BOLD)
        translate!(text_element(legD), 0, 0, 9)
        vspace = "\n\n"
        hspace = "         "
        legJose = Label(fig[2, 3:5], "$(vspace)$(hspace)Jose Storopoli", fontsize=authorfontsize,
            tellheight=false, halign=:left, font=NOTO_SANS_BOLD)
        legRik = Label(fig[2, 3:5], "$(vspace)\n\n$(hspace)Rik Huijzer", fontsize=authorfontsize,
            tellheight=false, halign=:left, font=NOTO_SANS_BOLD)
        legLaz = Label(fig[2, 3:5], "$(vspace)\n\n\n\n$(hspace)Lazaro Alonso", fontsize=authorfontsize,
            tellheight=false, halign=:left, font=NOTO_SANS_BOLD)
        translate!(text_element(legJose), 0, 0, 9)
        translate!(text_element(legRik), 0, 0, 9)
        translate!(text_element(legLaz), 0, 0, 9)
        #     fontsize = 60, tellheight = false)
        # Final Axis and Figure touches
        [hidedecorations!(ax; grid=false) for ax in axs]
        [hidespines!(ax) for ax in axs]
        rowgap!(fig.layout, 0)
        colgap!(fig.layout, 0)
        return fig
    end
end
