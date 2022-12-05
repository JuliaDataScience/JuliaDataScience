## Column Transformation {#sec:dataframesmeta_transform}

Whereas the `@select` macro variants performs column selection,
the `@transform` macro variants do _not_ perform any column selection.
It can either _overwrite_ existent columns or _create_ new columns that will be added to the right of our `DataFrame`.

For example, the previous operation on `:grade` can be invoked as a transformation with:

```jl
sco("""
# rtransform 1 # hide
@rtransform df :grade_100 = :grade * 10
"""; process=without_caption_label
)
```

As you can see, `@transform` does not perform column selection,
and the `:grade_100` column is created as a new column and added to the right of our `DataFrame`.

`DataFramesMeta.jl` macros also support `begin ... end` statements.
For example, suppose that you are creating two columns in a `@transform` macro:

```jl
sco("""
# rtransform 2 # hide
@rtransform df :grade_100 = :grade * 10 :grade_5 = :grade / 2
"""; process=without_caption_label
)
```

It can be cumbersome and difficult to read the performed transformations.
To facilitate that, we can use `begin ... end` statements and put one transformation per line:

```jl
sco("""
# rtransform 3 # hide
@rtransform df begin
    :grade_100 = :grade * 10
    :grade_5 = :grade / 2
end
"""; process=without_caption_label
)
```

This makes much easier to analyze code.

We can also use other columns in our transformations,
which makes `DataFramesMeta.jl` more appealing than `DataFrames.jl` due to the easier syntax.

First, let's revisit the leftjoined `DataFrame` from Chapter -@sec:dataframes:

```jl
sco("""
# leftjoined revisited # hide
leftjoined = leftjoin(grades_2020(), grades_2021(); on=:name)
"""; process=without_caption_label
)
```

Additionally, we'll replace the missing values with `5` (@sec:missing, also note the `!` in in-place variant `@rtransform!`):

```jl
sco("""
@rtransform! leftjoined :grade_2021 = coalesce(:grade_2021, 5)
"""; process=without_caption_label
)
```

This is how you calculate the mean of grades in both years using `DataFramesMeta.jl`:

```jl
sco("""
@rtransform leftjoined :mean_grades = (:grade_2020 + :grade_2021) / 2
"""; process=without_caption_label
)
```

This is how you would perform it in `DataFrames.jl`:

```jl
sco("""
transform(leftjoined, [:grade_2020, :grade_2021] => ByRow((x, y) -> (x + y) / 2) => :mean_grades)
"""; process=without_caption_label
)
```

As you can see, the case for easier syntax is not hard to argue for `DataFramesMeta.jl`.
