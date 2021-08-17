function first_plot_with_AoG()
    CairoMakie.activate!() # hide 
    Random.seed!(123)
    df = (x = rand(50), y=rand(50))
    xy = data(df) * mapping(:x, :y) * visual(color=:gray15, markersize=15)
    draw(xy; figure = (; resolution=(600, 400)))
end

function example_plot()
    I = 1:30
    df = (x=I, y=I.^2)
    xy = data(df) * mapping(:x, :y)
    fg = draw(xy)
end