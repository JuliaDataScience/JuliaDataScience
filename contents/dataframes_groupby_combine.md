## Groupby and Combine {#sec:groupby_combine}

### Single Source Columns
<!-- That fits to the later "Multiple Source Columns" and also solves the
     "problem" stated in issue #221.
     (Seems like I have missed this one too ...) -->

In the R programming language, @wickham2011split has popularized the so-called split-apply-combine strategy for data transformations.
In essence, this strategy **splits** a dataset into distinct groups, **applies** one or more functions to each group, and then **combines** the result.
`DataFrames.jl` fully supports split-apply-combine.
We will use the student grades example like before.
Suppose that we want to know each student's mean grade:

```jl
@sco process=without_caption_label all_grades()
```

The strategy is to **split** the dataset into distinct students, **apply** the mean function to each student, and **combine** the result.

The split is called `groupby` and we give as second argument the column ID that we want to split the dataset into:

```jl
s = "groupby(all_grades(), :name)"
sco(s; process=string, post=plainblock)
```

We apply the `mean` function from Julia's standard library `Statistics` module:

```
using Statistics
```

To apply this function, use the `combine` function:

```jl
s = """
    gdf = groupby(all_grades(), :name)
    combine(gdf, :grade => mean)
    """
sco(s; process=without_caption_label)
```

Imagine having to do this without the `groupby` and `combine` functions.
We would need to loop over our data to split it up into groups, then loop over each split to apply a function, **and** finally loop over each group to gather the final result.
Therefore, the split-apply-combine technique is a great one to know.

### Multiple Source Columns {#sec:groupby_combine_multiple_source}

But what if we want to apply a function to multiple columns of our dataset?

```jl
s = """
    group = [:A, :A, :B, :B]
    X = 1:4
    Y = 5:8
    df = DataFrame(; group, X, Y)
    """
sco(s; process=without_caption_label)
```

This is accomplished in a similar manner:

```jl
s = """
    gdf = groupby(df, :group)
    combine(gdf, [:X, :Y] .=> mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```

Note that we've used the dot `.` operator before the right arrow `=>` to indicate that the `mean` has to be applied to multiple source columns `[:X, :Y]`.

To use composable functions, a simple way is to create a function that does the intended composable transformations.
For instance, for a series of values, let's first take the `mean` followed by `round` to a whole number (also known as an integer `Int`):

```jl
s = """
    gdf = groupby(df, :group)
    rounded_mean(data_col) = round(Int, mean(data_col))
    combine(gdf, [:X, :Y] .=> rounded_mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```
