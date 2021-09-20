## Statistical Visualizations {#sec:stats_vis}

There are several statistical visualization techniques.
We will focus on mainly two: box plots and density plots, since they are the most used and our preferred way to analyze univariate data.

We will also use the same `more_grades` dataset from @sec:stats_central.

### Box Plots {#sec:stats_vis_boxplots}

Box plots are ...

The basic box plot can be drawn using `Makie.jl` (see Chapter -@sec:datavisMakie).
It accepts a `x` and `y` vectors which represents the positions of the categories and the variables within the boxes, respectively.
Since our vector `x` is a `Vector{String}` we need to convert it to `categorical` using `CategoricalArrays` (@sec:missing_data) and then pass the `Axis` keyword argument `xticks` (see @sec:datavisMakie_attributes) as a tuple of values and labels.
For the `xticks`' labels we used the `levels` function from `CategoricalArrays.jl` that returns the categorical levels from our `name` variable in the same order as the integer codes.
Finally, for the `x` vector inside Makie's `boxplot` function, we wrap the `name` variable with the `levelcode` function, also from `CategoricalArrays.jl`, which returns the underlying integer codes from our categorical variable `name`.
We do this because Makie's `boxplot` only accepts a vector of `Int`s as inputs for the `x` argument.
Here is the code:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "boxplot" # hide
    caption = "Box Plot" # hide
    df = more_grades()
    transform!(df, :name => categorical; renamecols=false)
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; xticks = (1:4, levels(df.name)))
    boxplot!(ax, levelcode.(df.name), df.grade)
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

### Density Plots {#sec:stats_vis_densityplots}

Density plots are ...

The density plot can also be drawn using `Makie.jl`, however it is more convoluted than the box plot.
First, we want to pass for each `density!` function only the values with respect to one observation.
Thus, we define a `values` function that will accept a `code` argument to filter the dataset's variable `name` wrapped with the `levelcode` function.
Then, we plot a density `pltobj` for each one of the variable `name`'s `levels`.
Finally, we make sure that the density `plotobj`s have their own `ytick` with the `offset` keyword paired with a custom `yticks` in the `Axis` constructor by specifying, same as before, a tuple of values and labels.
The effect of the `offset` in the `for` loop is the increment from 1 to 4, by 1, of both the `offset` argument for `density!` and the `code` argument for `values`:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "densityplot" # hide
    caption = "Density Plot" # hide
    df = more_grades()
    transform!(df, :name => categorical; renamecols=false)
    categories = levels(df.name)
    values(code) = filter(row -> levelcode.(row.name) == code, df).grade
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; yticks = (1:4, categories), limits=((-1, 11), nothing))
    for i in 1:length(categories)
        density!(ax, values(i); offset=i)
    end
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

### Anscombe Quartet {#sec:stats_vis_anscombe}

The importance of visualizations.
