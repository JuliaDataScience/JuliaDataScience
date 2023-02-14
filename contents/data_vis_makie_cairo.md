## CairoMakie.jl {#sec:cairomakie}

Let's start with our first plot: some scatter points with a line across them.
Remember, first we call the backend and activate it, namely

```
using CairoMakie
CairoMakie.activate!()
```

And then the plotting function, in this case `scatterlines(x,y)` for points
`x=1:10` and `y=1:10`:

```jl
s = """
    CairoMakie.activate!() # hide
    fig = scatterlines(1:10, 1:10)
    label = "firstplot" # hide
    caption = "First plot." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Note that the previous plot is the default output, which we probably need to tweak by using axis names and labels.

Every plotting function like `scatterlines` creates and returns a new

- `Figure`
- `Axis` 
- `plot object`

in a collection called `FigureAxisPlot`.
These are known as the `non-mutating` methods.
On the other hand, the `mutating` methods (e.g. `scatterlines!`, note the `!`) just return a plot object which can be appended into a given `axis` or the `current_axis()`.

The next question that one might have is: how do I change the color or the marker type?
This can be done via `attributes`, which we explain in the next section.

## Attributes {#sec:datavisMakie_attributes}

A custom plot can be created by using `attributes`.
The attributes can be set through keyword arguments.
A list of `attributes` for a plot object, `pltobj`, can be viewed via `pltobj.attributes` as in:

```jl
s = """
    CairoMakie.activate!() # hide
    fig, ax, pltobj = scatterlines(1:10)
    pltobj.attributes
    """
sco(s)
```

Asking for help in the `REPL` as `?ablines` or `help(ablines)` for any given plotting function will show you their corresponding attributes plus a short description on how to use that specific function.
For example, for `ablines`:

```jl
s = """
    help(ablines)
    """
sco(s)
```

Not only the plot objects have attributes, in the next Section we will see that also the `Axis` and `Figure` objects do.