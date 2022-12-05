## Macros {#sec:dataframesmeta_macros}

Before we dive into DFM commands,
you might noticed that all of those start with an "at" `@` symbol.
These commands have a special category in the Julia language:
they are called **macros**.

> **_NOTE:_**
> Macros are a way to perform [metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming) in Julia.
> We won't cover macro basics here.
> However, if you want to find more more,
> please check the [Julia documentation section on metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming/)
> and [Julius Krumbiegel's blog post on Julia macros](https://jkrumbiegel.com/pages/2021-06-07-macros-for-beginners/).

DFM macros behave **similar** as `DataFrames.jl` functions:

- they both take a `DataFrame` as a first positional argument
- they have in-place _mutating_ functions
  (as discussed in @sec:df_performance_inplace: the bang `!` functions)

Nevertheless, there are some **differences** on using `DataFrames.jl` functions versus DFM macros.

First, using parentheses in the macro commands are _optional_, and it can be replaced by _spaces_ instead.
For example:

```julia
@select(df, :col)
```

is the same as:

```julia
@select df :col
```

We will be using the space syntax in this chapter.

Second, macros parse _static_ commands by default.
If you want _dynamic_ parsing you'll need to add `$` to your syntax.
This happens because macros treat the input as a static string.
For example:

```julia
@select df :col
```

will always work because our intended select column command with the argument `:col` won't change in _runtime_
(the time that the Julia is executing code).
It will always mean the same operation no matter the context.

Now suppose that you want to use one of the column selectors presented in @sec:select.
Here, the expression inside the `@select` macro needs to be parsed _dynamically_.
In other words, it is _not_ static and the operation will change with context.
For example:

```julia
@select df Not(:col)
```

Here the columns that we want to select will depend on the actual columns inside `df`.
This means that Julia cannot treat the command as something that won't change depending on the context.
Hence, it needs to be parsed dynamically.
In DFM, we solve this by wrapping parts of the command that needs to be parsed dynamically with `$()`.
The above command needs to be changed to:

```julia
@select df $(Not(:col))
```

This tells DFM to treat the `Not(:col)` part of the macro as dynamic.
It will parse this expression and replace it by all of the columns except `:col`.

Third, most of DFM macros have **two different versions**:
a **_non-vectorized_**, and a **_vectorized_** form.
The non-vectorized form is the default form and treats arguments as whole columns, i.e., they operate on arrays whereas the vectorized form has an `r` prefix
(as in **r**ows) and vectorizes all operators and functions calls.
This is the same behavior as adding the dot operator `.` into the desired operation.
This is similar to the `ByRow` function from `DataFrames.jl` that we saw in @sec:subset.

These 3 operations are equivalent:

```julia
# DataFrames.jl
transform(df, :col => ByRow(exp))
```

```julia
# DFM non-vectorized (default)
@transform df exp.(:col)
```

```julia
# DFM vectorized with r prefix
@rtransform df exp(:col)
```

> **_NOTE:_**
> For most of the DFM macros we have four variants:
>
> - `@macro`: non-vectorized
> - `@rmacro`: vectorized
> - `@macro!`: non-vectorized in-place
> - `@rmacro!`: vectorized in-place
