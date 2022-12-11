## Plot Customizations {#sec:aog_custom}

Apart from mappings inside a `mapping` layer,
you can **customize `AlgebraOfGraphics` visualizations inside the `visual` transformation layers**.

For example the `linear` statistical transformation plot from @sec:aog_stats can be customized both with the marker objects in the scatter plot but also with the line object in the linear trend plot.
We can customize anything that the `Makie.jl`'s plotting types support inside `visual`:

```jl
s = """
    # aog_custom_visual # hide
    CairoMakie.activate!() # hide
    plt = data(synthetic_df) *
        mapping(:x, :y) *
        (
            visual(Scatter; color=:steelblue, marker=:cross)
            + (
                linear() * visual(; color=:red, linestyle=:dot, linewidth=5)
            )
        )
    f = draw(plt) # hide
    draw(plt)
    label = "aog_custom_visual" # hide
    caption = "AlgebraOfGraphics customized scatter plot with linear trend estimation." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

As you can see we are adding the following keyword arguments to `visual(Scatter)` transformation layer:

- `color`: a `Symbol` for a light blue color, `:steelblue`
- `marker`: a `Symbol` for a vertical cross marker type, `:cross`

Inside the `linear` statistical transformation we are adding a new layer to be fused into it with the `*` operation,
that does not have a positional argument for plotting type since `linear` already provides a default plotting type,
and has the following keyword arguments:

- `color`: a `Symbol` for the red color, `:red`
- `linestyle`: a `Symbol` for a dotted line style, `:dot`
- `linewidth`: a number representing the width of our line

You can use as many customizations as you want in your plot.
Don't forget that if you mapping an aesthetic to a certain feature of your plot, e.g. color,
that will inhibit further color customizations in your visualization.
