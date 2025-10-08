## Layouts {#sec:aog_layouts}

`AlgebraOfGraphics.jl` supports layouts with plots in multiple rows and columns, also known as *faceting*. These are specified using the keywords arguments `layout`, `row` and `col` inside `mapping`. If you use **`layout`**, `AlgebraOfGraphics.jl` will try to use the best combinations of rows and columns to layout the visualization:

```julia (editor=true, logging=false, output=true)
# aog_layout # hide

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
```
However, you can override that by using either `row` or `col` for multiple rows or multiple columns layouts, respectively. Here's an example with `row`:

```julia (editor=true, logging=false, output=true)
# aog_row # hide

plt = data(df) *
    mapping(:name, :grade; row=:year) *
    visual(BarPlot)
f = draw(plt) # hide
draw(plt)
label = "aog_row" # hide
caption = "AlgebraOfGraphics bar plot with row layout." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
And, finally, an example with `col`:

```julia (editor=true, logging=false, output=true)
# aog_col # hide

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
```
> ***NOTE:*** You use *both* `row` and `col` one for each categorical variable.


