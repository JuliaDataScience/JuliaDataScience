## Select {#sec:select}

Whereas `filter` removes rows, `select` removes columns.
However, `select` is much more versatile than just removing columns, as we will discuss in this section.
First, let's create a dataset with multiple columns:

```jl
@sco responses()
```

Here, the data represents answers on five questions (`q1`, `q2`, ..., `q5`) in a questionnaire.
We will start by "selecting" a few columns from this dataset.
Again, we use symbols to specify columns:

```jl
s = "select(responses(), :id, :q1)"
sco(s, process=without_caption_label)
```

We can also use strings if we want:

```jl
s = """select(responses(), "id", "q1", "q2")"""
sco(s, process=without_caption_label)
```

To select everything _except_ one or more columns, use `Not` with either a single column name:

```jl
s = """select(responses(), Not(:q5))"""
sco(s, process=without_caption_label)
```

Or, with multiple column names:

```jl
s = """select(responses(), Not([:q4, :q5]))"""
sco(s, process=without_caption_label)
```

It's also fine to combine column names with `Not`:

```jl
s = """select(responses(), :q5, Not(:id))"""
sco(s, process=without_caption_label)
```

Note how `q5` is now the first column.
But, there is a more clever way to do this, and that is with `:`.
The colon `:` can be thought of as "all the columns that we didn't include yet".
For example:

```jl
s = """select(responses(), :q5, :)"""
sco(s, process=without_caption_label)
```

Or, to put `q5` at the second position[^sudete]:

[^sudete]: Thanks to Sudete on [Discourse](https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/4) for this suggestion.

```jl
s = "select(responses(), 1, :q5, :)"
sco(s, process=without_caption_label)
```

Even renaming columns is possible via `select`:

```jl
s = """select(responses(), 1 => "participant", :q1 => "age", :q2 => "nationality")"""
sco(s, process=without_caption_label)
```

which, thanks to the `...` operator, we can also write as:

```jl
s = """
    renames = (1 => "participant", :q1 => "age", :q2 => "nationality")
    select(responses(), renames...)
    """
sco(s, process=without_caption_label)
```

> **Note:** Another example of splatting via the `...` operator is:
> ```jl
  s = """
      V = ["a", "b", "c"]
      joinpath(V...)
      """
  scob(s)
  ```

## Types and Missing Data {#sec:missing_data}

```{=comment}
Try to combine with transformations

categorical
allowmissing
disallowmissing
```

As discussed in @sec:load_save, `CSV.jl` will do its best to guess data types for your data.
However, this won't always work perfectly.
In this section, we show why suitable types are important and we fix wrong data types.
To be more clear about the types, we show the text output for DataFrames instead of a pretty table.
In this section, we work with the following dataset:

```jl
@sco process=string post=output_block wrong_types()
```

Because the date column has the wrong type, sorting won't work correctly:

```jl
s = "sort(wrong_types(), :date)"
scsob(s)
```

To fix the sorting, we can use `Date` as described in @sec:dates:

```jl
@sco process=string post=output_block fix_date_column(wrong_types())
```

Now, sorting will work correctly:

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
The solution for this categorical data problem is to use `CategoricalArrays.jl`:

```
using CategoricalArrays
```

with the `CategoricalArrays.jl` package, we can add levels to our data:

```jl
@sco process=string post=output_block fix_age_column(wrong_types())
```

Now, we can sort the data correctly on the age column:

```jl
s = """
    df = fix_age_column(wrong_types())
    sort(df, :age)
    """
scsob(s)
```

Since we have worked with functions, we can now define our fixed data as:

```jl
@sco process=string post=output_block correct_types()
```

Note that the keyword argument `ordered` set to `true` signals `CategoricalArrays.jl` that the data is ordinal.
In other words, because the data is ordinal, we can compare elements:

```jl
s = """
    df = correct_types()
    a = df[1, :age]
    b = df[2, :age]
    a < b
    """
scob(s)
```

which would have been wrong for strings:

```jl
s = "\"infant\" < \"adult\""
scob(s)
```

