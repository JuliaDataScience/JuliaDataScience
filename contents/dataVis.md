# Data Visualisation {#sec:dataVis}

Data visualisation it is a vital part of almost any data analysis process.
Here, in this chapter, we will consider several packages that can be used in Julia, namely `Plots.jl`, `Makie.jl` and `AlgebraOfGraphics.jl`.
The latter is especially useful for tabular data.

- Overview of the JuliaPlots ecosystem

## Plots.jl {#sec:plots}
Plots is ....

The default backend is GR. 

```
using Plots
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

## `Makie.jl` {#sec:makie}

(WIP) ideas for a better openinig line? 

[Makie.jl](http://makie.juliaplots.org/stable/index.html#Welcome-to-Makie!) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.
In our opinion, it is the prettiest and most versatile plotting package.

`Makie.jl` is the frontend package that defines all plotting functions.
It is reexported by every backend, so you don't have to specifically install or import it.
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
The attibutes can be set through keyword arguments.
A list of `attributes` for every plotting object can be viewed via:

```jl
s = """
    fig, ax, pltobj = scatterlines(1:10, 1:10)
    pltobj.attributes
    """
sco(s)
```
or as a `Dict` calling `pltobject.attributes.attributes`.

Asking for help in the `repl` as `?lines` or `help(lines)` for any given plotting function will show you their corresponding attributes plus a short description on how to use that specific function, e.g.:

```jl
s = """
    help(lines)
    """
sco(s)
```

But not only the plot objects have attributes, also the Axis and Figure objects do.
For example, for Figure, we have `backgroundcolor`, `resolution`, `font` and `fontsize` and the [figure_padding](http://makie.juliaplots.org/stable/figure.html#Figure-padding) which changes the amount of space around the figure content, see the grey area in the plot.
It can take one number for all sides, or a tuple of four numbers for left, right, bottom and top.

Axis has a lot more, some of them are  `backgroundcolor`, `xgridcolor` and `title`.
For a full list just type `help(Axis)`.

Hence, for our next plot we will call several attributes at once as follows:

```{comment}
The rewrite below is a suggestion.
```

```jl
s = """
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
    lines(1:10, (1:10).^2, label = "x²", linewidth = 2, linestyle = nothing,
        figure = (; figure_padding = 5, resolution = (600,400),
            backgroundcolor = :grey90, fontsize = 16, font = "sans"),
        axis = (; xlabel = "x", title = "title", backgroundcolor = :white,
            xgridstyle=:dash, ygridstyle=:dash))
    scatterlines!(1:10, (10:-1:1).^2; label = "Reverse(x)²")
    axislegend("legend", position = :ct)
    current_figure()
    label = "custom_plot_leg" # hide
    Options(current_figure(); label, filename=label, caption="Custom plot legend.") # hide
    """
sco(s)
```

However, having to writte this so much code just for two lines can become cumbersome
and tired, so if you plan on doing a lot of plots with the same general aesthetics
then setting a theme will be better. We can do this with `set_theme!()` as the following
example illustrates, not a particular good set of attributes but you get the idea. 

```jl
s = """
    set_theme!(resolution = (600,400), backgroundcolor = (:orange, 0.5),
        fontsize = 16, font = "sans",
        Axis = (backgroundcolor = :white, xgridstyle=:dash, ygridstyle=:dash),
        Legend = (bgcolor = (:red,0.2), framecolor = :dodgerblue)
        )

    lines(1:10, (1:10).^2, label = "x²", linewidth = 2, linestyle = nothing,
        axis = (; xlabel = "x", title = "title"))
    scatterlines!(1:10, (10:-1:1).^2, label = "Reverse(x)²")
    axislegend("legend", position = :ct)
    current_figure()
    set_theme!() # in order to go back to the default settings. 
    label = "setTheme" # hide
    Options(current_figure(); filename=label, caption="set theme", label) # hide
    """
sco(s)
```

For more on `themes` please go to section xxx (Refs)

Before moving on into the next section, it's worthwhile to see an example where an `array` of attributes are passed at once to a plotting function.
For this example, we will use the `scatter` plotting function to do a bubble plot.

```jl
s = """
    let
        Random.seed!(123)
        n = 100
        fig, ax, pltobj = CairoMakie.scatter(randn(n), randn(n), color = randn(n),
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
We will discuss this, `layouts`, in more detail in @sec:makie_layouts.

We have done some basic but still interesting examples to show how to use `Makie` and by now you might be wondering, what else can we do?
What are all the possible plotting functions available in `Makie.jl`?
To answer this question, a `cheat sheet` is shown in @fig:cheat_sheet_cairomakie.
These work especially well with `CairoMakie.jl`.

![Plotting functions: Cheat Sheet. Output given by Cairomakie.](images/makiePlottingFunctionsHide.png){#fig:cheat_sheet_cairomakie}

For completeness, in @fig:cheat_sheet_glmakie we show the corresponding ones for `GLMakie.jl`, mostly 3D plots which are highly supported in this backend.
Those will be explained in detail in @sec:glmakie.

![Plotting functions: Cheat Sheet. Output given by GLMakie.](images/GLMakiePlottingFunctionsHide.png){#fig:cheat_sheet_glmakie}

Now, that we have an idea of all the things we can do, let's go back and continue with the basics.
It's time to learn how to change the general appearance of our plots.

### Themes {#sec:themes}

There are several ways to affect the general appearance of your plots.
Either, you could use a [predefined theme](http://makie.juliaplots.org/stable/predefined_themes.html) or your own.
For example, to use the predefined dark theme via `with_theme(your_plot_function, theme_dark())`.
Or, build your own with `Theme(kwargs)` or even update the one that is active with `update_theme!(kwargs)`.

You can also do `set_theme!(theme; kwargs...)` to change the current default theme to `theme` and override or add attributes given by `kwargs`.
If you do this and want to reset all previous setting just do `set_theme!()`.
See it in action in the following examples:


```jl
@sc demo_themes()
```

```jl
s = """
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
    with_theme(plot_with_legend_and_colorbar, publication_theme())
    label = "plot_with_legend_and_colorbar" # hide
    caption = "Themed plot with Legend and Colorbar." # hide
    Options(current_figure(); filename=label, label, caption) # hide
    """
sco(s)
```

Now, if something needs to be changed after `set_theme!(your_theme)`, we can do it with `update_theme!(resolution = (500,400), fontsize = 18)`.
Another approach will be to pass additional arguments to the `with_theme` function:

```{comment}
The do here makes the code very difficult to read.
```

```jl
s = """
    with_theme(publication_theme(),resolution = (410,400), figure_padding = 1,
            backgroundcolor= :grey90, Axis = (; aspect = DataAspect()),
            Colorbar = (; height = Relative(4/5))) do
        plot_with_legend_and_colorbar()
    end
    label = "plot_theme_extra_args" # hide
    caption = "Theme with extra args." # hide
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

Now, let's move on and do a plot with LaTeX strings and a custom theme.

### LaTeXStrings

LaTeX support in Makie is also available.
Simple use cases are shown below (@fig:latex_strings).
A basic example includes LaTeX strings for x-y labels and legends:

```jl
@sc LaTeX_Strings()
```

```jl
s = """
    with_theme(LaTeX_Strings, publication_theme())
    label = "latex_strings" # hide
    caption = "Plot with LaTeX strings." # hide
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

A more involved example will be one with some equation as `text` and increasing legend numering for curves in a plot.

```
using LaTeXStrings
```

```jl
@sco JDS.multiple_lines()
```

But, some lines have repeated colors, so thats no good.
Adding some markers and line styles usually helps.
So, let's do that using [Cycles](http://makie.juliaplots.org/stable/theming.html#Cycles) for these types:

```jl
@sco JDS.multiple_scatters_and_lines()
```

And voilà.
A publication quality plot is here.
What more can we ask for?
Well, what about different default colors or palettes.
In our next section, we will see how to use again [Cycles](http://makie.juliaplots.org/stable/theming.html#Cycles) and know a little bit more about them, plus some additional keywords in order to achieve this.

### Colors and Palettes {#sec:makie_colors}

Sequential, diverging, categorical.

### Layouts {#sec:makie_layouts}

- Overview on several ways to do layouts and related attributes.

### Animations {#sec:makie_animations}

Recording an animation with CairoMakie (GLMakie).

### GLMakie.jl {#sec:glmakie}

## AlgebraOfGraphics.jl {#sec:algebraofgraphics}

