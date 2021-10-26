# Data Visualization with Makie.jl {#sec:DataVisualizationMakie}

> From the japanese word Maki-e, which is a technique to sprinkle lacquer with gold and silver powder.
> Data is the gold and silver of our age, so let's spread it out beautifully on the screen!
>
> _Simon Danisch, Creator of `Makie.jl`_

[Makie.jl](http://makie.juliaplots.org/stable/index.html) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.
In our opinion, it is the prettiest and most versatile plotting package.

Like many plotting packages, the code is split into multiple packages.
`Makie.jl` is the front end package that defines all plotting functions required to create plot objects.
These objects store all information about the plots, but still need to be converted to an image.
To convert these plot objects to an image, you need one of the Makie back ends.
By default, `Makie.jl` is reexported by every backend, so you only need to install and load the back end that you want to use.

There are three main back ends which concretely implement all abstract rendering capabilities defined in Makie.
One for non-interactive 2D publication-quality vector graphics: `CairoMakie.jl`.
Another for interactive 2D and 3D plotting in standalone `GLFW.jl` windows (also GPU-powered), `GLMakie.jl`.
And the third one, a WebGL-based interactive 2D and 3D plotting that runs within browsers, `WGLMakie.jl`. [See Makie's documentation for more](http://makie.juliaplots.org/stable/documentation/backends_and_output/).

In this book we will only show examples for `CairoMakie.jl` and `GLMakie.jl`.

You can activate any backend by using the appropriate package and calling its `activate!` function.
For example:

```
using GLMakie
GLMakie.activate!()
```

Now, we will start with publication-quality plots.
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
See [Backends & Output](https://makie.juliaplots.org/stable/documentation/backends_and_output/) for details.
