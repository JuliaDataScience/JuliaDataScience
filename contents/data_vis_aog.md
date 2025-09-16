# Data Visualization with AlgebraOfGraphics.jl {#sec:aog}

`AlgebraOfGraphics.jl` is a higher-level plotting package that uses `Makie.jl` under the hood. It is geared towards data visualization workflows with support for `DataFrame`s. `AlgebraOfGraphics.jl` abstracts away some common patterns in data visualization using an interface similar to R's `ggplot2` package.

`AlgebraOfGraphics.jl` follows a layered approach to construct visualizations in a structured manner. There are four main types of layers:

  * **data** layer
  * **mapping** layer
  * **visual transformation** layer
  * **statistical transformation** layer

> ***NOTE:*** `AlgebraOfGraphics.jl` has some guiding principles described in their [philosophy section](https://aog.makie.org/stable/philosophy/).


`AlgebraOfGraphics.jl` allows you to construct all of these types of layers with functions that return a `Layer` object, in which all of the information necessary will be encoded. You can then perform **two operations on layers**:

  * **multiplication with `*`**: this fuses two or more layers into a *single* layer
  * **addition with `+`**: this superimposes two or more layers into a vector of `Layer`s

Finally, as the name suggests, `AlgebraOfGraphics.jl` is an algebra for `Layer` objects. And, as such, it defines two algebraic properties. Let `a`, `b` and `c` be `Layer` objects, then the following two properties hold:

  * **associative property**: `(a * b) * c = a * (b * c)`
  * **distributive property**: `a  * (b + c) = (a * b) + (a + b)`

To get started with `AlgebraOfGraphics.jl`, you'll need to load it along with a desired `Makie.jl` backend (Chapter -@sec:DataVisualizationMakie):

```julia (editor=true, logging=false, output=true)
using AlgebraOfGraphics
```
## Layers {#sec:aog_layers}

We'll cover the **data layer** first, which can be created with the `data` function:

```julia (editor=true, logging=false, output=true)
data_layer = data(grades_2020())
```
As you can see, `data` takes any `DataFrame` and returns a `Layer` type. You can see that we do not have any mapping, visual, or statistical transformations information yet. That will need to be specified in different layer type with different functions.

> ***NOTE:*** `data` layers can use any [`Tables.jl`](https://github.com/JuliaData/Tables.jl/blob/main/INTEGRATIONS.md) data format, including `DataFrames` and `NamedTuples`.


Let's see how to encode data information in a **mapping layer** with the `mapping` function. This function has the following signature:

```julia (editor=true, logging=false, output=true)
mapping(
    x, y, z;
    color,
    size,
    ...
)
```
The positional arguments `x`, `y`, and `z` correspond to the X-, Y- and Z-axis mappings and the keyword arguments `color`, `size`, and so on, correspond to the aesthetics mappings. The purpose of `mapping` is to encode in a `Layer` information about which columns of the underlying data `AlgebraOfGraphics.jl` will map onto the axis and other visualization aesthetics, e.g. color and size. Let's use `mapping` to encode information regarding X- and Y-axis:

```julia (editor=true, logging=false, output=true)
mapping_layer = mapping(:name, :grade_2020)
```
We pass the columns as `Symbol`s in a similar manner as we did for `DataFrames.jl` (Chapter -@sec:dataframes) and `DataFramesMeta.jl` (Chapter -@sec:dataframesmeta). In the output, we see that we have successfully encoded both `:name` and `:grade_2020` columns as the X- and Y-axis, respectively.

Finally, we can use a **visual transformation layer** to encode which type of plot we want to make. This is done with the `visual` function which takes a **`Makie.jl` plotting type** as a single positional argument. All of the mappings specified in the mapping layer will be passed to the plotting type.

```julia (editor=true, logging=false, output=true)
visual_layer = visual(BarPlot)
```
The `visual_layer` is a visual transformation layer that encodes information about which type of visual transformation you want to use in your visualization plus keyword arguments that might apply to the selected plotting type.

> ***NOTE:*** We are using the plotting *type* (`BarPlot`) instead of the plotting *function* (`barplot`). This is due how `AlgebraOfGraphics.jl` works. You can see all of the available mappings for all of the plotting types by inspecting their functions either using Julia's help REPL, e.g. `?barplot`, or [`Makie.jl`'s documentation on plotting functions](https://docs.makie.org/stable/examples/plotting_functions/).


### Drawing Layers {#sec:aog*layers*draw}

Once we have all of the necessary layers we can fuse them together with `*` and apply the `draw` function to get a plot. The **`draw` function** will use all of the information from the layer it is being supplied and will send it as **plotting instructions to the activated `Makie.jl` backend**:

```julia (editor=true, logging=false, output=true)
# aog_basic # hide

f = draw(data_layer * mapping_layer * visual_layer) # hide
draw(data_layer * mapping_layer * visual_layer)
label = "aog_basic" # hide
caption = "AlgebraOfGraphics bar plot." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
`AlgebraOfGraphics.jl` will automatically pass the underlying columns of the mapping layer from the data layer's `DataFrame` as the X- and Y-labels.

Note that you can just perform the `*` operations inside `draw` if you don't want to create intermediate variables:

```julia (editor=true, logging=false, output=true)
# aog_basic_verbose # hide

plt = data(grades_2020()) * mapping(:name, :grade_2020) * visual(BarPlot)
f = draw(plt) # hide
draw(plt)
label = "aog_basic_verbose" # hide
caption = "AlgebraOfGraphics bar plot." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
### Mapping Layer Keyword Arguments {#sec:aog*layers*keyword}

Let's try to use other mappings such as the keyword arguments `color` and `dodge` in our bar plot, since they are supported by the `BarPlot` plotting type. First, let's revisit our example `all_grades()` data defined in Chapter -@sec:dataframes and add a `:year` column:

```julia (editor=true, logging=false, output=true)
# aog grades # hide
df = @transform all_grades() :year = ["2020", "2020", "2020", "2020", "2021", "2021", "2021"]
```
Now we can pass the `:year` column to be mapped as both a `color` and  `dodge` aesthetic inside `mapping`:

```julia (editor=true, logging=false, output=true)
# aog_color # hide

plt = data(df) *
    mapping(
        :name,
        :grade;
        color=:year,
        dodge=:year) *
    visual(BarPlot)
f = draw(plt) # hide
draw(plt)
label = "aog_color" # hide
caption = "AlgebraOfGraphics bar plot with colors as year." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
`AlgebraOfGraphics.jl` creates for us a legend with the underlying information from the `color` mapping column inside the data layer's `DataFrame`.

### Transformations Inside Mapping Layers {#sec:aog*layers*transformations}

We can also perform **transformations** inside the `mapping` function. It supports the `DataFrames.jl`'s minilanguage `source => transformation => target`. Where `source` is the original column name and `target` is a `String` representing the new desired label. If we simply use `source => target`, the underlying transformation will be the `identity` function, i.e., no transformation is performed and the data is passed as it is. Here's an example:

```julia (editor=true, logging=false, output=true)
# aog_color_custom # hide

plt = data(df) *
    mapping(
        :name => "Name",
        :grade => "Grade";
        color=:year => "Year",
        dodge=:year) *
    visual(BarPlot)
f = draw(plt) # hide
draw(plt)
label = "aog_color_custom" # hide
caption = "AlgebraOfGraphics bar plot with colors as year and custom labels." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
Let's make use of the `transformation` in `source => transformation => target` to transform our grades scale from 0-10 to 0-100 and also our names to uppercase:

```julia (editor=true, logging=false, output=true)
# aog_color_custom2 # hide

plt = data(df) *
    mapping(
        :name => uppercase => "Name",
        :grade => (x -> x*10) => "Grade";
        color=:year => "Year",
        dodge=:year) *
    visual(BarPlot)
f = draw(plt) # hide
draw(plt)
label = "aog_color_custom2" # hide
caption = "AlgebraOfGraphics bar plot with colors as year, custom labels and transformations." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
As you can see, we can pass both regular or anonymous functions.

> ***NOTE:*** By default `AlgebraOfGraphics.jl` transformations inside `mapping` are vectorized (broadcasted) by default. Hence, we don't need to use the dot operator `.`.


