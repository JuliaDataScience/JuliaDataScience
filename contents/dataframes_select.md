## Select {#sec:select}

Whereas **`filter` removes rows**, **`select` removes columns**.
However, `select` is much more versatile than just removing columns, as we will discuss in this section.
First, let's create a dataset with multiple columns:

```jl
@sco responses()
```

Here, the data represents answers for five questions (`q1`, `q2`, ..., `q5`) in a given questionnaire.
We will start by "selecting" a few columns from this dataset.
As usual, we use symbols to specify columns:

```jl
s = "select(responses(), :id, :q1)"
sco(s, process=without_caption_label)
```

We can also use strings if we want:

```jl
s = """select(responses(), "id", "q1", "q2")"""
sco(s, process=without_caption_label)
```

To select everything _except_ one or more columns, use `Not` with either a single column:

```jl
s = """select(responses(), Not(:q5))"""
sco(s, process=without_caption_label)
```

Or, with multiple columns:

```jl
s = """select(responses(), Not([:q4, :q5]))"""
sco(s, process=without_caption_label)
```

It's also fine to mix and match columns that we want to preserve with columns that we do `Not` want to select:

```jl
s = """select(responses(), :q5, Not(:q5))"""
sco(s, process=without_caption_label)
```

Note how `q5` is now the first column in the `DataFrame` returned by `select`.
There is a more clever way to achieve the same using `:`.
The colon `:` can be thought of as "all the columns that we didn't include yet".
For example:

```jl
s = """select(responses(), :q5, :)"""
sco(s, process=without_caption_label)
```

Or, to put `q5` at the second position[^sudete]:

[^sudete]: thanks to Sudete on Discourse (<https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/4>) for this suggestion.

```jl
s = "select(responses(), 1, :q5, :)"
sco(s, process=without_caption_label)
```

> **_NOTE:_**
> As you might have observed there are several ways to select a column.
> These are known as [_column selectors_](https://bkamins.github.io/julialang/2021/02/06/colsel.html).
>
> We can use:
>
> * `Symbol`: `select(df, :col)`
>
> * `String`: `select(df, "col")`
>
> * `Integer`: `select(df, 1)`

Even renaming columns is possible via `select` using the `source => target` pair syntax:

```jl
s = """select(responses(), 1 => "participant", :q1 => "age", :q2 => "nationality")"""
sco(s, process=without_caption_label)
```

Additionally, thanks to the "splat" operator `...` (see @sec:splat), we can also write:

```jl
s = """
    renames = (1 => "participant", :q1 => "age", :q2 => "nationality")
    select(responses(), renames...)
    """
sco(s, process=without_caption_label)
```

## Types and Missing Data {#sec:missing_data}

```{=comment}
Try to combine with transformations

categorical
allowmissing
disallowmissing
```

As discussed in @sec:load_save, `CSV.jl` will do its best to guess what kind of types your data have as columns.
However, this won't always work perfectly.
In this section, we show why suitable types are important and we fix wrong data types.
To be more clear about the types, we show the text output for `DataFrame`s instead of a pretty-formatted table.
In this section, we work with the following dataset:

```jl
@sco process=string post=output_block wrong_types()
```

Because the date column has the wrong type, sorting won't work correctly:

```{=comment}
Whoa! You haven't introduced the reader to sorting with `sort` yet.
```

```jl
s = "sort(wrong_types(), :date)"
scsob(s)
```

To fix the sorting, we can use the `Date` module from Julia's standard library as described in @sec:dates:

```jl
@sco process=string post=output_block fix_date_column(wrong_types())
```

Now, sorting will work as intended:

```jl
s = """
    df = fix_date_column(wrong_types())
    sort(df, :date)
    """
scsob(s)
```

For the age column, we have a similar problem:

```jl
s = "sort(wrong_types(), :age)"
scsob(s)
```

This isn't right, because an infant is younger than adults and adolescents.
The solution for this issue and any sort of categorical data is to use `CategoricalArrays.jl`:

```
using CategoricalArrays
```

With the `CategoricalArrays.jl` package, we can add levels that represent the ordering of our categorical variable to our data:

```jl
@sco process=string post=output_block fix_age_column(wrong_types())
```

> **_NOTE:_**
> Also note that we are passing the argument `ordered=true` which tells `CategoricalArrays.jl`'s `categorical` function that our categorical data is "ordered".
> Without this any type of sorting or bigger/smaller comparisons would not be possible.

Now, we can sort the data correctly on the age column:

```jl
s = """
    df = fix_age_column(wrong_types())
    sort(df, :age)
    """
scsob(s)
```

Because we have defined convenient functions, we can now define our fixed data by just performing the function calls:

```jl
@sco process=string post=output_block correct_types()
```

Since age in our data is ordinal (`ordered=true`), we can properly compare categories of age:

```jl
s = """
    df = correct_types()
    a = df[1, :age]
    b = df[2, :age]
    a < b
    """
scob(s)
```

which would give wrong comparisons if the element type were strings:

```jl
s = "\"infant\" < \"adult\""
scob(s)
```
