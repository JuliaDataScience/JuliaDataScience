## Variable Transformations

```{=comment}
Ifelse and case_when
```

In @sec:filter, we saw that `filter` works by taking one or more source columns and filtering it by applying a function.
In other words, we saw that `source => f::Function` like in, for example, `filter(:name => name -> name == "Alice", df)`.
In @sec:select, we saw that `select` can take one or more source columns and put it into one or more target columns `source => target` like in, for example, `select(df, :name => :people_names)`.
In this section, we discuss how to **transform** variables, that is, how to modify data.
This goes via `source => transformation => target`.

As a generous example, given the `grades_2020` dataset:

```jl
@sco process=without_caption_label grades_2020()
```

we can increase all the grades in `grades_2020` by 1:

```jl
s = """
    plus_one(grades) = grades .+ 1
    transform(grades_2020(), :grade_2020 => plus_one)
    """
sco(s; process=without_caption_label)
```

Here, the `plus_one` function receives the whole `:grade_2020` column and not just one element as one might expect.
That is the reason why we've added the broadcasting "dot" `.` before the plus symbol.
The `.`, in Julia's syntax, means broadcasting and allows Julia to add one to all the elements in `grades`.
For instance:

```jl
sco("[1, 2, 3] .+ 1")
```

Like said above, the `DataFrames.jl` minilanguage is `source => transformation => target`.
So, if we want to keep the naming of the `target` column in the output, we can do:

```jl
s = """
    transform(grades_2020(), :grade_2020 => plus_one => :grade_2020)
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

where the `:` means "select all the columns" as described in @sec:select.
Alternatively, it can be written by using Julia's broadcasting and modify column `grade_2020` by acessing the column with `df.grade_2020`:

```jl
s = """
    df = grades_2020()
    df.grade_2020 = plus_one.(df.grade_2020)
    df
    """
sco(s; process=without_caption_label)
```

But, although the last example is easier since it builds on more native Julia operations, we would advise to use the functions provided by `DataFrames.jl` in most cases.

To show how to transform two columns at the same time, we use the left joined data from @sec:join:

```jl
s = """
    leftjoined = leftjoin(grades_2020(), grades_2021(); on=:name)
    """
sco(s; process=without_caption_label)
```

With this, we can add a column saying whether someone was approved:

```jl
s = """
    pass(A, B) = [5.5 < a || 5.5 < b for (a, b) in zip(A, B)]
    transform(leftjoined, [:grade_2020, :grade_2021] => pass => :pass)
    """
sco(s; process=without_caption_label)
```

We can clean up the outcome and put the logic in a function to get a list of the people who passed:

```jl
@sco only_pass()
```
