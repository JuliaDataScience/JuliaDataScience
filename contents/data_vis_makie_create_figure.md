## Create Plot Figure {#sec:datavisMakie_create_Figure}
The basic container object in Makie is `Figure`, a canvas where we can add objects like `Axis`, `Colorbar`s, `Legend`s, etc.

For `Figure`, we have have attributes like `backgroundcolor`, `resolution`, `font` and `fontsize` as well as the `figure_padding` which changes the amount of space around the figure content, see the colored area in @fig:fig_axis.
It can take one number for all sides, or a tuple of four numbers for left, right, bottom and top.

```jl
@sco JDS.figure_canvas()
```

`Axis` has a lot more, some of them are  `backgroundcolor`, `xgridcolor` and `title`.
For a full list just type `help(Axis)`.

```jl
@sco JDS.figure_axis()
```

Now, we add a plotting function into our new Axis:

```jl
@sco JDS.figure_axis_plot()
```

This example already includes many of the attributes that are typically used.
Additionally, it would be beneficial to include a "legend" for reference, especially if the example has more than one function.
This will make it easier to understand.
So, let's `append` another mutation `plot` object and add the corresponding legends by calling `axislegend`.
This will collect all the `labels` you might have passed to your plotting functions and by default will be located in the right top position.
For a different one, the `position=:ct` argument is called, where `:ct` means let's put our label in the `center` and at the `top`,  see Figure @fig:plot_legend:


```jl
@sco JDS.figure_axis_plot_leg()
```

Other positions are also available by combining *left(l), center(c), right(r)* and *bottom(b), center(c), top(t)*.
For instance, for left top, use `:lt`.

However, having to write this much code just for two lines is cumbersome.
So, if you plan on doing a lot of plots with the same general aesthetics, then setting a theme will be better.
We can do this with `set_theme!()` as follows:

```jl
s = """
    set_theme!(;
        resolution=(600,400),
        backgroundcolor=(:mistyrose, 0.1),
        fontsize=16,
        Axis=(;
            xlabel="x",
            ylabel="y",
            title="Title",
            xgridstyle=:dash,
            ygridstyle=:dash,
            ),
        Legend=(;
            bgcolor=(:grey, 0.1),
            framecolor=:orangered,
            ),
        )
    """
sco(s)
```

Plotting the previous figure should take the new default settings defined by `set_theme!(kwargs)`:

```jl
@sco JDS.fig_theme()
```

Note that the last line is `set_theme!()`, will reset the default's settings of Makie.
For more on `themes` please go to @sec:themes.

Before moving on into the next section, it's worthwhile to see an example where an `array` of attributes is passed at once to a plotting function.
For this example, we will use the `scatter` plotting function to do a bubble plot.

The data for this could be an `array` with 100 rows and 3 columns, which we generated at random from a normal distribution.
Here, the first column could be the positions in the `x` axis, the second one the positions in `y` and the third one an intrinsic associated value for each point.
The latter could be represented in a plot by a different `color` or with a different marker size. In a bubble plot we can do both.

```jl
s = """
    using Random: seed!
    seed!(28)
    xyz = randn(100, 3)
    xyz[1:4, :]
    """
sco(s)
```

Next, the corresponding plot can be seen in @fig:bubble:

```jl
@sco JDS.fig_bubbles(xyz)
```

where we have decomposed the tuple `FigureAxisPlot` into `fig, ax, pltobj`, in order to be able to add a `Legend` and `Colorbar` outside of the plotted object.
We will discuss layout options in more detail in @sec:makie_layouts.

We have done some basic but still interesting examples to show how to use `Makie.jl` and by now you might be wondering: what else can we do?
