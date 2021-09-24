const NOTO_SANS_BOLD = assetpath("fonts", "NotoSans-Bold.ttf")
const JuliaColors = Colors.JULIA_LOGO_COLORS
const Set1 = ColorSchemes.Set1_4
Random.seed!(123)

myrand(x,y,z) = rand()

const FRONTX = 1:11
const FRONTY = 1:10
const FRONTZ = 1:11

function mypeaks(; n = 49)
    x = LinRange(-3, 3, n)
    y = LinRange(-3, 3, n)
    a = 3 * (1 .- x').^2 .* exp.(-(x'.^2) .- (y .+ 1).^2)
    b = 10 * (x' / 5 .- x'.^3 .- y.^5) .* exp.(-x'.^2 .- y.^2)
    c = 1 / 3 * exp.(-(x' .+ 1).^2 .- y.^2)
    return (x, y, a .- b .- c)
end

arr = [(i, j, k) for i in FRONTX[1:end-1],j in FRONTY, k in FRONTZ[1:end-1]]
positions = vec(arr)
#posRandom = vec([(i,j , k) for i in rand(12:20,5),j in rand(1:10,5), k in rand(1:10,5)])
arrTop = [(i, j, k) for i in FRONTY[1:end-1],j in FRONTY, k in FRONTZ[end]]
posTops = vec(arrTop)
arrSides = [(i, j, k) for i in FRONTZ[end],j in FRONTY, k in FRONTZ[1:end-1]]
posSides = vec(arrSides)


vals = [randn() for ix in FRONTX[1:end-1], iy in FRONTY, iz in FRONTZ[1:end-1]]
valsTop = [myrand(ix,iy,iz) for ix in FRONTY[1:end-1], iy in FRONTY, iz in FRONTZ[end]]
valsSides = [myrand(ix,iy,iz) for ix in FRONTZ[end], iy in FRONTY, iz in FRONTZ[1:end-1]]
colorTop =  vec(valsTop[:,end])
colorSides =  vec(valsSides[end,:])


"""
    front_cover()

Return the Julia Data Science book front cover.
"""
function front_cover()
    GLMakie.activate!()
    with_theme(theme_black()) do
        # Figure
        fig = Figure(resolution=(1768,2652))
        # Colors
        colors = ColorSchemes.Set1_6
        #colors = Makie.wong_colors()
        # Markers
        ms = 20
        # Axis
        ax11 = Axis3(fig[1,1], perspectiveness = 0.5,  azimuth = 7.19, elevation = 0.57,
                 xlabel = "x label", ylabel = "y label", zlabel = "z label",
                 xgridvisible=false, ygridvisible=false, zgridvisible=false,
                 aspect = (1,1,1))
        ax21 = Axis(fig[2,1], aspect = AxisAspect(1), xgridvisible=false, ygridvisible=false)
        ax31 = Axis(fig[3,1], aspect = AxisAspect(1), xgridvisible=false, ygridvisible=false)
        ax41 = Axis(fig[4,1],  aspect = AxisAspect(1), xgridvisible=false, ygridvisible=false)
        ax22 = Axis3(fig[2,2], perspectiveness = 0.5, aspect = (1,1,1), xgridvisible=false, ygridvisible=false, zgridvisible=false)
        # ax23 = Axis(fig[2,3], aspect = AxisAspect(1), xgridvisible=false, ygridvisible=false)
        ax32 = Axis(fig[3,2], aspect = 1, xgridvisible=false, ygridvisible=false)
        ax33 = Axis(fig[3,3], aspect = 1, xgridvisible=false, ygridvisible=false)
        ax42 = Axis(fig[4,2], aspect = 1, xgridvisible=false, ygridvisible=false)
        ax43 = Axis(fig[4,3], aspect = 1, xgridvisible=false, ygridvisible=false)
        ax44 = Axis(fig[4,4], aspect = 1, xgridvisible=false, ygridvisible=false)
        ax45 = Axis(fig[4,5], aspect = 1, xgridvisible=false, ygridvisible=false)
        axs = [ax11, ax21, ax31, ax41,
               ax22, #ax23,
               ax32, ax33,
               ax42, ax43, ax44, ax45
              ]
        # First Column 1,1 to 4,1
        meshscatter!(ax11, positions, color = vec(vals),
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), # here, if you use less than 10, you will see smaller squares.
            colormap = :linear_grey_10_95_c0_n256, colorrange = (-2, 2),
            transparency = false,
            shading= false)
        meshscatter!(ax11, posTops, color = vec(valsTop), marker = FRect3D(Vec3f0(0), Vec3f0(7)),
            transparency = false, colormap = (:plasma,0.65),
            shading= false, colorrange = (0,1) )
        meshscatter!(ax11, posSides, color = vec(valsSides), marker = FRect3D(Vec3f0(0), Vec3f0(7)),
            transparency = false, colormap = (:viridis,0.65),
            shading= false, )
        meshscatter!(ax21, vec(arrTop[:,end]), color = colorTop[end:-1:1], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))
        meshscatter!(ax21, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))
        meshscatter!(ax21, vec([(j,i) for i in 0:9, j in 1:10]), shading = false,
            color = vec(vals[end:-1:1,end,:]'),
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))
        meshscatter!(ax31, vec(arrTop[1:2,end]), color = colorTop[end:-1:1][1:2], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))
        meshscatter!(ax31, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))
        meshscatter!(ax31, vec([(j,i) for i in 0:9, j in 1:2]), shading = false,
            color = vec(vals[end:-1:1,end,:]')[1:20],
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))
        meshscatter!(ax41, vec(arrTop[1:1,end]), color = colorTop[end:-1:1][1:1], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))
        meshscatter!(ax41, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))
        meshscatter!(ax41, vec([(j,i) for i in 0:9, j in 1:1]), shading = false,
            color = vec(vals[end:-1:1,end,:]')[1:10],
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))
        # Limits
        xlims!(ax11,-1,12)
        ylims!(ax11,-1,11)
        zlims!(ax11,-1,12)
        xlims!(ax21,-0.5,11)
        ylims!(ax21,-1,11)
        xlims!(ax31,-0.5,11)
        ylims!(ax31,-1,11)
        xlims!(ax41,-0.5,11)
        ylims!(ax41,-1,11)
        # Second Columns 2,2 to 4,2
        x, y, z = peaks()
        surface!(ax22, x, y, z; colormap = :plasma)
        # contourf!(ax23, x, y, z; colormap = :bone_1)
        x = rand(10)
        y = rand(10)
        z = rand(10)
        # Third Row 3,2 to to 3,3
        scatter!(ax32, rand(10), rand(10); color = JuliaColors.blue, markersize = 16)
        lines!(ax33, 0..10, x -> exp(-x); color = JuliaColors.red, linewidth = 4)
        limits!(ax32, -0.5, 1.5, -0.5, 1.5)
        limits!(ax33, -1, 15, -0.5, 1.5)
        # Fourt Row 4,2 to 4,5
        hist!(ax42, randn(1000), bins = 32; color = JuliaColors.blue, strokewidth = 1.5,
            strokecolor = :grey80)
        density!(ax43, randn(1000); color = JuliaColors.red,
            strokewidth = 2, strokecolor = JuliaColors.red)
        violin!(ax44, fill(1,1000), randn(1000); color = (JuliaColors.purple, 0.5),
            strokewidth = 2, strokecolor = JuliaColors.purple, show_median = true,)
        boxplot!(ax45, fill(1,1000), randn(1000); color = JuliaColors.green, strokecolor = :grey80,
            whiskercolor = JuliaColors.green, whiskerwidth = 1, strokewidth = 1)
        xlims!(ax44, 0,2)
        xlims!(ax45, 0,2)
        ylims!(ax42, 0,150)
        ylims!(ax43, 0,0.55)
        ylims!(ax44, -6,6)
        ylims!(ax45, -6,6)
        # Pipes for First Column
        Label(fig[1, 1, Bottom()], "|>", textsize = 52,
              rotation = -π/2, padding = (0,3,8,0),font = NOTO_SANS_BOLD)
        Label(fig[2, 1, BottomLeft()], " |>", textsize = 52,
              rotation = -π/2, padding = (0,3,8,0), font = NOTO_SANS_BOLD)
        Label(fig[3, 1, BottomLeft()], " |>", textsize = 52,
              rotation = -π/2, padding = (0,3,8,0), font = NOTO_SANS_BOLD)
        # Pipes between columns
        Label(fig[2,1, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        Label(fig[3,1, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        Label(fig[3,2, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        Label(fig[4,1, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        Label(fig[4,2, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        Label(fig[4,3, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        Label(fig[4,4, Right()], "|>", textsize = 40,
              rotation = 0π, padding = (0,0,0,0), font = NOTO_SANS_BOLD)
        # Title and Text Stuff
        Label(fig[0, 2:5, Bottom()], "Julia\nData Science", textsize = 120,
            tellheight = false, halign = :left)
        Label(fig[3, 3:end], "Jose Storopoli", #color = JuliaColors.purple,
            textsize = 60, tellheight = false, halign = :left)
        Label(fig[3, 3:end], "\n\nRik Huijzer", #color = JuliaColors.red,
            textsize = 60, tellheight = false, halign = :left)
        Label(fig[3, 3:end], "\n\n\n\nLazaro Alonso", #color = JuliaColors.green,
            textsize = 60, tellheight = false, halign = :left)
        # Label(fig[3, 3:end], "Jose Storopoli, Rik Huijzer\n and Lazaro Alonso",
        #     textsize = 60, tellheight = false)
        # Final Axis and Figure touches
        [hidedecorations!(ax; grid = false) for ax in axs]
        [hidespines!(ax) for ax in axs]
        rowgap!(fig.layout, 0)
        colgap!(fig.layout, 0)
        #save("front_cover.png", fig) # no need to compress image
        #display(fig)
        return fig
    end
end
