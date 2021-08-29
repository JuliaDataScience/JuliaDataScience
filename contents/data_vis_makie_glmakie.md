## GLMakie.jl {#sec:glmakie}

Visualising data in 3D is also a common practice to gain insight from your data. 
A simple plot include of course, lines and points. So we will start with those and since we already know how layouts work, we will put that into practice. 

### Scatters and lines

For scatter plots we have two options, the first one is `scatter(x,y,z)` and the second one is `meshscatter(x,y,z)`. 
In the first one markers don't scale in the axis directions but in the later they do, becuase they are actual geometries in 3D space. See next example. 

```
using GLMakie
GLMakie.activate!()
```

```jl
@sco JDS.scatters_in_3D()
```

Note also, that a different geometry can be passed as marker, i.e., a square/rectangle and `colormap` for them as well. 
In the middle panel one could get perfect spheres by doing `aspect = :data` as in the last panel.

And doing `lines` or `scatterlines` is also straightforward. 

```jl
@sco JDS.lines_in_3D()
```

Plotting a `surface` is also easy to do as well as a `wireframe` and `contour` lines in 3D. 

### Surfaces, wireframe, contour, contourf and contour3d 

To show these cases we use the following `peaks` function.

```jl
@sc JDS.peaks()
```

Whose output for the different plotting functions is

```jl
@sco JDS.plot_peaks_function()
```

But this data can also be plotted with a `heatmap(x,y,z)`, `contour(x,y,z)` or `contourf(x,y,z)`. 

```jl
@sco JDS.heatmap_contour_and_contourf()
```

And by changing the `Axis` to an `Axis3`, these plots will be automatically be in the x-y plane. 

```jl
@sco JDS.heatmap_contour_and_contourf_in_a_3d_plane()
```

Something else that is easy to do is to mix all this plotting functions into just one plot, namely 

```jl
@sco JDS.mixing_surface_contour3d_contour_and_contourf()
```

Not bad, right? From there is clear that  any `heatmap`'s, `contour`'s, `contourf`'s or `image` can be plotted into any plane.

### Arrows and streamplots

Another plots that might be useful are `arrows` and `streamplot` which are important when we want to know the directions that a given variable will follow.

```
using LinearAlgebra
```

```jl
@sco JDS.arrows_and_streamplot_in_3d()
```

Other interesting examples are a  `mesh(obj)`, a `volume(x, y, z, vals)`, and a  `contour(x, y, z, vals)`. 

### Meshes and volumes 

```
using GeometryBasics
```

```jl
@sco JDS.mesh_volume_contour()
```

Note that here we are plotting to meshes in the same axis, one transparent sphere and a cube. 
Up to here, this covers most of the use cases in 3D, just a few are missing. Type for example `?linesegments`.

Taking as reference the previous example one can do the following custom plot with spheres and rectangles.

```
using GeometryBasics, Colors
```

```jl
@sco JDS.grid_spheres_and_rectangle_as_plate()
```

Here the rectangle is semi-transparent due to the alpha channel added to the RGB color. 
The rectangle function is quite versatil, for instance  3D boxes are easy do implement which in turn could be used for plotting a 3D histogram. See next working example.

```jl
@sco JDS.histogram_or_bars_in_3d()
```

Note, that you can also call `lines` or `wireframe` over a mesh object. 

### Filled line, band

For our last example we will show how to do a filled curve in 3D with `band` and some `linesegments`. 

```jl
@sco JDS.filled_line_and_linesegments_in_3D()
```

And with this our journey doing 3D plots has come to an end. If you combine all this tools amazing things can be created. 
Now, it's time to dig into the basic rules to create animations. 
