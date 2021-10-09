# Data Visualization with Plots.jl {#sec:DataVisualizationPlots}

Data visualization is a vital part of almost any data analysis process.
For plotting in Julia several options are available, i.e., `Plots.jl`, `Makie.jl` and `UnicodePlots.jl`.
Here, in this chapter, we will consider `Plots.jl`, later we will discuss `Makie.jl`.

So, what is `Plots.jl`?
Well, it is a visualization interface and toolset used to send plotting instructions to different backends without changing your code for each one of them.
Some [available backends](http://docs.juliaplots.org/latest/backends/) are for instance `GR.jl`, `PyPlot.jl`, `PGFPlotsX.jl` or `Plotly.jl`.
Note, that each one of them is a package in itself also.
Then, if you require full customization it's recommended to use one of the backends directly.
See the [official documentation](http://docs.juliaplots.org/latest/) for more information.

`Plots.jl` will pick a default backend for you automatically based on the ones installed.
Usually the default one is `GR.jl`.
Additional requirements are needed on Linux systems.
Read the [official documentation](https://gr-framework.org/julia.html#installation) for more information.
When in doubt please refer to the [official installation page](http://docs.juliaplots.org/latest/install/) for `Plots.jl`.

You should be able to start by simply installing `Plots.jl` and `GR.jl` as in:

```
] add Plots, GR
```

and then your first plot will be:

```
using Plots
```

```jl
let
    s = """
        plot(1:10)
        """
    label = "Plots_first_plot"
    filename = label
    caption = "First plot"
    link_attributes = "width=60%"
    pre(out) = Options(out; filename, label, caption, link_attributes)
    sco(s; pre)
end
```

You can check your current backend by doing:
```
using Plots: backend
```

and then simply typing:

```jl
sco("backend()")
```

and you can switch to another one by doing `pyplot()` or `plotly()` for example.
Saving a Figure `fig` is done with `savefig(fig, "filename.png")`.
Simply typing `savefig("filename.png")` will save the most recent figure.
More extensions are also possible for `gr`, e.g., `svg` or `pdf` among others. A complete list for each backend is shown in the [`Plots.jl`'s Output](http://docs.juliaplots.org/latest/output/#Supported-output-file-formats) official documentation.

`Plots.jl` is a well designed package, so that even if you don't know what you are doing is highly probable that `Plots.jl` will give you back some output.
So, at least when just starting with it, be careful.
Later, you can enjoy the power of passing `key arguments` to `plot` and create complicated figures with just a few commands.
In the next section we will explore these extra arguments, known as `Attributes`.
