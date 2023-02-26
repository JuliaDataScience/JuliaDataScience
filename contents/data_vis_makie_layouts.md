## Layouts {#sec:makie_layouts}

A complete _canvas/layout_ is defined by `Figure`, which can be filled with content after creation.
We will start with a simple arrangement of one `Axis`, one `Legend` and one `Colorbar`.
For this task we can think of the canvas as an arrangement of `rows` and `columns` in indexing a `Figure` much like a regular `Array`/`Matrix`.
The `Axis` content will be in _row 1, column 1_, e.g. `fig[1, 1]`, the `Colorbar` in _row 1, column 2_, namely `fig[1, 2]`.
And the `Legend` in _row 2_ and across _column 1 and 2_, namely `fig[2, 1:2]`.

```jl
@sco JDS.first_layout()
```

This does look good already, but it could be better.
We could fix spacing problems using the following keywords and methods:

- `figure_padding=(left, right, bottom, top)`
- `padding=(left, right, bottom, top)`

Taking into account the actual size for a `Legend` or `Colorbar` is done by

> - `tellheight=true` or `false`
> - `tellwidth=true` or `false`
>
> _Setting these to `true` will take into account the actual size (height or width) for a `Legend` or `Colorbar`_.
> Consequently, things will be resized accordingly.

The space between columns and rows is specified as

> - `colgap!(fig.layout, col, separation)`
> - `rowgap!(fig.layout, row, separation)`
>
> _Column gap_ (`colgap!`), if `col` is given then the gap will be applied to that specific column.
>_Row gap_ (`rowgap!`), if `row` is given then the gap will be applied to that specific row.

Also, we will see how to put content into the **protrusions**, _i.e._ the space reserved for _title: `x` and `y`; either `ticks` or `label`_.
We do this by plotting into `fig[i, j, protrusion]` where _`protrusion`_ can be `Left()`, `Right()`, `Bottom()` and `Top()`, or for each corner `TopLeft()`, `TopRight()`, `BottomRight()`, `BottomLeft()`.
See below how these options are being used:

```jl
@sco JDS.first_layout_fixed()
```

Here, having the label `(a)` in the `TopLeft()` is probably not necessary, this will only make sense for more than one plot. Also, note the use of `padding`, which allows more fine control over his position.

For our next example let's keep using the previous tools and some more to create a richer and complex figure.

Having the same limits across different plots can be done via your `Axis` with:

> - `linkaxes!`, `linkyaxes!` and `linkxaxes!`
>
> This could be useful when shared axis are desired.
> Another way of getting shared axis will be by setting `limits!`.

Now, the example:

```jl
@sco JDS.complex_layout_double_axis()
```

So, now our `Colorbar` is horizontal and the bar ticks are in the lower part.
This is done by setting `vertical=false` and `flipaxis=false`.
Additionally, note that we can call many `Axis` into `fig`, or even `Colorbar`'s and `Legend`'s, and then afterwards build the layout.

Another common layout is a grid of squares for heatmaps:

```jl
@sco JDS.squares_layout()
```

where all labels are in the **protrusions** and each `Axis` has an `AspectData()` ratio.
The `Colorbar` is located in the third column and expands from row 1 up to row 2.

The next case uses the so called `Mixed()` **alignmode**, which is especially useful when dealing with large empty spaces between `Axis` due to long ticks.
Also, the `Dates` module from Julia's standard library will be needed for this example.

```
using Dates
```

```jl
@sco JDS.mixed_mode_layout()
```

Here, the argument `alignmode=Mixed(bottom=0)` is shifting the bounding box to the bottom, so that this will align with the panel on the left filling the space.

Also, see how `colsize!` and `rowsize!` are being used for different columns and rows.
You could also put a number instead of `Auto()` but then everything will be fixed.
And, additionally, one could also give a `height` or `width` when defining the `Axis`, as in `Axis(fig, height=50)` which will be fixed as well.

### Nested `Axis` (_subplots_)

It is also possible to define a set of `Axis` (_subplots_) explicitly, and use it to build a main figure with several rows and columns.
For instance, the following is a "complicated" arrangement of `Axis`:

```jl
@sc nested_sub_plot!(fig)
```

which, when used to build a more complex figure by doing several calls, we obtain:

```jl
@sco JDS.main_figure()
```

Note that different subplot functions can be called here.
Also, each `Axis` here is an independent part of `Figure`.
So that, if you need to do some `rowgap!`'s or `colsize!`'s operations, you will need to do it in each one of them independently or to all of them together.

For grouped `Axis` (_subplots_) we can use `GridLayout()` which, then, could be used to compose a more complicated `Figure`.

### Nested GridLayout

By using `GridLayout()` we can group subplots, allowing more freedom to build complex figures.
Here, using our previous `nested_sub_plot!` we define three sub-groups and one normal `Axis`:

```jl
@sco JDS.nested_Grid_Layouts()
```

Now, using `rowgap!` or `colsize!` over each group is possible and `rowsize!, colsize!` can also be applied to the set of `GridLayout()`s.

### Inset plots

Currently, doing `inset` plots is a little bit tricky.
Here, we show two possible ways of doing it by initially defining auxiliary functions.
The first one is by doing a `BBox`, which lives in the whole `Figure` space:

```jl
@sc add_box_inset(fig)
```

Then, the `inset` is easily done, as in:

```jl
@sco JDS.figure_box_inset()
```

where the `Box` dimensions are bound by the `Figure`'s `resolution`.
Note, that an inset can be also outside the `Axis`.
The other approach, is by defining a new `Axis` into a position `fig[i, j]` specifying his `width`, `height`, `halign` and `valign`.
We do that in the following function:

```jl
@sc add_axis_inset()
```

See that in the following example the `Axis` with gray background will be rescaled if the total figure size changes.
The _insets_ are bound by the `Axis` positioning.

```jl
@sco JDS.figure_axis_inset()
```

And this should cover most used cases for layouting with Makie.
Now, let's do some nice 3D examples with  `GLMakie.jl`.
