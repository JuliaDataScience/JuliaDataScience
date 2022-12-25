# Data Visualization with Makie.jl {#sec:DataVisualizationMakie}

> From the japanese word Maki-e, which is a technique to sprinkle lacquer with gold and silver powder.
> Data is the gold and silver of our age, so let's spread it out beautifully on the screen!
>
> _Simon Danisch, Creator of `Makie.jl`_

[`Makie.jl`](https://docs.makie.org/stable/) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.
In our opinion, it is the prettiest and most powerful plotting package.

> **_NOTE:_**
> There are other plotting packages in the Julia ecosystem.
> One of the most popular ones is [`Plots.jl`](https://docs.juliaplots.org/stable/).
> However, we believe that the future of the Julia plotting tooling is in the `Makie.jl` ecosystem,
> due to the native Julia codebase and official support from [JuliaHub](https://juliahub.com).
> Therefore, this is where we'll focus all of our data visualization efforts.

`Makie.jl` deals with arrays (@sec:array), such as vectors and matrices.
This makes `Makie.jl` capable of dealing with any tabular data and especially `DataFrames` as we covered in @sec:dataframes.
Moreover, it uses special point types, i.e. `Point2f` and `Point3f` which come in handy
when defining vectores of points in 2d or 3d space.

Like many plotting packages, the code is split into multiple packages.
`Makie.jl` is the front end package that defines all plotting functions required to create plot objects.
These objects store all the information about the plots, but still need to be converted into an image.
To convert these plot objects into an image, you need one of the Makie backends.
By default, `Makie.jl` is reexported by every backend, so you only need to install and load the backend that you want to use.

There are four main backends which concretely implement all abstract rendering capabilities defined in Makie.
These are

- `CairoMakie.jl` for non-interactive 2D publication-quality vector graphics,
- `GLMakie.jl` for interactive 2D and 3D plotting in standalone `GLFW.jl` windows (also GPU-powered), and
- `WGLMakie.jl`, a WebGL-based interactive 2D and 3D plotting that runs within browsers.
- `RPRMakie.jl`, an experimental ray tracing backend using AMDs
[RadeonProRender](https://radeon-pro.github.io/RadeonProRenderDocs/en/index.html).
At the time of writing this book this only works on Windows and Linux.

[See Makie's documentation for more](https://docs.makie.org/stable/documentation/backends/index.html).

In this book we will only show examples for `CairoMakie.jl` and `GLMakie.jl`.

You can activate any backend by using the appropriate package and calling his corresponding `activate!` function.
For example:

```
using GLMakie
GLMakie.activate!()
```

Now, we will start with some basic plots and later one some more advanced publication-quality plots.
But, before going into plotting it is important to know how to save our plots.
The easiest option to `save` a figure `fig` is to type `save("filename.png", fig)`.
Other formats are also available for `CairoMakie.jl`, such as `svg` and `pdf`.
The resolution of the output image can easily be adjusted by passing extra arguments.
For example, for vector formats you specify `pt_per_unit`:

```
save("filename.pdf", fig; pt_per_unit=2)
```

or

```
save("filename.pdf", fig; pt_per_unit=0.5)
```

For `png`'s you specify `px_per_unit`.
See [Exporting a Figure with physical dimensions](https://docs.makie.org/stable/documentation/figure_size/) for details.

Another important issue is to actually visualize your output plot.
Note that for `CairoMakie.jl` the Julia REPL is not able to show plots, so you will need an IDE (Integrated Development Environment) such as VSCode, Jupyter or Pluto that supports `png` or `svg` as output.
On the other hand, `GLMakie.jl` can open interactive windows, or alternatively display bitmaps inline if `Makie.inline!(true)` is called.
