## Statistical Visualizations {#sec:stats_vis}

There are several statistical visualization techniques.
We will focus on mainly two: **box plots** and **density plots**, since they are the most used and our preferred way to analyze univariate data.

We will also use the same `more_grades` dataset from @sec:stats_central.

### Box Plots {#sec:stats_vis_boxplots}

Box plots are a method for graphically depicting numerical data through their quartiles.
The "box" is typically represented by the quartiles 1 to 3.
The median, second quartile -- Q2, or percentile 0.5, is the line inside the box.
The first and third quartile, Q1 and Q3, or percentiles 0.25 and 0.75, respectively, are the box's lower and upper bounds.
Finally, we have the "whisker" which, traditionally (and default in most data visualization techniques), is the range composed by extending the interquartile range (IQR) by 1.5.

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

The default IQR range for the whiskers in `Makie.jl` is 1.5.
However, sometimes we see the whiskers either with a different IQR range or with a small vertical bar to better visualize the whiskers tips.
We can control both of those with the `range` (default `1.5`) and `whiskerwidth` (default `0.0`) arguments:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "boxplot_custom" # hide
    caption = "Box Plot with different IQR and Whiskers Vertical Bars" # hide
    df = more_grades()
    transform!(df, :name => categorical; renamecols=false)
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; xticks = (1:4, levels(df.name)))
    boxplot!(ax, levelcode.(df.name), df.grade; range=2.0, whiskerwidth=0.5)
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

Box plots can also flag anything outside the whiskers as outliers.
By default, these observations are not shown in `Makie.jl` but you can control it with the `show_outliers` argument:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "boxplot_outliers" # hide
    caption = "Box Plot with Outliers" # hide
    df = more_grades()
    transform!(df, :name => categorical; renamecols=false)
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1]; xticks = (1:4, levels(df.name)))
    boxplot!(ax, levelcode.(df.name), df.grade; range=0.5, show_outliers=true)
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

As you can see, **box plots are a useful way to visualize data with robust central tendencies and dispersion measures to outliers**.

### Histograms {#sec:stats_vis_histograms}

Box plots limit us just to summary statistics like median, quartiles and IQRs.
Often we want to see the underlying distribution of the data.
This is where histograms are useful.
**Histograms are approximate representations of the distribution of numerical data**.
We construct them by "binning", i.e. inserting into discrete bins the range of values into a series of intervals and then counting up how many values fall on each given interval.
The bins are represented as a bar in which the height describes the frequency of values belonging to that bin.

We can draw histograms using `Makie.jl`:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "histogram" # hide
    caption = "Histogram" # hide
    df = more_grades()
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1], xticks=1:10)
    hist!(ax, df.grade; color=(:dodgerblue, 0.5))
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

Note that by default `hist!` uses 15 bins.
We can change that with the `bins` keyword:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "histogram_bins" # hide
    caption = "Histogram with Custom Bins" # hide
    df = more_grades()
    fig = Figure(; resolution=(600, 400))
    ax = Axis(fig[1, 1], xticks=1:10)
    hist!(ax, df.grade; color=(:dodgerblue, 0.5), bins=10)
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

We can see clearly that most of the grades are between 4 and 9.

### Density Plots {#sec:stats_vis_densityplots}

Histograms are discrete approximations.
If we would like to have continuous approximations we need something else: **density plots**.
**Density plots are graphical density estimations of numerical data**.
It shows us the approximate distribution of a given variable by depicting it as a density, where the higher the curve at a given point more likely is the variable to take certain value.

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

As explained in @sec:makie_colors, we can change Makie's colors by either specifying a `color` or ` colormap`.
This can also be applied to `density`:

```jl
s = """
    CairoMakie.activate!() # hide
    label = "densityplot_colors" # hide
    caption = "Density Plots with Different Color Schemes" # hide
    df = more_grades()
    transform!(df, :name => categorical; renamecols=false)
    categories = levels(df.name)
    values(code) = filter(row -> levelcode.(row.name) == code, df).grade
    fig = Figure(; resolution=(600, 400))
    ax1 = Axis(fig[1, 1]; yticks = (1:4, categories), limits=((-1, 11), nothing))
    ax2 = Axis(fig[1, 2]; yticks = (1:4, categories), limits=((-1, 11), nothing))
    for i in 1:length(categories)
        density!(ax1, values(i); offset=i, color=(:dodgerblue, 0.5))
    end
    for i in 1:length(categories)
        density!(ax2, values(i); offset=i, color=:x, colormap=:viridis)
    end
    Options(current_figure(); filename=label, caption, label) # hide
    """
sco(s)
```

Here, in the first figure (left) we are using a specific `color` for all `density!`'s `plotobj`s.
And in the second figure (right) we pass the `:x` argument to `color` to tell Makie to apply the `colormap` gradient along the x-axis (from left to right) while also specifying which `colormap` palette as `:viridis`.

### Anscombe Quartet {#sec:stats_vis_anscombe}

We conclude this Statistics chapter with a demonstration of the **importance of data visualization in statistical analyzes**.
For this, we present the **Anscombe Quartet** [@anscombe1973graphs], which comprises four datasets that have *nearly identical* simple descriptive statistics, yet have very *different* distributions and appear very different when **graphed**.
Each dataset has 11 observations with `x` and `y` variables.
They were created in 1973 by the statistician Francis Anscombe to show the importance of graphing data before conducting statistical analyzes.
Here is the table with the four datasets:

```jl
Options(anscombe_quartet(;type="wide"); caption="Anscome Quartet", label="anscombe_quartet")
```

Now, if you look at the descriptive statistics for both `x` and `y` variables in all 4 datasets they are pretty much the same along with their correlation (both up to 2 decimal places):

```jl
s = """
    df = anscombe_quartet()
    round_up = x -> round(x; digits=2)
    combine(groupby(df, :dataset),
                    [:x, :y] .=> round_up .∘ [mean std],
                    [:x, :y]  => round_up ∘ cor)
    """
sco(s; process=without_caption_label)
```

Now, if we take a look at a simple scatter plot of all 4 datasets, we clearly see that something else is going on:

```jl
fig = plot_anscombe()
caption = "Anscombe Quartet"
label = "plot_anscombe"
Options(fig; filename=label, caption, label)
```

Here, the first dataset (upper left) is a frequent situation that we encounter in data science: `x` and `y` are correlated with added random noise.
The second dataset (upper right), we see a perfect correlation except for an outlier in the second to last observation.
For the third dataset (lower left), the relationship is non-linear.
Finally, for the fourth dataset (lower right) there isn't any relationship except by an outlier observation.

Anscombe Quartet tells us that sometimes **descriptive statistics can fool us** and we should rely also in **visualizations** to analyze our data.

