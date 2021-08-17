# Data Visualization {#sec:dataviz}

Data visualization it is a vital part of almost any data analysis process.
Here, in this chapter, we will consider several packages that can be used in Julia, namely `Plots.jl`, `StatsPlots.jl`, `Makie.jl` and `AlgebraOfGraphics.jl`.
The latter is especially useful for tabular data.

- Overview of the JuliaPlots ecosystem

## Plots.jl {#sec:plots}
Plots is ....

The default backend is GR.

```
using Plots, LaTeXStrings
```
```jl
@sco JDS.test_plots_layout()
```

### Layouts {#sec:layouts}

- Overview on several ways to do layouts
- the layout argument, also cover the grid
- the `@layout` macro
- specific measures with the Plots.PlotMeasures submodule (additionally a footnote to say that we have it in StatsPlots.PlotMeasures also)
- adding subplots incremententally. Define p1, p2, p3; then do a plot(p1, p2, p3; layout=l)

### Animations {#sec:plots-animations}

Doing an animation with Plots is quite easy.

### Other backends {#sec:backends}

Plotly, PGFPlotsX, PyPlot?

## StatsPlots.jl {#sec:statsplots}

1. A brief intro and show that is is really just "syntactic sugar" for Plots.jl.
    Also note that works on all Plots.jl stuff:

- Backends
- Attributes
- Colours
- Layouts
- Animations
- Themes
2. Works on Types of Distributions and DataFrames, but we will only focus on DataFrames

3. the `@df` macro and the Symbols (:col1, :col2) instead of other input data (vectors, arrays, tuples etc.)

4. Recipes (I would cover almost all of them, except for andrewsplot MDS plot, Dendograms, QQ-Plot etc., since they are specific for modeling or simulation):

- histogram, histogram2d and ea_histogram
- groupedhist and groupedbar
- boxplot
- dotplot
- violin
- marginalhist, marginalkde and marginalscatter
- corrplot and cornerplot

## Makie.jl {#sec:makie}

> From the japanese word Maki-e, which is a technique to sprinkle lacquer with gold and silver powder.
> Data is the gold and silver of our age, so let's spread it out beautifully on the screen!
>
> _Simon Danisch, Creator of `Makie.jl`_

[Makie.jl](http://makie.juliaplots.org/stable/index.html#Welcome-to-Makie!) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.
In our opinion, it is the prettiest and most versatile plotting package.

`Makie.jl` is the frontend package that defines all plotting functions.
It is reexported by every backend _(the machinery behind-the-scenes making the figure)_, so you don't have to specifically install or import it.
There are three main backends which concretely implement all abstract rendering capabilities defined in Makie.
One for non-interactive 2D publication-quality vector graphics: `CairoMakie.jl`.
Another for interactive 2D and 3D plotting in standalone `GLFW.jl` windows (also GPU-powered), `GLMakie.jl`.
And the third one, a WebGL-based interactive 2D and 3D plotting that runs within browsers, `WGLMakie.jl`. [See Makie's documentation for more](http://makie.juliaplots.org/stable/backends_and_output.html#Backends-and-Output).

In this book we will only show examples for `CairoMakie.jl` and `GLMakie.jl`.

You can activate any backend by using the appropriate package and calling its `activate!` function.
For example:

```
using GLMakie
GLMakie.activate!()
```

Now, we will start with publication-quality plots.

### CairoMakie.jl {#sec:cairomakie}

Let's start with our first plot, a not so boring example but still simple enough, e.g. a line and some scatter points:

```
using CairoMakie
CairoMakie.activate!()
```

```jl
s = """
    CairoMakie.activate!() # hide
    scatterlines(1:10, 1:10)
    filename = "firstplot" # hide
    Options(current_figure(); filename, caption="First plot.", label="firstplot") # hide
    """
sco(s)
```

The previous plot is the default output, which we probably need to tweak by using axis names and labels.

Also note that every plotting function like `scatterlines` creates and returns a new `Figure`, `Axis` and `plot` object in a collection called `FigureAxisPlot`.
These are known as the `non-mutating` methods.
On the other hand, the `mutating` methods (e.g. `scatterlines!`, note the `!`) just return a plot object which can be appended into a given `axis` or the `current_figure()`.

The next question that one might have is: how do I change the color or the marker type?
This can be done via `attributes`, which we do in the next section.

### Attributes

A custom plot can be created by using `attributes`.
The attributes can be set through keyword arguments.
A list of `attributes` for every plotting object can be viewed via:

```jl
s = """
    CairoMakie.activate!() # hide
    fig, ax, pltobj = scatterlines(1:10)
    pltobj.attributes
    """
sco(s)
```
or as a `Dict` calling `pltobject.attributes.attributes`.

Asking for help in the `REPL` as `?lines` or `help(lines)` for any given plotting function will show you their corresponding attributes plus a short description on how to use that specific function, e.g.:

```jl
s = """
    help(lines)
    """
sco(s)
```

But not only the plot objects have attributes, also the `Axis` and `Figure` objects do.
For example, for Figure, we have `backgroundcolor`, `resolution`, `font` and `fontsize` and the [figure_padding](http://makie.juliaplots.org/stable/figure.html#Figure-padding) which changes the amount of space around the figure content, see the grey area in the plot.
It can take one number for all sides, or a tuple of four numbers for left, right, bottom and top.

`Axis` has a lot more, some of them are  `backgroundcolor`, `xgridcolor` and `title`.
For a full list just type `help(Axis)`.

Hence, for our next plot we will call several attributes at once as follows:

```jl
s = """
    CairoMakie.activate!() # hide
    figure = (; figure_padding=5, resolution=(600,400),
        backgroundcolor=:grey90, fontsize=16, font="sans")

    axis = (; xlabel="x", ylabel="x²", title="title",
        backgroundcolor=:white, xgridstyle=:dash, ygridstyle=:dash)

    lines(1:10, (1:10).^2; color=:black, linewidth=2, linestyle=:dash, figure, axis)

    filename = "custom_plot" # hide
    Options(current_figure(); filename, caption="Custom plot.", label=filename) # hide
    """
sco(s)
```

This example has already most of the attributes that most users will normally use.
Probably, a `legend` will also be good to have.
Which for more than one function will make more sense.
So, let's `append` another mutation `plot object` and add the corresponding legends by calling `axislegend`.
This will collect all the `labels` you might have passed to your plotting functions (@fig:custom_plot_leg):

```jl
s = """
    CairoMakie.activate!() # hide 
    lines(1:10, (1:10).^2; label = "x²", linewidth = 2, linestyle = nothing,
        figure = (; figure_padding = 5, resolution = (600,400),
            backgroundcolor = :grey90, fontsize = 16, font = "sans"),
        axis = (; xlabel = "x", title = "title", backgroundcolor = :white,
            xgridstyle=:dash, ygridstyle=:dash))
    scatterlines!(1:10, (10:-1:1).^2; label = "Reverse(x)²")
    axislegend("legend"; position = :ct)
    current_figure()
    label = "custom_plot_leg" # hide
    Options(current_figure(); label, filename=label, caption="Custom plot legend.") # hide
    """
sco(s)
```

However, having to write this so much code just for two lines can become cumbersome
and tired.
So if you plan on doing a lot of plots with the same general aesthetics then setting a theme will be better.
We can do this with `set_theme!()` as the following example illustrates, not a particular good set of attributes but you'll get the idea.

```jl
s = """
    CairoMakie.activate!() # hide
    set_theme!(resolution = (600,400), backgroundcolor = (:orange, 0.5),
        fontsize = 16, font = "sans",
        Axis = (backgroundcolor = :white, xgridstyle=:dash, ygridstyle=:dash),
        Legend = (bgcolor = (:red,0.2), framecolor = :dodgerblue)
        )

    lines(1:10, (1:10).^2; label = "x²", linewidth = 2, linestyle = nothing,
        axis = (; xlabel = "x", title = "title"))
    scatterlines!(1:10, (10:-1:1).^2; label = "Reverse(x)²")
    axislegend("legend"; position = :ct)
    current_figure()
    set_theme!() # in order to go back to the default settings.
    label = "setTheme" # hide
    Options(current_figure(); filename=label, caption="set theme", label) # hide
    """
sco(s)
```

For more on `themes` please go to @sec:themes.

Before moving on into the next section, it's worthwhile to see an example where an `array` of attributes are passed at once to a plotting function.
For this example, we will use the `scatter` plotting function to do a bubble plot.

```jl
s = """
    let
        CairoMakie.activate!() # hide
        Random.seed!(123)
        n = 100
        fig, ax, pltobj = scatter(randn(n), randn(n); color = randn(n),
            label = "Bubbles",colormap = :plasma, markersize = 25*rand(n),
            figure = (; resolution = (550,400)), axis = (; aspect= DataAspect()))
        limits!(-3, 3, -3, 3)
        Legend(fig[1,2], ax, valign = :top)
        Colorbar(fig[1,2], pltobj, height = Relative(3/4))
        fig
        label = "bubbleplot" # hide
        Options(current_figure(); filename=label, caption="Bubble plot", label) # hide
    end
    """
sco(s)
```

where we have decomposed the tuple `FigureAxisPlot` into `fig, ax, pltobj`, in order to be able to add a `Legend` and `Colorbar` outside of the plot object.
We will discuss layout options in more detail in @sec:makie_layouts.

We have done some basic but still interesting examples to show how to use `Makie.jl` and by now you might be wondering, what else can we do?
What are all the possible plotting functions available in `Makie.jl`?
To answer this question, a _cheat sheet_ is shown in @fig:cheat_sheet_cairomakie.
These work especially well with `CairoMakie.jl` backend.

![Plotting functions: Cheat Sheet. Output given by Cairomakie.](images/makiePlottingFunctionsHide.png){#fig:cheat_sheet_cairomakie}

For completeness, in @fig:cheat_sheet_glmakie we show the corresponding functions _cheat sheet_ for `GLMakie.jl`, which as a backend supports mostly 3D plots.
Those will be explained in detail in @sec:glmakie.

![Plotting functions: Cheat Sheet. Output given by GLMakie.](images/GLMakiePlottingFunctionsHide.png){#fig:cheat_sheet_glmakie}

Now, that we have an idea of all the things we can do, let's go back and continue with the basics.
It's time to learn how to change the general appearance of our plots.

### Themes {#sec:themes}

There are several ways to affect the general appearance of your plots.
Either, you could use a [predefined theme](http://makie.juliaplots.org/stable/predefined_themes.html) or your own custom theme.
For example, to use the predefined dark theme via `with_theme(your_plot_function, theme_dark())`.
Or, build your own with `Theme(kwargs)` or even update the one that is active with `update_theme!(kwargs)`.

You can also do `set_theme!(theme; kwargs...)` to change the current default theme to `theme` and override or add attributes given by `kwargs`.
If you do this and want to reset all previous setting just do `set_theme!()` with no arguments.
See it in action in the following examples:


```jl
@sc demo_themes()
```

```jl
s = """
    CairoMakie.activate!() # hide
    filenames = ["theme_dark()", "theme_black()", "theme_ggplot2()", # hide
        "theme_minimal()", "theme_light()"] # hide
    objects = [ # hide
        with_theme(demo_themes, theme_dark())
        with_theme(demo_themes, theme_black())
        with_theme(demo_themes, theme_ggplot2())
        with_theme(demo_themes, theme_minimal())
        with_theme(demo_themes, theme_light())
    ] # hide
    Options.(objects, filenames) # hide
    """
sco(s)
```

Or, defining a custom `Theme` by doing `with_theme(your_plot_function, your_theme())`.
For instance, the following theme could be a simple version for a publication quality template:

```jl
@sc publication_theme()
```

```jl
@sc plot_with_legend_and_colorbar()
```

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(plot_with_legend_and_colorbar, publication_theme())
    label = "plot_with_legend_and_colorbar" # hide
    caption = "Themed plot with Legend and Colorbar." # hide
    Options(current_figure(); filename=label, label, caption) # hide
    """
sco(s)
```

Now, if something needs to be changed after `set_theme!(your_theme)`, we can do it with `update_theme!(resolution = (500,400), fontsize = 18)`.
Another approach will be to pass additional arguments to the `with_theme` function:

```jl
s = """
    CairoMakie.activate!() # hide
    fig = (resolution = (410,400), figure_padding = 1, backgroundcolor= :grey90)
    ax = (; aspect = DataAspect())
    cbar = (; height = Relative(4/5))

    with_theme(publication_theme(); fig..., Axis = ax, Colorbar = cbar) do
        plot_with_legend_and_colorbar()
    end
    label = "plot_theme_extra_args" # hide
    caption = "Theme with extra args." # hide
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

Now, let's move on and do a plot with LaTeX strings and a custom theme.

### using LaTeXStrings.jl

LaTeX support in `Makie.jl` is also available.
Simple use cases are shown below (@fig:latex_strings).
A basic example includes LaTeX strings for x-y labels and legends:

```jl
@sc LaTeX_Strings()
```

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(LaTeX_Strings, publication_theme())
    label = "latex_strings" # hide
    caption = "Plot with LaTeX strings." # hide
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

A more involved example will be one with some equation as `text` and increasing legend numbering for curves in a plot.

```
using LaTeXStrings
```

```jl
@sco JDS.multiple_lines()
```

But, some lines have repeated colors, so thats no good.
Adding some markers and line styles usually helps.
So, let's do that using [`Cycles`](http://makie.juliaplots.org/stable/theming.html#Cycles) for these types:

```jl
@sco JDS.multiple_scatters_and_lines()
```

And voilà.
A publication quality plot is here.
What more can we ask for?
Well, what about different default colors or palettes.
In our next section, we will see how to use again [`Cycles`](http://makie.juliaplots.org/stable/theming.html#Cycles) and know a little bit more about them, plus some additional keywords in order to achieve this.

### Colors and Colormaps {#sec:makie_colors}

Choosing an appropiate set of colors or colorbar for your plot is an essential part when presenting results.
Using [Colors.jl](https://github.com/JuliaGraphics/Colors.jl) is supported in `Makie.jl`
so that you can use [named colors](https://juliagraphics.github.io/Colors.jl/latest/namedcolors/) or pass `RGB` or `RGBA` values.
Regarding colormaps, all those that work with [Plots.jl](https://github.com/JuliaPlots/Plots.jl) also do here.
Additionally, colormaps from [ColorSchemes.jl](https://github.com/JuliaGraphics/ColorSchemes.jl) and [PerceptualColourMaps.jl](https://github.com/peterkovesi/PerceptualColourMaps.jl) can also be used.
It is worth knowing that you can reverse a colormap by doing `Reverse(:colormap_name)`
and obtain a transparent color or colormap with `color= (:red,0.5)` and `colormap = (:viridis, 0.5)`.

Different use cases will be shown next. Then we will difine a custom theme with new colors and a colorbar palette.

By default `Makie.jl` has a predefined set of colors in order to cycle trough them automatically.
As shown in the previous figures, where no specific color was set.
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
Let's do our first an example by calling colormaps as a `Symbol`, `String` and `cgrad` for categorical values.
See `?cgrad` for more information.

```jl
scolor = """
    CairoMakie.activate!() # hide 
    figure = (;resolution = (400,300), font= "CMU Serif")
    axis = (; xlabel = L"x", ylabel = L"y", aspect= DataAspect())

    fig, ax, pltobj = heatmap(rand(20,20); colorrange = (0,1),
        colormap = Reverse(:viridis), axis = axis, figure = figure)
    Colorbar(fig[1,2], pltobj, label = "Reverse colormap Sequential")
    fig
    label = "Reverse_colormap_sequential" # hide
    caption = "Reverse colormap sequential and colorrange." # hide
    Options(fig; filename=label, label, caption) # hide
    """
sco(scolor)
```

When setting a `colorrange` usually the values outside this range are colored with the first and last color from  the colormap.
However, sometimes is better to specify the color you want at both ends. We do that with `highclip` and `lowclip`:

```
using ColorSchemes
```

```jl
s = """
    CairoMakie.activate!() # hide
    figure = (;resolution = (400,300), font= "CMU Serif")
    axis = (; xlabel = L"x", ylabel = L"y", aspect= DataAspect())

    fig, ax, pltobj = heatmap(randn(20,20); colorrange = (-2,2),
        colormap = "diverging_rainbow_bgymr_45_85_c67_n256",
        highclip = :black, lowclip = :white, axis = axis, figure = figure)
    Colorbar(fig[1,2], pltobj, label = "Diverging colormap")
    fig
    label = "diverging_colormap" # hide
    caption = "Diverging Colormap with low and high clip." # hide
    Options(fig; filename=label, label, caption) # hide
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
    figure = (;resolution = (400,300), font= "CMU Serif")
    axis = (; xlabel = L"x", ylabel = L"y", aspect= DataAspect())
    cmap = ColorScheme(range(colorant"red", colorant"green", length=3))
    mygrays = ColorScheme([RGB{Float64}(i, i, i) for i in [0.0,0.5,1.0]])

    fig, ax, pltobj = heatmap(rand(-1:1,20,20);
        colormap = cgrad(mygrays, 3, categorical = true, rev = true), # cgrad and Symbol, mygrays,
        axis = axis, figure = figure)
    cbar = Colorbar(fig[1,2], pltobj, label = "Categories")
    cbar.ticks = ([-0.66,0,0.66], ["-1","0","1"])
    fig
    label = "categorical_colormap" # hide
    caption = "Categorical Colormap." # hide
    Options(fig; filename=label, label, caption) # hide
    """
sco(scat)
```

Lastly, the ticks in the colorbar for the categorial case are not centered by default in each color.
This is fixed by passing custom ticks, as in `cbar.ticks = (positions, ticks)`.
The last situation is when passing a tuple of two colors to `colormap` as symbols, strings or a mix.
You will get an interpolated colormap between these two colors.

Also, `hex` coded colors are also accepted. So, on top or our heatmap let's put one semi-transparent point using this.

```jl
s2color2 = """
    CairoMakie.activate!() # hide
    figure = (;resolution = (400,300), font= "CMU Serif")
    axis = (; xlabel = L"x", ylabel = L"y", aspect= DataAspect())

    fig, ax, pltobj = heatmap(rand(20,20); colorrange = (0,1),
        colormap = (:red, "black"), axis = axis, figure = figure)
    scatter!(ax,[11],[11],color=("#C0C0C0", 0.5),markersize=150)
    Colorbar(fig[1,2], pltobj, label = "2 colors")
    fig
    label = "colormap_two_colors" # hide
    caption = "Colormap from two colors." # hide
    Options(fig; filename=label, label, caption) # hide
    """
sco(s2color2)
```


 **Custom cycle**

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
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

At this point you should be able to have **complete control** over your colors, line styles, markers and colormaps for your plots.
Next, we will dive into how to manage and control **layouts**.

### Layouts {#sec:makie_layouts}

A complete _canvas/layout_ is defined by `Figure`, which can be filled with content after creation.
We will start with a simple arrangment of one `Axis`, one `Legend` and one `Colorbar`. 
For this task we can think of the canvas as an arrangment of `rows` and `columns`. 
The `Axis` content will be in _row 1, column 1_, e.g. `fig[1, 1]`, the `Colorbar` in _row 1, column 2_, namely `fig[1,2]`.
And the `Legend` in _row 2_ and across _column 1 and 2_, namely `fig[2,1:2]`. 


```jl
@sco JDS.first_layout()
```

This does not look good. Next, we fix the spacing problems using the following keywords and methods: 

- `figure_padding = (left, right, bottom, top)`
- `padding =  (left, right, bottom, top)` 

Taking into account the actual size for a `Legend` or `Colorbar` is done by 

> - `tellheight = true or false`
> - `tellwidth = true or false` 
>
> _Setting this to `true` will take into account the actual size(height or width) for a `Legend` or `Colorbar`_.
> And then, things will be resized accordingly. 

The space between columns and rows is specified as 

> - `colgap!(fig.layout, col, separation)`
> - `rowgap!(fig.layout, row, separation)`
>
> _Column gap_, if `col` is given then the gap will be applied to that column. 
>_Row gap_ ,if `row` is given then the gap will be applied to that row. 

Also, we will see how to put content into the **protrusions**, _i.e._ the space reserved for _title, x - (ticks,label), y - (ticks,label)_. 
We do this by plotting into `fig[i, j, protrusion]` where _`protrusion`_ can be `Left()`, `Right()`, `Bottom()` and `Top()`, 
or for each corner `TopLeft()`, `TopRight()`, `BottomRight()`, `BottomLeft()`. 
See below how these options are being used. 

```jl
@sco JDS.first_layout_fixed()
```

Here, having the label `(a)` in the `TopLeft()` is probably not necessary, this will only make sense for more than two plots.
For our next example let's use the previous tools and some more to create a more complex figure. 

You can hide decorations and axis's spines with

> - `hidedecorations!(ax; kwargs...)`
> - `hidexdecorations!(ax; kwargs...)`
> - `hideydecorations!(ax; kwargs...)`
> - `hidespines!(ax; kwargs...)`

Remember, we can always ask for help to see what kind of arguments we can use, e.g.,

```jl
s = """
    help(hidespines!)
    """
sco(s)
```

Or, for decorations

```jl
s = """
    help(hidedecorations!)
    """
sco(s)
```

For elements that **you don't want to hide**, just pass them with `false`, i.e. `hideydecorations!(ax; ticks=false, grid=false)`.


Synchronizing your `Axis` is done via

> - `linkaxes! linkyaxes! linkxaxes!`
>
> This could be useful when shared axis are desired. Another way of getting shared axis will be by setting `limits!`.

Setting `limits` at once or independenly for each axis is done by calling 

> - `limits!(ax; l,r,b,t)`
> You can also do `ylims!(low, high)` or `xlims!(low, high)`, and even open ones by doing `ylims!(low=0)` or `xlims!(high=1)`.

Now, the example:

```jl
@sco JDS.complex_layout_double_axis()
```

So, now our `Colorbar` needs to be horizontal and the bar ticks need to be in the lower part. 
This is done by setting `vertical = false` and `flipaxis = false`. 
Also, note that we can call many `Axis` into `fig`, or even `Colorbar`'s and `Legend`'s, and then afterwards build the layout. 

Another common layout is a grid of squares for heatmaps:

```jl
@sco JDS.squares_layout()
```

where all labels are in the **protrusions** and each `Axis` has an `AspectData()` ratio. 
The `Colorbar` is located in the third column and expands from row 1 up to row 2. 

The next case uses the so called `Mixed()` **alignmode**, which is especially useful when dealing with large empty spaces between `Axis` due to long ticks. 

```jl
@sco JDS.mixed_mode_layout()
```

Here, the argument `alignmode = Mixed(bottom=0)` is shifting the bounding box to the bottom, so that this will align with the panel on the left filling the space. 

Also, see how `colsize!` and `rowsize!` are being used for different columns and rows. 
You could also put a number instead of `Auto()` but then everything will be fixed. 
And, additionally, one could also give a `height` or `width` when defining the `Axis`, as in `Axis(fig, heigth = 50)` which will be fixed as well.

#### Nested `Axis` (_subplots_)

It is also possible to define a set of `Axis` (_subplots_) explicitly, and use it to build a main figure with several rows and columns. 
For instance, the following its a "complicated" arrangment of `Axis`

```jl
@sc nested_sub_plot!(fig)
```

which, when used to build a more complex figure by doing several calls, we obtain

```jl
@sco JDS.main_figure()
```

Note that, different subplot functions can be called here.
Also, each `Axis` here is an independent part of `Figure`. 
So that, if you need to do some `rowgap!`'s or `colsize!`'s operations, you will need to do it in each one of them independently or to all of them together. 

For grouped `Axis` (_subplots_) we can use `GridLayout()` which then could be used to composed a more complicated `Figure`. 


#### Nested GridLayout

By using `GridLayout()` we can group subplots, allowing more freedom to build complex figures. 
Here, using our previous `nested_sub_plot!` we define three sub-groups and one normal `Axis`. 

```jl
@sco JDS.nested_Grid_Layouts()
```

Now, using `rowgap!` or `colsize!` over each group is possible and `rowsize!, colsize!` can also be applied to the set of `GridLayout()`s. 


#### Inset plots

Currently, doing `inset` plots is a little bit tricky. Here, we show two possible ways of doing it by defining first auxiliary functions. 
The first one is by doing a `BBox`, which lives in the whole `Figure` space. Namely,

```jl
@sc add_box_inset(fig)
```

Then, the `inset` is easily done, as in 

```jl
@sco JDS.figure_box_inset()
```

where the `Box` dimensions are bound by the `Figure`'s `resolution`. Note, that an inset can be also outside the `Axis`. 
The other approach, is by defininig a new `Axis` into a position `fig[i,j]` specifying his `width`, `height`, `halign` and `valign`.
We do that in the following function:

```jl
@sc add_axis_inset()
```

See that in the following example this `Axis`(grey one) will be rescaled if the total figure size changes. The _insets_ are bound by the `Axis` positioning.

```jl
@sco JDS.figure_axis_inset()
```

And this should cover most used cases for layouting with Makie. Now, let's do some nice 3d examples with  `GLMakie.jl`.

### GLMakie.jl {#sec:glmakie}

For the most common plots in 3d we will use the following `peaks` functions

```jl
@sc JDS.peaks()
```

Whose output for several 3d functions calls with GLMakie is the following

```jl
@sco JDS.plot_peaks_function()
```

### Animations {#sec:makie_animations}

Recording an animation with CairoMakie (GLMakie).

## AlgebraOfGraphics.jl {#sec:algebraofgraphics}
