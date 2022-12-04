## Data Summaries {#sec:dataframesmeta_combine}

Similar to the `combine` `DataFrames.jl` function (@sec:groupby_combine),
DFM has a **`@combine` macro** that performs similarly.

```jl
sco("""
@combine leftjoined :mean_grade_2020 = mean(:grade_2020)
"""; process=without_caption_label
)
```

`@combine` also supports multiple operations inside a `begin ... end` statement:

```jl
sco("""
# @combine begin end # hide
@combine leftjoined begin
    :mean_grade_2020 = mean(:grade_2020)
    :mean_grade_2021 = mean(:grade_2021)
end
"""; process=without_caption_label
)
```

Most of the time we would use `@combine` in a grouped dataframe by pairing it with `groupby`:

```jl
sco("""
gdf = groupby(leftjoined, :name)
@combine gdf begin
    :mean_grade_2020 = mean(:grade_2020)
    :mean_grade_2021 = mean(:grade_2021)
end
"""; process=without_caption_label
)
```
