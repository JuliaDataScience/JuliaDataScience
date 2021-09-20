## Attributes

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
