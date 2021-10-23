## GLMakie.jl {#sec:glmakie}

`CairoMakie.jl` supplies all our needs for static 2D images.
But sometimes we want interactivity, especially when we are dealing with 3D images.
Visualizing data in 3D is also a common practice to gain insight from your data.
This is where `GLMakie.jl` might be helpful, since it uses [OpenGL](http://www.opengl.org/) as a backend that adds interactivity and responsiveness to plots.
Like before, a simple plot includes, of course, lines and points. So, we will start with those and since we already know how layouts work, we will put that into practice.

### Scatters and Lines

For scatter plots we have two options, the first one is `scatter(x, y, z)` and the second one is `meshscatter(x, y, z)`.
In the first one markers don't scale in the axis directions, but in the later they do because they are actual geometries in 3D space.
See the next example:

```
using GLMakie
GLMakie.activate!()
```

```jl
@sco JDS.scatters_in_3D()
```

Note also, that a different geometry can be passed as markers, i.e., a square/rectangle and we can assign a `colormap` for them as well.
In the middle panel one could get perfect spheres by doing `aspect = :data` as in the right panel.

And doing `lines` or `scatterlines` is also straightforward:

```jl
@sco JDS.lines_in_3D()
```

Plotting a `surface` is also easy to do as well as a `wireframe` and `contour` lines in 3D.

### Surfaces, wireframe, contour, contourf and contour3d

To show these cases we'll use the following `peaks` function:

```jl
@sc JDS.peaks()
```

The output for the different plotting functions is

```jl
@sco JDS.plot_peaks_function()
```

But, it can also be plotted with a `heatmap(x, y, z)`, `contour(x, y, z)` or `contourf(x, y, z)`:

```jl
@sco JDS.heatmap_contour_and_contourf()
```

Additionally, by changing `Axis` to an `Axis3`, these plots will be automatically be in the x-y plane:

```jl
@sco JDS.heatmap_contour_and_contourf_in_a_3d_plane()
```

Something else that is easy to do is to mix all these plotting functions into just one plot, namely:

```
using TestImages
```

```jl
@sco JDS.mixing_surface_contour3d_contour_and_contourf()
```

Not bad, right? From there is clear that  any `heatmap`'s, `contour`'s, `contourf`'s or `image` can be plotted into any plane.

### Arrows and Streamplots

`arrows` and `streamplot` are plots that might be useful when we want to know the directions that a given variable will follow.
See a demonstration below^[we are using the `LinearAlgebra` module from Julia's standard library.]:

```
using LinearAlgebra
```

```jl
@sco JDS.arrows_and_streamplot_in_3d()
```

Other interesting examples are a `mesh(obj)`, a `volume(x, y, z, vals)`, and a `contour(x, y, z, vals)`.

### Meshes and Volumes

Drawing Meshes comes in handy when you want to plot geometries, like a `Sphere` or a Rectangle, i. e. `FRect3D`.
Another approach to visualize points in 3D space is by calling the functions `volume` and `contour`, which implements [ray tracing](https://en.wikipedia.org/wiki/Ray_tracing_(graphics)) to simulate a wide variety of optical effects.
See the next examples:

```
using GeometryBasics
```

```jl
@sco JDS.mesh_volume_contour()
```

Note that here we are plotting two meshes in the same axis, one transparent sphere and a cube.
So far, we have covered most of the 3D use-cases.
Another example is `?linesegments`.

Taking as reference the previous example one can do the following custom plot with spheres and rectangles:

```
using GeometryBasics, Colors
```

```jl
@sco JDS.grid_spheres_and_rectangle_as_plate()
```

Here, the rectangle is semi-transparent due to the alpha channel added to the RGB color.
The rectangle function is quite versatile, for instance  3D boxes are easy do implement which in turn could be used for plotting a 3D histogram.
See our next example:

```jl
@sco JDS.histogram_or_bars_in_3d()
```

Note, that you can also call `lines` or `wireframe` over a mesh object.

### Filled Line and Band

For our last example we will show how to do a filled curve in 3D with `band` and some `linesegments`:

```jl
@sco JDS.filled_line_and_linesegments_in_3D()
```

Finally, our journey doing 3D plots has come to an end.
You can combine everything we exposed here to create amazing 3D images!
