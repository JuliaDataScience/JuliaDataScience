## Themes {#sec:themes}

There are several ways to affect the general appearance of your plots.
Either, you could use a [predefined theme](http://makie.juliaplots.org/stable/predefined_themes.html) or your own custom theme.
For example, to use the predefined dark theme via `with_theme(your_plot_function, theme_dark())`.
Or, build your own with `Theme(kwargs)` or even update the one that is active with `update_theme!(kwargs)`.

You can also do `set_theme!(theme; kwargs...)` to change the current default theme to `theme` and override or add attributes given by `kwargs`.
If you do this and want to reset all previous setting just do `set_theme!()` with no arguments.
See it in action in the following examples:


```jl
@sc demo_themes()
```

```jl
s = """
    CairoMakie.activate!() # hide
    filenames = ["theme_dark()", "theme_black()", "theme_ggplot2()", # hide
        "theme_minimal()", "theme_light()"] # hide
    objects = [ # hide
        with_theme(demo_themes, theme_dark())
        with_theme(demo_themes, theme_black())
        with_theme(demo_themes, theme_ggplot2())
        with_theme(demo_themes, theme_minimal())
        with_theme(demo_themes, theme_light())
    ] # hide
   #link_attributes = "width=60%" # hide
    Options.(objects, filenames) # hide
    """
sco(s)
```

Or, defining a custom `Theme` by doing `with_theme(your_plot_function, your_theme())`.
For instance, the following theme could be a simple version for a publication quality template:

```jl
@sc publication_theme()
```

```jl
@sc plot_with_legend_and_colorbar()
```

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

Now, if something needs to be changed after `set_theme!(your_theme)`, we can do it with `update_theme!(resolution = (500,400), fontsize = 18)`.
Another approach will be to pass additional arguments to the `with_theme` function:

```jl
s = """
    CairoMakie.activate!() # hide
    fig = (resolution = (410,400), figure_padding = 1, backgroundcolor= :grey90)
    ax = (; aspect = DataAspect())
    cbar = (; height = Relative(4/5))
    with_theme(publication_theme(); fig..., Axis = ax, Colorbar = cbar) do
        plot_with_legend_and_colorbar()
    end
    label = "plot_theme_extra_args" # hide
    caption = "Theme with extra args." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Now, let's move on and do a plot with LaTeX strings and a custom theme.
