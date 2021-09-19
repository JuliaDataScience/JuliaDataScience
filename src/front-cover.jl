const NOTO_SANS_BOLD = assetpath("fonts", "NotoSans-Bold.ttf")
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
    front_cover(; resolution=(1200, 2400))

Return the Julia Data Science book front cover.
"""
function front_cover(; resolution=(1200, 2400))
    GLMakie.activate!()
    with_theme(theme_black()) do
        fig = Figure(; resolution)
        ax1 = Axis3(fig[1,1], perspectiveness = 0.5,  azimuth = 7.19, elevation = 0.57,
                xlabel = "x label", ylabel = "y label", zlabel = "z label",
                aspect = (1,1,1))
        ax2 = Axis(fig[2,1], aspect = AxisAspect(1))
        ax3 = Axis(fig[3,1], aspect = AxisAspect(1))
        ax4 = Axis(fig[4,1],  aspect = AxisAspect(1))
        ax5 = Axis(fig[5,1],  aspect = AxisAspect(1))
        ax6 = Axis(fig[6,1],  aspect = AxisAspect(1))
        ax7 = Axis3(fig[1,2], perspectiveness = 0.5,aspect = (1,1,1))
        ax8 = Axis3(fig[1,3],  perspectiveness = 0.5,aspect = (1,1,1))
        ax9 = Axis3(fig[2,2], perspectiveness = 0.5,aspect = (1,1,1))
        ax10 = Axis3(fig[2,3], perspectiveness = 0.5,aspect = (1,1,1))
        ax11 = Axis3(fig[2,4], perspectiveness = 0.5,aspect = (1,1,1))
        ax12 = Axis(fig[2,5], aspect = AxisAspect(1))
        #ax13 = Axis(fig[2,6], aspect = AxisAspect(1))
        ax14 = Axis3(fig[3,2:4], perspectiveness = 0.5, azimuth = 2.7074520285897967,
            elevation = 0.0701990816987234, aspect = (1, 1, 0.2))
        ax15 = Axis3(fig[4,2], perspectiveness = 0.5,aspect = (1,1,1))
        ax16 = Axis3(fig[4,3], perspectiveness = 0.5,aspect = (1,1,1))

        #ax15 = Axis3(fig[3,3], perspectiveness = 0.5, azimuth = 1π, aspect = (1,1,1))

        axs = [ax1, ax2, ax3, ax4, ax5, ax6, ax7, ax8, ax9, ax10, ax11,
            ax12, #ax13,
            ax14, ax15, ax16]

        ms = 20

        meshscatter!(ax1, positions, color = vec(vals),
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), # here, if you use less than 10, you will see smaller squares.
            colormap = :linear_grey_10_95_c0_n256, colorrange = (-2, 2),
            transparency = false,
            shading= false)

        meshscatter!(ax1, posTops, color = vec(valsTop), marker = FRect3D(Vec3f0(0), Vec3f0(7)), 
            transparency = false, colormap = (:plasma,0.65),
            shading= false, colorrange = (0,1) )
        meshscatter!(ax1, posSides, color = vec(valsSides), marker = FRect3D(Vec3f0(0), Vec3f0(7)), 
            transparency = false, colormap = (:viridis,0.65),
            shading= false, )

        meshscatter!(ax2, vec(arrTop[:,end]), color = colorTop[end:-1:1], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))

        meshscatter!(ax2, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))

        meshscatter!(ax2, vec([(j,i) for i in 0:9, j in 1:10]), shading = false,
            color = vec(vals[end:-1:1,end,:]'),
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))

        meshscatter!(ax3, vec(arrTop[1:4,end]), color = colorTop[end:-1:1][1:4], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))

        meshscatter!(ax3, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))

        meshscatter!(ax3, vec([(j,i) for i in 0:9, j in 1:4]), shading = false,
            color = vec(vals[end:-1:1,end,:]')[1:40],
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))


        meshscatter!(ax4, vec(arrTop[1:3,end]), color = colorTop[end:-1:1][1:3], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))

        meshscatter!(ax4, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))

        meshscatter!(ax4, vec([(j,i) for i in 0:9, j in 1:3]), shading = false,
            color = vec(vals[end:-1:1,end,:]')[1:30],
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))

        meshscatter!(ax5, vec(arrTop[1:2,end]), color = colorTop[end:-1:1][1:2], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))

        meshscatter!(ax5, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))

        meshscatter!(ax5, vec([(j,i) for i in 0:9, j in 1:2]), shading = false,
            color = vec(vals[end:-1:1,end,:]')[1:20],
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))


        meshscatter!(ax6, vec(arrTop[1:1,end]), color = colorTop[end:-1:1][1:1], shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :plasma, colorrange = (0,1))

        meshscatter!(ax6, vec([(0,i) for i in 0:9]), color = colorSides, shading = false,
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :viridis, colorrange = (0,1))
        meshscatter!(ax6, vec([(j,i) for i in 0:9, j in 1:1]), shading = false,
            color = vec(vals[end:-1:1,end,:]')[1:10],
            marker = FRect3D(Vec3f0(0), Vec3f0(7)), colormap = :linear_grey_10_95_c0_n256, colorrange = (-2,2))


        font = NOTO_SANS_BOLD
        Label(fig[1, 1, BottomLeft()], "|>"; textsize = 24,
            rotation = 0pi, padding = (0,3,8,0), font)
        Label(fig[2, 1, BottomLeft()], "|>"; textsize = 24,
            rotation = 0pi, font)
        Label(fig[3, 1, BottomLeft()], "|>"; textsize = 24,
            rotation = 0pi,padding = (0,3,8,0), font)

        Label(fig[4, 1, BottomLeft()], "|>"; textsize = 24,
            rotation = 0pi, padding = (0,3,8,0), font)
        Label(fig[5, 1, BottomLeft()], "|>"; textsize = 24,
            rotation = 0pi, padding = (0,3,8,0), font)

        xlims!(ax1,-1,12)
        ylims!(ax1,-1,11)
        zlims!(ax1,-1,12)

        xlims!(ax2,-0.5,11)
        ylims!(ax2,-1,11)

        xlims!(ax3,-0.5,11)
        ylims!(ax3,-1,11)

        xlims!(ax4,-0.5,11)
        ylims!(ax4,-1,11)

        xlims!(ax5,-0.5,11)
        ylims!(ax5,-1,11)

        xlims!(ax6,-0.5,11)
        ylims!(ax6,-1,11)

        [hidedecorations!(ax; grid = false) for ax in axs]
        [hidespines!(ax) for ax in axs]

        volume!(ax7, 1:10,1:10,1:10, rand(10,10,10))
        contour!(ax8, 1:10,1:10,1:10, rand(10,10,10))

        x, y, z = mypeaks()
        x2, y2, z2 = mypeaks(; n = 15)
        surface!(ax9, x, y, z)
        wireframe!(ax10, x2, y2, z2)
        contour3d!(ax11, x, y, z, levels = 15)
        contourf!(ax12, x, y, z)
        #heatmap!(ax13, x, y, z)
        lines!(ax14, x, y, z[:,20], color = z[:,21])
        scatter!(ax14, x, y, z[:,18], color = z[:,19], markersize = 20)
        meshscatter!(ax15, rand(10), rand(10), rand(10), color = :grey80, markersize = 0.05)
        lines!(ax16, rand(10), rand(10), rand(10), color = :grey80, linewidth = 2)
        Label(fig[5, 1:end], "Julia Data Science", textsize = 80)

        rowgap!(fig.layout, 0)
        colgap!(fig.layout, 0)

        #fig[1,2] = cbar
        fig
    end
end

"""
    compress_image(from::String, to::String)

Read image at `from` and write compressed image to `to`.
Based on suggestions from <https://stackoverflow.com/questions/7261855>.
"""
function compress_image(from::String, to::String; extra_args=nothing)
    args = [
        "-sampling-factor",
        "4:2:0",
        "-strip",
        "-quality",
        "85",
        "-interlace",
        "JPEG",
        # Don't use this to avoid change in appearance.
        # "-colorspace",
        # "RGB"
        extra_args...
    ]
    run(`convert $from $args $to`)
end

"""
    write_front_cover()

Write small front cover thumbnail and the full size front cover.
This smaller image is useful for reducing frontpage loading time.
"""
function write_front_cover()
    fig = front_cover()
    opts = Options(fig; filename="front_cover")
    # Writes PNG image to file.
    convert_output(nothing, nothing, opts)
    full = joinpath("_build", "im", "front_cover.png")

    thumbnail = joinpath("_build", "im", "front_cover_thumbnail.png")
    extra_args = [
        "-resize",
        "250x500"
    ]
    compress_image(full, thumbnail; extra_args)

    return nothing
end
