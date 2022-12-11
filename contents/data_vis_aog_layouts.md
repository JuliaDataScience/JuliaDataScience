## Layouts {#sec:aog_layouts}

`AlgebraOfGraphics.jl` supports layouts with plots in multiple rows and columns,
also known as _faceting_.
These are specified using the keywords arguments `layout`, `row` and `col` inside `mapping`.
If you use **`layout`** `AlgebraOfGraphics.jl` will try to use the best combinations of rows and columns to layout the visualization:

```jl
s = """
    # aog_layout # hide
    CairoMakie.activate!() # hide
    plt = data(df) *
        mapping(
            :name,
            :grade;
            layout=:year) *
        visual(BarPlot)
    f = draw(plt) # hide
    draw(plt)
    label = "aog_layout" # hide
    caption = "AlgebraOfGraphics bar plot with automatic layout." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

However, you can override that by using either `row` or `col` for mutiple row or multiple columns layouts, respectively.
Here's an example with `row`:

```jl
s = """
    # aog_row # hide
    CairoMakie.activate!() # hide
    plt = data(df) *
        mapping(
            :name,
            :grade;
            row=:year) *
        visual(BarPlot)
    f = draw(plt) # hide
    draw(plt)
    label = "aog_row" # hide
    caption = "AlgebraOfGraphics bar plot with row layout." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

And, finally, an example with `col`:

```jl
s = """
    # aog_col # hide
    CairoMakie.activate!() # hide
    plt = data(df) *
        mapping(
            :name,
            :grade;
            col=:year) *
        visual(BarPlot)
    f = draw(plt) # hide
    draw(plt)
    label = "aog_col" # hide
    caption = "AlgebraOfGraphics bar plot with column layout." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

> **_NOTE:_**
> You use _both_ `row` and `col` one for each categorical variable.
