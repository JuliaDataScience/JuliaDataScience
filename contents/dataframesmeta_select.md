## Column Selection {#sec:dataframesmeta_select}

Let's revisit our example `all_grades()` data defined in Chapter -@sec:dataframes.

```jl
sco("""
# dfm grades # hide
df = all_grades()
"""; process=without_caption_label
)
```

The DFM `@select` macro is similar to the `select` `DataFrames.jl` function.
It performs **column selection**:

```jl
sco("""
@select df :name
"""; process=without_caption_label
)
```

We can add as many colums as we want to `@select`:

```jl
sco("""
@select df :name :grade
"""; process=without_caption_label
)
```

To use the column selectors (@sec:select) you need to wrap them inside `$()`:

```jl
sco("""
@select df \$(Not(:grade))
"""; process=without_caption_label
)
```

The DFM syntax, for some users, is easier and more intuitive than the `DataFrames.jl`'s minilanguage `source => transformation => target`.
The minilanguage is replaced by `target = transformation(source)`.
Suppose you want to represent the grades as a number between 0 and 100:

```jl
sco("""
# select times 10 # hide
@select df :grade_100 = :grade .* 10
"""; process=without_caption_label
)
```

Of course the `.*` can be ommited by using the vectorized form of the macro, `@rselect`:

```jl
sco("""
# rselect times 10 # hide
@rselect df :grade_100 = :grade * 10
"""; process=without_caption_label
)
```
