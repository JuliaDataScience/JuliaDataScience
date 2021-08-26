# Performance {#sec:df_performance}

So far, we didn't think about making our `DataFrames.jl` code **fast**.
Like everything in Julia, `DataFrames.jl` can be really fast.
In this section, we will give some performance tips and tricks.

```{=comment}
- Functions with a shebang versus without (e.g., filter! versus filter)
- df[!, col] versus df[:, col]
- other things? Jose probably knows some more
```
