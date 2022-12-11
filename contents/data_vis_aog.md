# Data Visualization with AlgebraOfGraphics.jl {#sec:aog}

`AlgebraOfGraphics.jl` is a higher-level plotting package that uses `Makie.jl` under the hood.
It is geared towards data visualization workflows with support for `DataFrame`s.
`AlgebraOfGraphics.jl` abstracts away some common patterns in data visualization using an interface that was based on the "grammar of graphics" approach that is used by R's `ggplot2` package.

The **grammar of graphics** is a framework that follows a layered approach to construct visualizations in a structure manner.
There are four main types of layers:

- **data** layer
- **mapping** layer
- **visual transformation** layer
- **statistical transformation** layer

`AlgebraOfGraphics.jl` allows you to construct all of these types of layers with functions that returns a `Layer` object,
in which all of the information necessary will be encoded.
You can then perform **two operations on layers**:

- **multiplication with `*`**: this fuses two or more layers into a _single_ layer
- **addition with `+`**: this superimposes two or more layers into a vector of `Layer`s

Finally, as the name suggests, `AlgebraOfGraphics.jl` is more than a grammar but also an algebra for `Layer` objects.
And, as such, it defines two algebraic properties.
Let `a`, `b` and `c` be `Layer` objects:

- **associative property**: `(a * b) * c = a * (b * c)`
- **distributive property**: `(a + b) * c = (a * c) + (b * c)`

To get started with `AlgebraOfGraphics.jl`,
you'll need to load it along with a desired `Makie.jl` backend (Chapter -@sec:DataVisualizationMakie):

```julia
using AlgebraOfGraphics
using CairoMakie
```

## Layers {#sec:aog_layers}

The first layer we'll cover will be the **data layer**.
You can create data layers with the `data` function:

```jl
sco("""
data_layer = data(grades_2020())
""")
```

As you can see, `data` takes any `DataFrame` and returns a `Layer` type.
You can see that we do not have any any mapping, visual, or statistical transformations information.
That will need to be specified in different layer types with different functions.

Let's see how to encode mapping information oin a **mapping layer** with the `mapping` function.
This functions has the following signature:

```julia
mapping(
    x, y, z;
    color,
    size,
    ...
)
```

The positional arguments `x`, `y`, and `z` correspond to the X-, Y- and Z-axis mappings.
Where the keyword arguments `color`, `size`, and so on, correspond to the aesthetics mappings.
The purpose of `mapping` is to encode in a `Layer` information about which columns of the underlying data `AlgebraOfGraphics.jl` will map onto the axis and other visualization aesthetics, e.g. color and size.
Let's use `mapping` to encode information regarding X- and Y-axis:

```jl
sco("""
mapping_layer = mapping(:name, :grade_2020)
""")
```

We pass the columns as `Symbol`s in a similar manner as we did for `DataFrames.jl` (Chapter -@sec:dataframes) and `DataFramesMeta.jl` (Chapter -@sec:dataframesmeta).
In the ouput, we see that we have sucessfully encoded both `:name` and `:grade_2020` columns as the X- and Y-axis, respectively.

Finally, we can use a **visual transformation layer** to encode which type of plot we want to make.
This is done with the `visual` function which takes a **`Makie.jl` plotting type** as a single positional argument.
All of the mappings specified in the mapping layer will be passed to the plotting type.

```jl
sco("""
visual_layer = visual(BarPlot)
""")
```

The `visual_layer` is a visual transformation layer that only encodes information about which type of visual transformation you want to apply to your visualization.

> **_NOTE:_**
> We are using the plotting _type_ (`BarPlot`) instead of the plotting _function_ (`barplot`).
> This is due how `AlgebraOfGraphics.jl` works.
> You can see all of the available mappings for all of the plotting types by inspecting their functions either using Julia's help REPL, e.g. `?barplot`, or [`Makie.jl`'s documentation on plotting functions](https://docs.makie.org/stable/examples/plotting_functions/).

### Drawing Layers {#sec:aog_layers_draw}

Once we have all of the necessary layers we can fuse them together with `*` and pass to the `draw` function.
The **`draw` function** will use all of the information from the layer it is being supplied and will send it as **plottings instructions to the activated `Makie.jl` backend**:

```jl
s = """
    # aog_basic # hide
    CairoMakie.activate!() # hide
    f = draw(data_layer * mapping_layer * visual_layer) # hide
    draw(data_layer * mapping_layer * visual_layer)
    label = "aog_basic" # hide
    caption = "AlgebraOfGraphics bar plot." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

`AlgebraOfGraphics.jl` will automatically pass the underlying columns of the mapping layer from the data layer's `DataFrame` as the X- and Y-labels.

Note that you can just perform the `*` operations inside `draw` if you don't want to create intermediate variables:

```jl
s = """
    # aog_basic_verbose # hide
    CairoMakie.activate!() # hide
    plt = data(grades_2020()) * mapping(:name, :grade_2020) * visual(BarPlot)
    f = draw(plt) # hide
    draw(plt)
    label = "aog_basic_verbose" # hide
    caption = "AlgebraOfGraphics bar plot." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

### Mapping Layer Keyword Arguments {#sec:aog_layers_keyword}

Let's try to use other mappings such as the keyword arguments `color` and `dodge` in our bar plot,
since they are supported by the `BarPlot` plotting type.
First, let's revisit our example `all_grades()` data defined in Chapter -@sec:dataframes and add a `:year` column:

```jl
sco("""
# aog grades # hide
df = @transform all_grades() :year = ["2020", "2020", "2020", "2020", "2021", "2021", "2021"]
"""; process=without_caption_label
)
```

Now we can pass the `:year` column to be mapped as a both `color` and `dodge` aesthetics inside `mapping`:

```jl
s = """
    # aog_color # hide
    CairoMakie.activate!() # hide
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
    """
sco(s)
```

`AlgebraOfGraphics.jl` creates for us a legend with the underlying information from the `color` mapping column inside the data layer's `DataFrame`.

### Transformations Inside Mapping Layers {#sec:aog_layers_transformations}

We can also perform **transformations** inside the `mapping` function.
It supports the `DataFrames.jl`'s minilanguage `source => transformation => target`.
Where `source` is the original column name and `target` is a `String` representing the new desired label.
If we simply use `source => target`, the underlying transformation will be the `identity` function, i.e. no transformation is performed and the data is passed as it is.
Here's an example:

```jl
s = """
    # aog_color_custom # hide
    CairoMakie.activate!() # hide
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
    """
sco(s)
```

Let's make use of the `transformation` in `source => transformation => target` to transform our grades scale from 0-10 to 0-100 and also our names to uppercase:

```jl
s = """
    # aog_color_custom2 # hide
    CairoMakie.activate!() # hide
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
    """
sco(s)
```

As you can see, we can pass both regular functinos or anonymous functions.

> **_NOTE:_**
> By default `AlgebraOfGraphics.jl` transformations inside `mapping` are vectorized (broadcasted) by default.
> Hence, we don't need to use the dot operator `.`.
