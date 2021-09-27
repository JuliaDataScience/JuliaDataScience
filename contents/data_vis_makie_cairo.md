## CairoMakie.jl {#sec:cairomakie}

Let's start with our first plot, a not so boring example but still simple enough, e.g. a line and some scatter points:

```
using CairoMakie
CairoMakie.activate!()
```

```jl
s = """
    CairoMakie.activate!() # hide
    fig, = scatterlines(1:10, 1:10)
    #save("firstplot.png", fig)
    label = "firstplot" # hide
    caption = "First plot." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

The previous plot is the default output, which we probably need to tweak by using axis names and labels.

Also note that every plotting function like `scatterlines` creates and returns a new `Figure`, `Axis` and `plot` object in a collection called `FigureAxisPlot`.
These are known as the `non-mutating` methods.
On the other hand, the `mutating` methods (e.g. `scatterlines!`, note the `!`) just return a plot object which can be appended into a given `axis` or the `current_figure()`.

The next question that one might have is: how do I change the color or the marker type?
This can be done via `attributes`, which we do in the next section.
