# Data Visualization with Makie.jl {#sec:DataVisualizationMakie}

> From the japanese word Maki-e, which is a technique to sprinkle lacquer with gold and silver powder.
> Data is the gold and silver of our age, so let's spread it out beautifully on the screen!
>
> _Simon Danisch, Creator of `Makie.jl`_

[Makie.jl](http://makie.juliaplots.org/stable/index.html#Welcome-to-Makie!) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.
In our opinion, it is the prettiest and most versatile plotting package.

`Makie.jl` is the frontend package that defines all plotting functions.
It is reexported by every backend _(the machinery behind-the-scenes making the figure)_, so you don't have to specifically install or import it.
There are three main backends which concretely implement all abstract rendering capabilities defined in Makie.
One for non-interactive 2D publication-quality vector graphics: `CairoMakie.jl`.
Another for interactive 2D and 3D plotting in standalone `GLFW.jl` windows (also GPU-powered), `GLMakie.jl`.
And the third one, a WebGL-based interactive 2D and 3D plotting that runs within browsers, `WGLMakie.jl`. [See Makie's documentation for more](http://makie.juliaplots.org/v0.15.2/documentation/backends_and_output/).

In this book we will only show examples for `CairoMakie.jl` and `GLMakie.jl`.

You can activate any backend by using the appropriate package and calling its `activate!` function.
For example:

```
using GLMakie
GLMakie.activate!()
```

Now, we will start with publication-quality plots. But, before going into plotting it is important to know how to save our plots.
The easiest option to `save` a figure `fig` is to type `save("filename.png", fig)`.
Other formats are also available for `CairoMakie.jl`, such as `svg` and `pdf`.
Regarding the resolution output, this one can be easily scale by calling extra arguments.
For vector formats you specify `pt_per_unit`, e.g.

```
save("filename.pdf", fig; pt_per_unit = 2)
``` 
or 

```
save("filename.pdf", fig; pt_per_unit = 0.5)
```

to scale up or down respectively. For `png`'s you specify `px_per_unit`, also scaling up or down as previously mentioned.
For a complete overview please visit [Backends & Output](https://makie.juliaplots.org/v0.15.2/documentation/backends_and_output/#backends_output) in the official documentation.
