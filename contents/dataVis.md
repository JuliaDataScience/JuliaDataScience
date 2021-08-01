# Data Visualisation {#sec:dataVis}

Data visualisation it is a vital part of almost any data analysis process.
Here, in this chapter we will consider several libraries that can be used in Julia, namely Plots, Makie and AlbegraOfGraphics specially usefull for tabular data. 

- Overview of the JuliaPlots ecosystem

## Plots.jl {#sec:plots}
Plots is .... 

The default backend is GR. 

```
using Plots
```

### Plots attributes {#sec:attributes}

### Colors and Palettes {#sec:colors}
Sequential, diverging, categorical. 

### Layouts {#sec:layouts}

- Overview on several ways to do layouts
- the layout argument, also cover the grid
- the @layout macro
- specific measures with the Plots.PlotMeasures submodule (additionally a footnote to say that we have it in StatsPlots.PlotMeasures also)
- adding subplots incremententally. Define p1, p2, p3; then do a plot(p1, p2, p3; layout=l)

### Animations {#sec:animations}
Doing an animation with Plots is quite easy. 

### Themes {#sec:themes}

### Other backends {#sec:backends}
Plotly, PGFPlotsX, PyPlot?

## StatsPlots.jl {#sec:statsplots}

1. A brief intro and show that is is really just "syntactic sugar" for Plots.jl. Also note that works on all plots.jl stuff:

- Backends
- Attributes
- Colours
- Layouts
- Animations
- Themes
2. Works on Types of Distributions and DataFrames, but we will only focus on DataFrames

3. the @df macro and the Symbols (:col1, :col2) instead of other input data (vectors, arrays, tuples etc.)

4. Recipes (I would cover almost all of them, except for andrewsplot MDS plot, Dendograms, QQ-Plot etc., since they are specific for modeling or simulation):

- histogram, histogram2d and ea_histogram
- groupedhist and groupedbar
- boxplot
- dotplot
- violin
- marginalhist, marginalkde and marginalscatter
- corrplot and cornerplot

## Makie.jl {#sec:makie}

[Makie](http://makie.juliaplots.org/stable/index.html#Welcome-to-Makie!) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.

Makie is Makie's frontend package that defines all plotting functions.
It is reexported by every backend, so you don't have to specifically install or import it.
There are three main backends which concretely implement all abstract rendering capabilities defined in Makie.
One for non-interactive 2D publication-quality vector graphics, `CairoMakie.jl`.
Another for interactive 2D and 3D plotting in standalone GLFW.jl windows (also GPU-powered), `GLMakie.jl`.
And the third one, a WebGL-based interactive 2D and 3D plotting that runs within browsers, `WGLMakie.jl`. [See Makie's documentation for more](http://makie.juliaplots.org/stable/backends_and_output.html#Backends-and-Output).

In this book we will only show examples for `CairoMakie` and `GLMakie`.

You can activate any backend by using the appropriate package and calling its `activate!` function, e.g. 

```
using GLMakie
GLMakie.activate!()
```
Now, we will start with publication-quality plots. 

### CairoMakie.jl {#sec:cairomakie}

Let's start with our first plot, a not so boring example but still simple enough, e.g. a line and 
some scatter points. 

```
using CairoMakie
CairoMakie.activate!()
```

```jl
s = """
    scatterlines(1:10, 1:10)
    filename = "firstplot" # hide 
    Options(current_figure(); filename, caption="First plot", label="firstplot") # hide
    """
sco(s)
```

The previous plot is the default output, which for some probably is not ideal, plus some 
axis names and labels could be useful. 

Also note that every plotting function like `scatterlines` creates and returns a new `Figure`, `Axis` 
and `plot` object in a collection called `FigureAxisPlot`, these are known as the 
`non-mutating` methods. On the other hand, the `mutating` methods (e.g. `scatterlines!`, note the `!`)
just returns a plot object which can be appended into a given `axis`  or the `current_figure()`.

### Attributes

A custom plot can be done via `attributes` which can be set through keyword arguments. 
A list of `attributes` for every plotting object can be view as follows, 

```jl
s = """
    fig, ax, pltobj = scatterlines(1:10, 1:10)
    pltobj.attributes
    """
sco(s)
```
or as a `Dict` calling `pltobject.attributes.attributes`. 

Asking for help in the `repl` as `?lines` or `help(lines)` for any given plotting 
function will also show you their corresponding attributes plus a short description on how to use 
that specific function, e.g.,

```jl
s = """
    help(lines)
    """
sco(s)
```
But not only the plot objects have attributes, also the Axis and Figure objects do. For example
we have for Figure, `backgroundcolor`, `resolution`, `font` and `fontsize` and the 
[figure_padding](http://makie.juliaplots.org/stable/figure.html#Figure-padding) 
which changes the amount of space around the figure content, see grey area in plot.
It can take one number for all sides, or a tuple of four numbers for left, right, bottom
and top.  

Axis has a lot more, some of them are  `backgroundcolor`, `xgridcolor`, `title` among others,
for a full list just type `help(Axis)`. 


Hence, for our next plot we will call several attributes at once as follows.

```jl
s = """
    lines(1:10, (1:10).^2, color = :black, linewidth = 2, linestyle = :dash,
        figure = (; figure_padding = 5, resolution = (600,400), 
            backgroundcolor = :grey90, fontsize = 16, font = "sans"), 
        axis = (; xlabel = "x", ylabel = "x²", title = "title", 
            backgroundcolor = :white, xgridstyle=:dash, ygridstyle=:dash))
    filename = "customPlot" # hide 
    Options(current_figure(); filename, caption="custom plot", label="customplot") # hide
    """
sco(s)
```

This example has already most of the attributes that most users will play with it. 
Probably a `legend` will also be good to have. Which for more than one function will 
make more sense. So, let's  `append` another `plot object`, a mutating one `!`, and
add the corresponding legends. 

```jl
s = """
    lines(1:10, (1:10).^2, label = "x²", linewidth = 2, linestyle = nothing,
        figure = (; figure_padding = 5, resolution = (600,400), 
            backgroundcolor = :grey90, fontsize = 16, font = "sans"), 
        axis = (; xlabel = "x", title = "title", backgroundcolor = :white, 
            xgridstyle=:dash, ygridstyle=:dash))
    scatterlines!(1:10, (10:-1:1).^2, label = "Reverse(x)²")
    axislegend("legend", position = :ct)
    current_figure()
    filename = "customPlotLeg" # hide 
    Options(current_figure(); filename, caption="custom plot legend", label="customplotlegend") # hide
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
    filename = "setTheme" # hide 
    Options(current_figure(); filename, caption="set theme", label="setTheme") # hide
    """
sco(s)
```

For more on `themes` please go to section xxx  and learn how to do `with_theme(...)`.

Before moving on into the next section, it's worthwile to see an example 
where an `array` of attributes are passed at once to a plotting function. 
For this example we will use the `scatter` plotting function a do a bubble plot. 

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
        Options(current_figure(); filename ="bubbleplot", caption="Bubble plot", label="bubbleplot") # hide 
    end
    """
sco(s)
```

Of course a `Colorbar` will be nice to have. We will learn to do it in Section xxx. 

Do a Legend outside and the correspoing Colorbar. Then reference chapter on layouts 
for more advanced options. 

### Themes {#sec:themes}

Several [predifined themes](http://makie.juliaplots.org/stable/predefined_themes.html) 
are already available


```jl
@sc demo_themes()
```

```jl
s = """
    filenames = ["theme_dark()", "theme_black()", "theme_ggplot2()", # hide 
        "theme_minimal()", "theme_light()"] # hide 
    objects = [# hide
        with_theme(demo_themes, theme_dark())
        with_theme(demo_themes, theme_black())
        with_theme(demo_themes, theme_ggplot2())
        with_theme(demo_themes, theme_minimal())
        with_theme(demo_themes, theme_light())
    ]# hide 
    Options.(objects, filenames) # hide 
    """
sco(s)
```

Or, defining a custom `Theme` according to your needs by doing 
`with_theme(yourplotfunction, your_theme())`. For instance the following theme
could be a simple version for a publication quality template. 

```jl
@sc publication_theme()
```

```jl
@sc plot_with_legend_and_colorbar()
```

```jl
s = """
    with_theme(plot_with_legend_and_colorbar, publication_theme())
    filename = "plot_with_legend_and_colorbar" # hide 
    Options(current_figure(); filename, caption="Themed plot with Legend and Colorbar", # hide
    label="plot_with_legend_and_colorbar") # hide
    """
sco(s)
```

now if something needs to be changed after `set_theme!(your_theme)` we can do it with  
`update_theme!(resolution = (500,400), fontsize = 18)`. Another approach will be to
pass additional arguments to the `with_theme` function as in 

```jl
s = """
    with_theme(publication_theme(),resolution = (410,400), figure_padding = 1, 
            backgroundcolor= :grey90, Axis = (; aspect = DataAspect()), 
            Colorbar = (; height = Relative(4/5))) do 
        plot_with_legend_and_colorbar()
    end
    filename = "plot_theme_extra_args" # hide 
    Options(current_figure(); filename, caption="Theme with extra args.", # hide
    label="themeExtraArgs") # hide
    """
sco(s)
```


Now, let's move on and do a plot with LaTeX strings and a custom theme.

### LaTeXStrings

LaTeX support string in Makie is also available. Simple use cases are shown below. 
A basic example includes LaTeX string for x-y labels and legends. 

```jl
@sc LaTeX_Strings()
```

```jl
s = """
    with_theme(LaTeX_Strings, publication_theme())
    filename = "LaTeX_Strings" # hide 
    Options(current_figure(); filename, caption="Plot with LaTeX Strings", # hide
    label="LaTeXStrings") # hide
    """
sco(s)
```

A more involved example will one with some equation as `text` and increasing 
legend numering for curves in a plot. 

```
using LaTeXStrings
```

```jl
@sco JDS.multiple_lines()
```

But, some lines have repeated colors, so thats no good. Adding some 
markers and line styles usually helps. So, let's do that using [Cycles](http://makie.juliaplots.org/stable/theming.html#Cycles) 
for these types. 

```jl
@sco JDS.multiple_scatters_and_lines()
```


### Colors and Palettes {#sec:colors}
Sequential, diverging, categorical. 

### Layouts {#sec:layouts}
- Overview on several ways to do layouts and related attributes. 

### Animations {#sec:animations}
Recording an animation with CairoMakie (GLMakie). 

### GLMakie.jl {#sec:glmakie}


## AlgebraOfGraphics.jl {#sec:algebraofgraphics}


