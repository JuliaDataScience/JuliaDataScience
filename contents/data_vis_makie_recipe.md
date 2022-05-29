## A Makie recipe for a DataFrame {#sec:recipe_df}

Unlike other libraries that already support a wide set of input formats via recipes, i.e. `Plots.jl`, in `Makie.jl` most of the time we need to pass the raw data to functions.
However, we can also define our own  `recipe` in  `Makie.jl`.
A `recipe` is your own custom plotting type command.
This extension is done just in `Makie.jl`, which means that making a new set of plotting rules for your own types is light, namely, you don't need the complete plotting machinery available to define them. This is specially useful if you want to include your own plotting commands in one of your own packages.
However, in order for them to work you will still need to use one of the backends, i.e., GLMakie or CairoMakie.

As an example we will code a small **full recipe** for a `DataFrame`. Please refer to the [documentation](https://makie.juliaplots.org/stable/documentation/recipes/) for more details.

A Makie `recipe` consist of two parts, a plot `type` name defined via `@recipe` and a custom `plot!(::Makie.plot)` which creates the actual plot via plotting functions already defined.

```jl
s = """
    @recipe(DfPlot, df) do scene
        Attributes(
            x = :A,
            y = :B,
            c = :C,
            color = :red,
            colormap = :plasma,
            markersize = 20,
            marker = :rect
        )
    end
    """
sc(s)
```

Note that the macro `@recipe` will automatically create two new functions for us, `dfplot` and `dfplot!`, all lowercase from our type `DfPlot`.
The first one will create a complete new figure whereas the second one will plot into the current axis or an axis of your choosing.
This allows us to plot `DataFrame`s which contains columns named, `x`, `y`, `z`.
Now, let's take care of our plot definition.
We will do a simple scatter plot:

```
import Makie
```

```jl
s = """
    function Makie.plot!(p::DfPlot{<:Tuple{<:DataFrame}})
        df = p[:df][]
        x = getproperty(df, p[:x][])
        y = getproperty(df, p[:y][])
        c = getproperty(df, p[:c][])
        scatter!(p, x, y; color = c, markersize = p[:markersize][],
            colormap = p[:colormap][], marker = p[:marker][])
        return p
    end
    """
sc(s)
```

Note the extras `[]` at the end of each variable.
Those are due to the fact that *recipes* in Makie are dynamic, meaning that our plots will update if our variables change.
See [observables](https://makie.juliaplots.org/stable/documentation/nodes/) to know more.
Now, we apply our new plotting function to the following `DataFrame`:

```jl
s = """
    df_recipe = DataFrame(A=randn(10), B=randn(10), C=rand(10))
    """
sc(s)
```

```jl
s = """
    CairoMakie.activate!() # hide
    dfplot(df_recipe)
    label = "dfRecipe" # hide
    caption = "DataFrames recipe." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

The named attributes in the recipe allows us to pass custom names to our new plotting function. Namely:

```jl
s = """
    df_names = DataFrame(a1=rand(100), a2=rand(100), a3=rand(100))
    """
sc(s)
```

and:

```jl
s = """
    CairoMakie.activate!() # hide
    dfplot(df_names; x = :a1, y = :a2, c = :a3, marker = 'o',
        axis = (; aspect=1, xlabel = "a1", ylabel = "a2"),
        figure = (; backgroundcolor = :grey90))
    label = "dfRecipeArgs" # hide
    caption = "DataFrames recipe with arguments." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Note, that now we are calling by name each column as well as the marker type, allowing us to use this definition for different DataFrames.
Additionally, all our previous options, i.e., `axis` or `figure` also work!
