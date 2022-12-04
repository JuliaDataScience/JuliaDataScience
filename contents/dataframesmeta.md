# DataFramesMeta.jl {#sec:dataframesmeta}

In this chapter we'll cover [**`DataFramesMeta.jl`**](https://juliadata.github.io/DataFramesMeta.jl/stable/) (DFM),
a package that uses **convenient data wrangling syntax translating to `DataFrames.jl` commands**.
The syntax is similar to [`dplyr`](https://dplyr.tidyverse.org) package from the R's tidyverse.
Hence, DFM might be an alternative option from `DataFrames.jl` for data wrangling in Julia geared towards R users.

A major advantage of DFM is that,
contrary to `dplyr`,
there are few commands that you need to learn.
Specifically we'll cover **6 commands**:

- **`@select`**: column selection
- **`@transform`**: column transformation
- **`@subset`**: row selection
- **`@orderby`**: row sorting
- **`@combine`**: data summaries
- **`@chain`**: piping operations
