function getPenguins()
    ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"
    penguins = dropmissing(DataFrame(PalmerPenguins.load()))
    return penguins
end

function plotPenguins()
    CairoMakie.activate!() # hide
    penguins = getPenguins() # hide
    palette = (color = tuple.(["#FC7808", "#8C00EC","#107A78"], 0.65),
        marker = [:circle, :utriangle, :rect])
    cycle = Cycle([:color, :marker], covary = true)
    with_theme(palette = palette, Scatter = (cycle = cycle,)) do
        fig = Figure(resolution = (600, 400))
        ax = Axis(fig[1,1], title = "Flipper and bill length",
            xlabel="Flipper length (mm)", ylabel="Bill length (mm)")
        for penguin in ["Adelie", "Chinstrap", "Gentoo"]
            specie = filter(:species => ==(penguin), penguins)
            x = specie[!,:flipper_length_mm]
            y = specie[!,:bill_length_mm]
            scatter!(ax, x, y; markersize = 12, label = penguin)
        end
        #Legend(fig[1,2], ax, "Penguin species", position = :rb) # hide
        axislegend("Penguin species", position = :rb,
            bgcolor = (:grey90, 0.15), titlesize = 12, labelsize = 12)
        fig
    end
    caption = "Palmer Penguins." # hide
    label = "plotPenguins" # hide
    link_attributes = "width=70%" # hide
    Options(current_figure(); caption, label, link_attributes) # hide
end

function simple_lm() # hide
    penguins = getPenguins() # hide
    specie = filter(:species => ==("Adelie"), penguins) # hide
    X = specie[!,:flipper_length_mm] # hide
    Y = specie[!,:bill_length_mm] # hide
    linearModel = lm(@formula(Y ~ X), DataFrame(X=X, Y=Y))
    ŷ = predict(linearModel)
end # hide

function plot_lm()
    CairoMakie.activate!() # hide
    penguins = getPenguins() # hide
    specie = filter(:species => ==("Adelie"), penguins) # hide
    X = specie[!, :flipper_length_mm] # hide
    Y = specie[!, :bill_length_mm] # hide
    linearModel = lm(@formula(Y ~ X), DataFrame(X = X, Y = Y)) # hide
    ŷ = predict(linearModel) # hide
    fig = Figure(resolution = (600, 400))
    ax = Axis(fig[1,1], title="Flipper and bill length, Adelie",
        xlabel="Flipper length (mm)", ylabel="Bill length (mm)")
    scatter!(ax, X, Y; color=("#FC7808", 0.75), label = "observations")
    lines!(ax, X, ŷ; color=:black, linewidth = 2, label = "linear fit")
    axislegend()
    fig
    caption = "Plot linear regression." # hide
    label = "plot_lms" # hide
    link_attributes = "width=70%" # hide
    Options(fig; caption, label, link_attributes) # hide
end
