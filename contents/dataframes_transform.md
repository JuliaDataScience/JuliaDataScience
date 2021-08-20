## Variable Transformations

```{=comment}
We need to cover `ifelse` and `case_when`
```

In @sec:filter, we saw that `filter` works by taking one or more source columns and filtering it by applying a "filtering" function.
To recap here's an example of filter using the `source => f::Function` syntax: `filter(:name => name -> name == "Alice", df)`.

In @sec:select, we saw that `select` can take one or more source columns and put it into one or more target columns `source => target`.
Also to recap here's an example: `select(df, :name => :people_names)`.

In this section, we discuss how to **transform** variables, that is, how to **modify data**.
In `DataFrames.jl`, the syntax is `source => transformation => target`.

Like before, we use the `grades_2020` dataset:

```jl
@sco process=without_caption_label grades_2020()
```

Suppose we would want to increase all the grades in `grades_2020` by 1.
First, we define a function that take as argument a vector of data and return all of its elements increased by 1.
Then we use the `transform` function from `DataFrames.jl` that, as all native `DataFrames.jl`'s functions, takes a `DataFrame` as first argument followed by the transformation syntax:

```jl
s = """
    plus_one(grades) = grades .+ 1
    transform(grades_2020(), :grade_2020 => plus_one)
    """
sco(s; process=without_caption_label)
```

Here, the `plus_one` function receives the whole `:grade_2020` column.
That is the reason why we've added the broadcasting "dot" `.` before the plus `+` operator.
For a recap on broadcasting please see @sec:broadcasting.

Like said above, the `DataFrames.jl` minilanguage is always `source => transformation => target`.
So, if we want to keep the naming of the `target` column in the output, we can do:

```jl
s = """
    transform(grades_2020(), :grade_2020 => plus_one => :grade_2020)
    """
sco(s; process=without_caption_label)
```

We can also use the keyword argument `renamecols=false`:

```jl
s = """
    transform(grades_2020(), :grade_2020 => plus_one; renamecols=false)
    """
sco(s; process=without_caption_label)
```

The same transformation can also be written with `select` as follows:

```jl
s = """
    select(grades_2020(), :, :grade_2020 => plus_one => :grade_2020)
    """
sco(s; process=without_caption_label)
```

Where the `:` means "select all the columns" as described in @sec:select.
Alternatively, you can also use Julia's broadcasting and modify the column `grade_2020` by acessing it with `df.grade_2020`:

```jl
s = """
    df = grades_2020()
    df.grade_2020 = plus_one.(df.grade_2020)
    df
    """
sco(s; process=without_caption_label)
```

But, although the last example is easier since it builds on more native Julia operations, **we strongly advise to use the functions provided by `DataFrames.jl` in most cases because they are more capable and easier to work with.**

### Multiple Transformations {#sec:multiple_transform}

To show how to transform two columns at the same time, we use the left joined data from @sec:join:

```jl
s = """
    leftjoined = leftjoin(grades_2020(), grades_2021(); on=:name)
    """
sco(s; process=without_caption_label)
```

With this, we can add a column saying whether someone was approved by the criterion that all of his grades were above 5.5:

```jl
s = """
    pass(A, B) = [5.5 < a || 5.5 < b for (a, b) in zip(A, B)]
    transform(leftjoined, [:grade_2020, :grade_2021] => pass; renamecols=false)
    """
sco(s; process=without_caption_label)
```

```{=comment}
I don't think you have covered vector of symbols as col selector...
You might have to do this in the `dataframes_select.md`
```

We can clean up the outcome and put the logic in a function to get a list of all the approved students:

```jl
@sco only_pass()
```
