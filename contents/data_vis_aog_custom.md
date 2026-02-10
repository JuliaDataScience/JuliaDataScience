## Plot Customizations {#sec:aog_custom}

Apart from mappings inside a `mapping` layer,
you can **customize `AlgebraOfGraphics` visualizations inside the `visual` transformation layers**.

For example the `linear` statistical transformation plot from @sec:aog_stats can be customized both with the marker objects in the scatter plot but also with the line object in the linear trend plot.
We can customize anything that the `Makie.jl`'s plotting types support inside `visual`:

```jl
s = """
    # aog_custom_visual # hide
    CairoMakie.activate!() # hide
    blue = visual(Scatter; color=:steelblue, marker=:cross)
    red = linear() *
        subvisual(:prediction; color=:red, linestyle=:dot, linewidth=5) *
        subvisual(:ci; color=(:red, 0.15))
    plt = data(synthetic_df) * mapping(:x, :y) * (blue + red)
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

The `linear` transformation creates two labeled layers: `:prediction` (the trend line) and `:ci` (the confidence band).
We use `subvisual` to style each layer independently, applying attributes that are valid for each plot type:

- `:prediction` line: `color=:red`, `linestyle=:dot`, `linewidth=5`
- `:ci` band: `color=(:red, 0.15)` (semi-transparent red)

You can use as many customizations as you want in your plot.
