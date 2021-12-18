## Attributes {#sec:datavisMakie_attributes}

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

Or as a `Dict` calling `pltobj.attributes.attributes`.

Asking for help in the `REPL` as `?lines` or `help(lines)` for any given plotting function will show you their corresponding attributes plus a short description on how to use that specific function.
For example, for `lines`:

```jl
s = """
    help(lines)
    """
sco(s)
```

Not only the plot objects have attributes, also the `Axis` and `Figure` objects do.
For example, for Figure, we have `backgroundcolor`, `resolution`, `font` and `fontsize` as well as the `figure_padding` which changes the amount of space around the figure content, see the grey area in @fig:custom_plot.
It can take one number for all sides, or a tuple of four numbers for left, right, bottom and top.

`Axis` has a lot more, some of them are  `backgroundcolor`, `xgridcolor` and `title`.
For a full list just type `help(Axis)`.

Hence, for our next plot we will call several attributes at once as follows:

```jl
s = """
    CairoMakie.activate!() # hide
    lines(1:10, (1:10).^2; color=:black, linewidth=2, linestyle=:dash,
        figure=(; figure_padding=5, resolution=(600, 400), font="sans",
            backgroundcolor=:grey90, fontsize=16),
        axis=(; xlabel="x", ylabel="x²", title="title",
            xgridstyle=:dash, ygridstyle=:dash))
    current_figure()
    filename = "custom_plot" # hide
    link_attributes = "width=60%" # hide
    caption = "Custom plot." # hide
    Options(current_figure(); filename, caption, label=filename, link_attributes) # hide
    """
sco(s)
```

This example has already most of the attributes that most users will normally use.
Probably, a `legend` will also be good to have.
Which for more than one function will make more sense.
So, let's `append` another mutation `plot` object and add the corresponding legends by calling `axislegend`.
This will collect all the `labels` you might have passed to your plotting functions and by default will be located in the right top position.
For a different one, the `position=:ct` argument is called, where `:ct` means let's put our label in the `center` and at the `top`,  see Figure @fig:custom_plot_leg:

```jl
s = """
    CairoMakie.activate!() # hide
    lines(1:10, (1:10).^2; label="x²", linewidth=2, linestyle=nothing,
        figure=(; figure_padding=5, resolution=(600, 400), font="sans",
            backgroundcolor=:grey90, fontsize=16),
        axis=(; xlabel="x", title="title", xgridstyle=:dash,
            ygridstyle=:dash))
    scatterlines!(1:10, (10:-1:1).^2; label="Reverse(x)²")
    axislegend("legend"; position=:ct)
    current_figure()
    label = "custom_plot_leg" # hide
    link_attributes = "width=60%" # hide
    caption = "Custom plot legend." # hide
    Options(current_figure(); label, filename=label, caption, link_attributes) # hide
    """
sco(s)
```

Other positions are also available by combining `left(l), center(c), right(r)` and `bottom(b), center(c), top(t)`.
For instance, for left top, use `:lt`.

<!--
When I remember correct (I didn't check it now), up to now you really just have
put stuff in backticks that was code. Now it seem that it is also used to
emphasize stuff like `legend` or `left(l), center(c), right(r)` and `bottom(b),
center(c), top(t)`. If it is really just emphasizing and not *also* code, then
I suggest to use another style to do so like putting it in italics.
-->

However, having to write this much code just for two lines is cumbersome.
So, if you plan on doing a lot of plots with the same general aesthetics, then setting a theme will be better.
We can do this with `set_theme!()` as the following example illustrates.

Plotting the previous figure should take the new default settings defined by `set_theme!(kwargs)`:

```jl
s = """
    CairoMakie.activate!() # hide
    set_theme!(; resolution=(600, 400),
        backgroundcolor=(:orange, 0.5), fontsize=16, font="sans",
        Axis=(backgroundcolor=:grey90, xgridstyle=:dash, ygridstyle=:dash),
        Legend=(bgcolor=(:red, 0.2), framecolor=:dodgerblue))
    lines(1:10, (1:10).^2; label="x²", linewidth=2, linestyle=nothing,
        axis=(; xlabel="x", title="title"))
    scatterlines!(1:10, (10:-1:1).^2; label="Reverse(x)²")
    axislegend("legend"; position=:ct)
    current_figure()
    set_theme!()
    label = "setTheme" # hide
    link_attributes = "width=60%" # hide
    caption = "Set theme example."
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Note that the last line is `set_theme!()`, which will reset the default settings of Makie.
For more on `themes` please go to @sec:themes.

Before moving on into the next section, it's worthwhile to see an example where an `array` of attributes are passed at once to a plotting function.
For this example, we will use the `scatter` plotting function to do a bubble plot.

The data for this could be an `array` with 100 rows and 3 columns, here we generated these at random from a normal distribution.
Here, the first column could be the positions in the `x` axis, the second one the positions in `y` and the third one an intrinsic associated value for each point.
The later could be represented in a plot by a different `color` or with a different marker size. In a bubble plot we can do both.

```jl
s = """
    using Random: seed!
    seed!(28)
    xyvals = randn(100, 3)
    xyvals[1:5, :]
    """
sco(s)
```

Next, the corresponding plot can be seen in @fig:bubble:

```jl
s = """
    CairoMakie.activate!() # hide
    fig, ax, pltobj = scatter(xyvals[:, 1], xyvals[:, 2]; color=xyvals[:, 3],
        label="Bubbles", colormap=:plasma, markersize=15 * abs.(xyvals[:, 3]),
        figure=(; resolution=(600, 400)), axis=(; aspect=DataAspect()))
    limits!(-3, 3, -3, 3)
    Legend(fig[1, 2], ax, valign=:top)
    Colorbar(fig[1, 2], pltobj, height=Relative(3 / 4))
    fig
    label = "bubble" # hide
    link_attributes = "width=60%" # hide
    caption = "Bubble plot."
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

where we have decomposed the tuple `FigureAxisPlot` into `fig, ax, pltobj`, in order to be able to add a `Legend` and `Colorbar` outside of the plotted object.
We will discuss layout options in more detail in @sec:makie_layouts.

We have done some basic but still interesting examples to show how to use `Makie.jl` and by now you might be wondering: what else can we do?
What are all the possible plotting functions available in `Makie.jl`?
To answer this question, a _cheat sheet_ is shown in @fig:cheat_sheet_cairomakie.
These work especially well with `CairoMakie.jl` backend.

![Plotting functions: Cheat Sheet. Output given by Cairomakie.](images/makiePlottingFunctionsHide.png){#fig:cheat_sheet_cairomakie}

For completeness, in @fig:cheat_sheet_glmakie, we show the corresponding functions _cheat sheet_ for `GLMakie.jl`, which supports mostly 3D plots.
Those will be explained in detail in @sec:glmakie.

![Plotting functions: Cheat Sheet. Output given by GLMakie.](images/GLMakiePlottingFunctionsHide.png){#fig:cheat_sheet_glmakie}

Now, that we have an idea of all the things we can do, let's go back and continue with the basics.
It's time to learn how to change the general appearance of our plots.
