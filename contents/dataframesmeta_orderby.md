## Row Sorting {#sec:dataframesmeta_orderby}

**DFM has a macro for sorting rows: `@orderby`**.
`@orderby` do not have an in-place or vectorized variant.

Let's sort our `leftjoined` by grade in 2021:

```jl
sco("""
@orderby leftjoined :grade_2021
"""; process=without_caption_label
)
```

By default, `@orderby` will sort in ascending order.
But you can change this to decreasing order with the minus sign `-` in front of the column:

```jl
sco("""
# orderby descending # hide
@orderby leftjoined -:grade_2021
"""; process=without_caption_label
)
```

Like all the other DFM macros,
`@orderby` also supports multiple operations inside a `begin ... end` statement:

```jl
sco("""
@orderby leftjoined begin
    :grade_2021
    :name
end
"""; process=without_caption_label
)
```

Here, we are sorting first by grade in 2020 then by name.
Both in ascending order.
