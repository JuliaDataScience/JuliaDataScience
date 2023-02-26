## Row Selection {#sec:dataframesmeta_subset}

We already covered two macros that operate on _columns_, `@select` and `@transform`.

Now let's cover the only macro we need to **operate on _rows_: `@subset`**
It follows the same principles we've seen so far with `DataFramesMeta.jl`,
_except_ that the **operation must return a boolean variable** for row selection.

Let's filter grades above 7:

```jl
sco("""
@rsubset df :grade > 7
"""; process=without_caption_label
)
```

As you can see, `@subset` has also a vectorized variant `@rsubset`.
Sometimes we want to mix and match vectorized and non-vectorized function calls.
For instance, suppose that we want to filter out the grades above the mean grade:

```jl
sco("""
@subset df :grade .> mean(:grade)
"""; process=without_caption_label
)
```

For this, we need a `@subset` macro with the `>` operator vectorized,
since we want a element-wise comparison,
but the `mean` function needs to operate on the whole column of values.

`@subset` also supports multiple operations inside a `begin ... end` statement:

```jl
sco("""
@rsubset df begin
    :grade > 7
    startswith(:name, "A")
end
"""; process=without_caption_label
)
```
