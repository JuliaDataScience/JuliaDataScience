## Data Summaries {#sec:dataframesmeta_combine}

Similar to the `combine` `DataFrames.jl` function (@sec:groupby_combine), `DataFramesMeta.jl` has a **`@combine` macro**.

```julia (editor=true, logging=false, output=true)
@combine leftjoined :mean_grade_2020 = mean(:grade_2020)
```
`@combine` also supports multiple operations inside a `begin ... end` statement:

```julia (editor=true, logging=false, output=true)
# @combine begin end # hide
@combine leftjoined begin
    :mean_grade_2020 = mean(:grade_2020)
    :mean_grade_2021 = mean(:grade_2021)
end
```
Most of the time we would use `@combine` in a grouped dataframe by pairing it with `groupby`:

```julia (editor=true, logging=false, output=true)
gdf = groupby(leftjoined, :name)
@combine gdf begin
    :mean_grade_2020 = mean(:grade_2020)
    :mean_grade_2021 = mean(:grade_2021)
end
```
