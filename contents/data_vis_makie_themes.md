## Themes {#sec:themes}

There are several ways to affect the general appearance of your plots.
Either, you could use a [predefined theme](http://makie.juliaplots.org/stable/documentation/theming/predefined_themes/index.html) or your own custom theme.
For example, use the predefined dark theme via `with_theme(your_plot_function, theme_dark())`.
Or, build your own with `Theme(kwargs)` or even update the one that is active with `update_theme!(kwargs)`.

You can also do `set_theme!(theme; kwargs...)` to change the current default theme to `theme` and override or add attributes given by `kwargs`.
If you do this and want to reset all previous settings just do `set_theme!()` with no arguments.
See the following examples, where we had prepared a test plotting function with different characteristics, such that most attributes for each theme can be appreciated.

```jl
sco(
"""
using Random: seed!
seed!(123)
y = cumsum(randn(6, 6), dims=2)
"""
)
```

A matrix of size `(20, 20)` with random entries, so that we can plot a heatmap.
The range in $x$ and $y$ is also specified.

```jl
sco(
"""
using Random: seed!
seed!(13)
xv = yv = LinRange(-3, 0.5, 20)
matrix = randn(20, 20)
matrix[1:6, 1:6] # first 6 rows and columns
"""
)
```

Hence, our plotting function looks like follows:

```jl
@sc demo_themes(y, xv, yv, matrix)
```

Note that the `series` function has been used to plot several lines and scatters at once with their corresponding labels. And since we don't need the axis neither the plotted object we throw them away with the syntax *_*.
Also, a heatmap with their `Colorbar` has been included.
Currently, there are two dark themes, one called `theme_dark()` and the other one `theme_black()`, see Figures.

```jl
s = """
    CairoMakie.activate!() # hide
    filenames = ["theme_dark", "theme_black"] # hide
    objects = [ # hide
    # Don't indent here because it indent the output incorrectly. # hide
    with_theme(theme_dark()) do
        demo_themes(y, xv, yv, matrix)
    end
    with_theme(theme_black()) do
        demo_themes(y, xv, yv, matrix)
    end
    ] # hide
    link_attributes = "width=60%" # hide
    Options(obj, filename, link_attributes) = Options(obj; filename, link_attributes) # hide
    Options.(objects, filenames, link_attributes) # hide
    """
sco(s)
```

And three more white-ish themes called, `theme_ggplot2()`, `theme_minimal()` and `theme_light()`. Useful for more standard publication type plots.

```jl
s = """
    CairoMakie.activate!() # hide
    filenames = ["theme_ggplot2", # hide
        "theme_minimal", "theme_light"] # hide
    objects = [ # hide
    # Don't indent here because it indent the output incorrectly. # hide
    with_theme(theme_ggplot2()) do
        demo_themes(y, xv, yv, matrix)
    end
    with_theme(theme_minimal()) do
        demo_themes(y, xv, yv, matrix)
    end
    with_theme(theme_light()) do
        demo_themes(y, xv, yv, matrix)
    end
    ] # hide
    link_attributes = "width=60%" # hide
    Options(obj, filename, link_attributes) = Options(obj; filename, link_attributes) # hide
    Options.(objects, filenames, link_attributes) # hide
    """
sco(s)
```

Another alternative is defining a custom `Theme` by doing `with_theme(your_plot, your_theme())`.
For instance, the following theme could be a simple version for a publication quality template:

```jl
@sc publication_theme()
```

Which, for simplicity we use it to plot `scatterlines` and a `heatmap`.

```jl
@sc plot_with_legend_and_colorbar()
```

Then, using the previously define `Theme` the output is shown in Figure (@fig:plot_with_legend_and_colorbar).

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(plot_with_legend_and_colorbar, publication_theme())
    label = "plot_with_legend_and_colorbar" # hide
    caption = "Themed plot with Legend and Colorbar." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, label, caption, link_attributes) # hide
    """
sco(s)
```

Here we have use `with_theme` which is more convenient for the direct application of a theme than the `do` syntax. You should use the latter if you want to include extra arguments to the theme that is going to be applied.

Now, if something needs to be changed after `set_theme!(your_theme)`, we can do it with `update_theme!(resolution=(500, 400), fontsize=18)`, for example.
Another approach will be to pass additional arguments to the `with_theme` function:

```jl
s = """
    CairoMakie.activate!() # hide
    fig = (resolution=(600, 400), figure_padding=1, backgroundcolor=:grey90)
    ax = (; aspect=DataAspect(), xlabel=L"x", ylabel=L"y")
    cbar = (; height=Relative(4 / 5))
    with_theme(publication_theme(); fig..., Axis=ax, Colorbar=cbar) do
        plot_with_legend_and_colorbar()
    end
    label = "plot_theme_extra_args" # hide
    caption = "Theme with extra args." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Where the x and y labels have a Latex format due to `L"..."`.
Most basic Latex strings are already supported by Makie, however to fully exploit this integration is recommend to also load the package LaTeXStrings as stated in the next section.
