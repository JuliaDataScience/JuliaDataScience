## Colors and Colormaps {#sec:makie_colors}

Choosing an appropriate set of colors or colorbar for your plot is an essential part when presenting results.
Using [Colors.jl](https://github.com/JuliaGraphics/Colors.jl) is supported in `Makie.jl`
so that you can use [named colors](https://juliagraphics.github.io/Colors.jl/latest/namedcolors/) or pass `RGB` or `RGBA` values.
Additionally, colormaps from [ColorSchemes.jl](https://github.com/JuliaGraphics/ColorSchemes.jl) and [PerceptualColourMaps.jl](https://github.com/peterkovesi/PerceptualColourMaps.jl) can also be used.
It is worth knowing that you can reverse a colormap by doing `Reverse(:colormap_name)`
and obtain a transparent color or colormap with `color=(:red,0.5)` and `colormap=(:viridis, 0.5)`.

Different use cases will be shown next. Then we will define a custom theme with new colors and a colorbar palette.

By default `Makie.jl` has a predefined set of colors in order to cycle through them automatically, as shown in the previous figures, where no specific color was set.
Overwriting these defaults is done by calling the keyword `color` in the plotting function and specifying a new color via a `Symbol` or `String`.
See this in action in the following example:

```jl
@sco JDS.set_colors_and_cycle()
```

Where, in the first two lines we have used the keyword `color` to specify our color.
The rest is using the default cycle set of colors.
Later, we will learn how to do a custom cycle.

Regarding colormaps, we are already familiar with the keyword `colormap` for heatmaps and scatters.
Here, we show that a colormap can also be specified via a `Symbol` or a `String`, similar to colors.
Or, even a vector of `RGB` colors.
Let's do our first example by calling colormaps as a `Symbol`, `String` and `cgrad` for categorical values.
See `?cgrad` for more information.

```jl
scolor = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    fig, ax, pltobj = heatmap(rand(20, 20); colorrange=(0, 1),
        colormap=Reverse(:viridis), axis=axis, figure=figure)
    Colorbar(fig[1, 2], pltobj, label = "Reverse colormap Sequential")
    fig
    label = "Reverse_colormap_sequential" # hide
    caption = "Reverse colormap sequential and colorrange." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(scolor)
```
<!--
Here, `ax` is not used. Thus, it should be replaced with `_`, depending on the
decision you have chosen (see my comment in <data_vis_make_themes.md>).
(In case there should be more of these instances in the following examples,
I'll not mark them.)
-->

When setting a `colorrange` usually the values outside this range are colored with the first and last color from  the colormap.
However, sometimes is better to specify the color you want at both ends. We do that with `highclip` and `lowclip`:

```
using ColorSchemes
```

```jl
s = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    fig, ax, pltobj=heatmap(randn(20, 20); colorrange=(-2, 2),
        colormap="diverging_rainbow_bgymr_45_85_c67_n256",
        highclip=:black, lowclip=:white, axis=axis, figure=figure)
    Colorbar(fig[1, 2], pltobj, label = "Diverging colormap")
    fig
    label = "diverging_colormap" # hide
    caption = "Diverging Colormap with low and high clip." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(s)
```

But we mentioned that also `RGB` vectors are valid options.
For our next example you could pass the custom colormap _perse_ or use `cgrad` to force a categorical `Colorbar`.

```
using Colors, ColorSchemes
```

```jl
scat = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    cmap = ColorScheme(range(colorant"red", colorant"green", length=3))
    mygrays = ColorScheme([RGB{Float64}(i, i, i) for i in [0.0, 0.5, 1.0]])
    fig, ax, pltobj = heatmap(rand(-1:1, 20, 20);
        colormap=cgrad(mygrays, 3, categorical=true, rev=true), # cgrad and Symbol, mygrays,
        axis=axis, figure=figure)
    cbar = Colorbar(fig[1, 2], pltobj, label="Categories")
    cbar.ticks = ([-0.66, 0, 0.66], ["-1", "0", "1"])
    fig
    label = "categorical_colormap" # hide
    caption = "Categorical Colormap." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(scat)
```

Lastly, the ticks in the colorbar for the categorial case are not centered by default in each color.
This is fixed by passing custom ticks, as in `cbar.ticks = (positions, ticks)`.
The last situation is when passing a tuple of two colors to `colormap` as symbols, strings or a mix.
You will get an interpolated colormap between these two colors.

Also, hexadecimal coded colors are also accepted. So, on top or our heatmap let's put one semi-transparent point using this.

```jl
s2color2 = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    fig, ax, pltobj = heatmap(rand(20, 20); colorrange=(0, 1),
        colormap=(:red, "black"), axis=axis, figure=figure)
    scatter!(ax, [11], [11], color=("#C0C0C0", 0.5), markersize=150)
    Colorbar(fig[1, 2], pltobj, label="2 colors")
    fig
    label = "colormap_two_colors" # hide
    caption = "Colormap from two colors." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(s2color2)
```

### Custom cycle

Here, we could define a global `Theme` with a new cycle for colors, however that is **not the recommend way** to do it.
It's better to define a new theme and use as shown before.
Lets define a new one with a `cycle` for `:color`, `:linestyle`, `:marker` and a new `colormap` default.
Lets add this new attributes to our previous `publication_theme`.

```jl
@sc new_cycle_theme()
```

And apply it to a plotting function like the following:

```jl
@sc scatters_and_lines()
```

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(scatters_and_lines, new_cycle_theme())
    label = "custom_cycle" # hide
    caption = "Custom theme with new cycle and colormap." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

At this point you should be able to have **complete control** over your colors, line styles, markers and colormaps for your plots.
Next, we will dive into how to manage and control **layouts**.
