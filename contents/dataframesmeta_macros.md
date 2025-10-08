## Macros {#sec:dataframesmeta_macros}

You might have noticed that all `DataFramesMeta.jl` commands start with an "at" `@` symbol. These commands have a special category in the Julia language: they are called **macros**.

> ***NOTE:*** Macros are a way to perform [metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming) in Julia. We won't cover macro's basics here. However, if you want to find out more, please check the [Julia documentation section on metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming/) and [Julius Krumbiegel's blog post on Julia macros](https://jkrumbiegel.com/pages/2021-06-07-macros-for-beginners/).


`DataFramesMeta.jl` macros behave **similar** to `DataFrames.jl` functions:

  * they both take a `DataFrame` as a first positional argument
  * they have in-place *mutating* functions (as discussed in @sec:df*performance*inplace: the bang `!` functions)

Nevertheless, there are some **differences** between using `DataFrames.jl` functions versus `DataFramesMeta.jl` macros.

First, using parentheses in the macro commands are *optional*, and it can be replaced by *spaces* instead. For example:

```julia (editor=true, logging=false, output=true)
@select(df, :col)
```
is the same as:

```julia (editor=true, logging=false, output=true)
@select df :col
```
We will be using the space syntax in this chapter.

Second, macros parse *static* commands by default. If you want *dynamic* parsing you'll need to add `$` to your syntax. This happens because macros treat the input as a static string. For example:

```julia (editor=true, logging=false, output=true)
@select df :col
```
will always work because our intended selected column command with the argument `:col` won't change in *runtime* (the time that Julia is executing code). It will always mean the same operation no matter the context.

Now suppose that you want to use one of the column selectors presented in @sec:select. Here, the expression inside the `@select` macro needs to be parsed *dynamically*. In other words, it is *not* static and the operation will change with context. For example:

```julia (editor=true, logging=false, output=true)
@select df Not(:col)
```
Here the columns that we want to select will depend on the actual columns inside `df`. This means that Julia cannot treat the command as something that won't change depending on the context. Hence, it needs to be parsed dynamically. In `DataFramesMeta.jl`, this is solved by wrapping parts of the command that needs to be parsed dynamically with `$()`. The above command needs to be changed to:

```julia (editor=true, logging=false, output=true)
@select df $(Not(:col))
```
This tells `DataFramesMeta.jl` to treat the `Not(:col)` part of the macro as dynamic. It will parse this expression and replace it by all of the columns except `:col`.

Third, most of `DataFramesMeta.jl` macros have **two different versions**: a ***non-vectorized***, and a ***vectorized*** form. The non-vectorized form is the default form and treats arguments as whole columns, i.e., they operate on arrays whereas the vectorized form has an `r` prefix (as in **r**ows) and vectorizes all operators and functions calls. This is the same behavior as adding the dot operator `.` into the desired operation. Similar to the `ByRow` function from `DataFrames.jl` that we saw in @sec:subset.

These 3 operations are equivalent:

```julia (editor=true, logging=false, output=true)
# DataFrames.jl
transform(df, :col => ByRow(exp))
```
```julia (editor=true, logging=false, output=true)
# DataFramesMeta.jl non-vectorized (default)
@transform df exp.(:col)
```
```julia (editor=true, logging=false, output=true)
# DataFramesMeta.jl vectorized with r prefix
@rtransform df exp(:col)
```
> ***NOTE:*** For most of the `DataFramesMeta.jl` macros we have four variants:
>
>   * `@macro`: non-vectorized
>   * `@rmacro`: vectorized
>   * `@macro!`: non-vectorized in-place
>   * `@rmacro!`: vectorized in-place


