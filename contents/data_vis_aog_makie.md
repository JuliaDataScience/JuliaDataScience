## Makie.jl and AlgebraOfGraphics.jl {#sec:aog_makie}

Since `AlgebraOfGraphics.jl` uses **`Makie.jl` as a backend**,
most of **advanced customizations** such as layouts are only possible by interacting directly with `Makie.jl`.
`Makie.jl` layouts uses `Figure`, `Axis` and other types (see @sec:makie_layouts).

You can instantiate a `Figure` and use the *mutating* `draw!` function to draw a layer into an existing `Figure` or `Axis`.
It is preferable to pass a `GridPosition`,
e.g. `fig[1, 1]`,
instead of an `Axis` because `draw!` can pass `Axis` attributes,
such as axis labels and axis tick labels,
to the underlying visualization.
If you pass an `Axis` to `draw!` these attributes need to be specified again as keyword arguments inside `Axis`:

```julia
fig = Figure()

# preferable
draw!(fig[1, 1], plt)

# avoid
ax = Axis(fig[1, 1])
draw!(ax, plt)
```

As an example, let's create an advanced layout by combining `Makie.jl` with `AlgebraOfGraphics.jl`.
We'll use visualizations that had been already covered in this chapter:

```jl
s = """
    # aog_makie # hide
    CairoMakie.activate!() # hide
    # Figure
    fig = Figure()

    # First Axis
    plt_barplot = data(df) *
        mapping(
            :name,
            :grade;
            color=:year,
            dodge=:year) *
    visual(BarPlot)
    subfig1 = draw!(fig[1, 1], plt_barplot)

    # Second Axis
    plt_custom = data(synthetic_df) *
        mapping(:x, :y) *
        (
            visual(Scatter; color=:steelblue, marker=:cross)
            + (
                linear() *
                    subvisual(:prediction; color=:red, linestyle=:dot, linewidth=5) *
                    subvisual(:ci; color=(:red, 0.15))
            )
        )
    subfig2 = draw!(fig[2, 1:2], plt_custom)

    # Third Axis
    plt_expectation = data(df) *
        mapping(:name, :grade) *
        expectation()
    subfig3 = draw!(fig[1, 2], plt_expectation)

    # Insert the legend
    legend!(
        fig[end+1, 1:2],
        subfig1;
        orientation=:horizontal,
        tellheight=true
    )

    # Recover the Figure
    fig
    label = "aog_makie" # hide
    caption = "AlgebraOfGraphics custom layout with Makie." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Here, we are instantiating a `Figure` called `fig`.
Then, we proceed by creating three `Layer`s that have the prefix `plt_`.
Each one of these are followed by a `draw!` with the desired `fig`'s `GridPosition` as the first position argument followed by the `Layer` as the second argument.
Furthermore, we use `AlgebraOfGraphics.jl`'s `legend!` to add the legend to the visualization.
They way `legend!` works is by passing first the desired `fig`'s `GridPosition` for the placement of the legend,
and the desired legend labels.
For the legend's label, we use the output of the `draw!` function that was called in the `Layer`s  and that has legend labels already,
in our case the `plt_barplot`.
All of the `Legend`/`axislegend` keyword arguments (@sec:datavisMakie_attributes) can be used in `legend!`.
Finally, as the last step, we call the Figure, `fig`,  to recover it after it was mutated by all of the mutating "bang" functions,
e.g. `draw!` and `legend!`,
in order to render our visualization.

> ***NOTE:***
> Don't forget to check [`AlgebraOfGraphics.jl` documentation](https://aog.makie.org) for additional examples.
