# DataFramesMeta.jl {#sec:dataframesmeta}

In this chapter we'll cover [**`DataFramesMeta.jl`**](https://juliadata.github.io/DataFramesMeta.jl/stable/),
a package that uses **convenient data wrangling syntax translating to `DataFrames.jl` commands**.
The syntax is similar to the [`dplyr`](https://dplyr.tidyverse.org) package from R's tidyverse.
Compared to using pure `DataFrames.jl`, `DataFramesMeta.jl` commands are typically more convenient to write and more similar to `dplyr` which makes `DataFramesMeta.jl` particularly suitable for people familiar with the R programming language.

A major advantage of `DataFramesMeta.jl` is that,
contrary to `dplyr`,
there are fewer commands that you need to learn.
Specifically we'll cover **6 commands**:

- **`@select`**: column selection
- **`@transform`**: column transformation
- **`@subset`**: row selection
- **`@orderby`**: row sorting
- **`@combine`**: data summaries
- **`@chain`**: piping operations
