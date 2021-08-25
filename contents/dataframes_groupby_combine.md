## Groupby and combine {#sec:groupby_combine}

In the R programming language, @wickham2011split has popularized the, so called, split-apply-combine strategy for data transformations.
In essence, this strategy **splits** a dataset in groups, **applies** one or more functions to each group, and then **combines** the result.
`DataFrames.jl` fully supports split-apply-combine, so we can give a quick demo.
To get a suitable example dataset, suppose that we want to know the mean grade for each person:

```jl
@sco process=without_caption_label all_grades()
```

The strategy becomes to **split** the dataset in persons, **apply** the mean to each person, and **combine** the result.

The split is called `groupby`:

```jl
s = "groupby(all_grades(), :name)"
sco(s; process=string, post=plainblock)
```

We apply the `mean` from Julia's `Statistics` module:

```
using Statistics
```

Applying this function is done inside `combine`:

```jl
s = """
    gdf = groupby(all_grades(), :name)
    combine(gdf, :grade => mean)
    """
sco(s; process=without_caption_label)
```

Imagine having to do this without the `groupby` and `combine` functions, then we would need to loop over our data to split it up into groups, loop over each split to apply a function, **and** loop over each group to gather the final result.
Therefore, the split-apply-combine trick is a great one to know.

But what if we want to calculate some function over multiple columns?

```jl
s = """
    group = [:A, :A, :B, :B]
    X = 1:4
    Y = 5:8
    df = DataFrame(; group, X, Y)
    """
sco(s; process=without_caption_label)
```

Even that is surprisingly easy:

```jl
s = """
    gdf = groupby(df, :group)
    combine(gdf, [:X, :Y] .=> mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```

Note that we've used the dot before the rightarrow to indicate that the mean has to be calculated for multiple `source` columns.

To use multiple functions, one way is to use create a new function.
For instance, let's first take the mean and then round the number to a whole number, which is also known as an integer:

```jl
s = """
    gdf = groupby(df, :group)
    rounded_mean(data_col) = round(Int, mean(data_col))
    combine(gdf, [:X, :Y] .=> rounded_mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```
