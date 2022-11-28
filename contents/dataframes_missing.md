## Missing Data {#sec:missing}

Let's dive into how to **handle missing values** in `DataFrames.jl`.
We'll cover **three** main approaches for dealing with missing data:

1. **filtering missing** values with `ismissing` and `dropmissing`
1. **filling or replacing missing** values with `coalesce`
1. **skipping over missing** values with `skipmissing`

First, we need a `DataFrame` filled  with missing values to showcase these approaches:

```jl
sco("""
df_missing = DataFrame(;
    name=[missing, "Sally", "Alice", "Hank"],
    age=[17, missing, 20, 19],
    grade_2020=[5.0, 1.0, missing, 4.0],
)
"""; process=without_caption_label)
```

This is the same `DataFrame` from @sec:dataframes but with some `missing` values added.

### `Missing` type {#sec:missing_type}

Some languages have several types to represent missing values.
One such example is R which uses `NA`, `NA_integer_`, `NA_real_`, `NA_character_`, and `NA_complex_`.
**Julia**, on the contrary, has **only one**: `Missing`.

```jl
sco("typeof(missing)"; process=without_caption_label)
```

As you can see `missing` is an instance of the type `Missing`.

> **_NOTE:_**
> In the [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/),
> there's a guidance to use camel case for types and modules
> (see @sec:notation).

The first thing we need to cover of the `missing` values is that they **propagate through several operations**.
For example, addition, subtraction, multiplication, and division:

```jl
# addition # hide
sco("missing + 1"; process=without_caption_label)
```

```jl
# subtraction # hide
sco("missing - 1"; process=without_caption_label)
```

```jl
# multiplication # hide
sco("missing * 1"; process=without_caption_label)
```

```jl
# division # hide
sco("missing / 1"; process=without_caption_label)
```

They also propagate **through equality and comparison operators**:

```jl
# equal 1 # hide
sco("missing == 1"; process=without_caption_label)
```

```jl
# equal missing # hide
sco("missing == missing"; process=without_caption_label)
```

```jl
# higher 1 # hide
sco("missing > 1"; process=without_caption_label)
```

```jl
# higher missing # hide
sco("missing > missing"; process=without_caption_label)
```

That's why we need to be very cautious when comparing and testing equalities in the presence of `missing` values.
**For equality testing use the `ismissing` function instead**.

### Filtering Missing Values {#sec:missing_filter}

Most of the time we want to **remove missing values from our data**.

Removing `missing`s can be done in two ways:

1. **`dropmissing` function** applied to a whole `DataFrame` or a subset of its columns.
1. **`ismissing` function** applied to a filtering procedure (see @sec:filter_subset).

The `dropmissing` function takes as first positional argument a `DataFrame`,
and as an optional second argument either a single column or vector of columns by which columns you'll want to remove the missing data from.

By default, if you do not specify column(s), as the second positional argument,
it will remove any observation (row) that have `missing` values:

```jl
# no columns # hide
sco("dropmissing(df_missing)"; process=without_caption_label)
```

Since 3 out of 4 rows had at least one `missing` value, we get back a `DataFrame` with a single row as a result.

However, if we specify column(s) as the second positional argument to `dropmissing`,
the resulting `DataFrame` will only drop rows that have `missing` values in the specified column(s).

Here's a single column with a `Symbol`:

```jl
# with column # hide
sco("dropmissing(df_missing, :name)"; process=without_caption_label)
```

And now multiple columns with a vector of `Symbol`s:

```jl
# with columns # hide
sco("dropmissing(df_missing, [:name, :age])"; process=without_caption_label)
```

> **_NOTE:_**
> You can use any of the _column selectors_ described in @sec:select for the second positional argument of `dropmissing`.

The `ismissing` function tests if the underlying value is of the `Missing` type returning either `true` or `false`.

You can use negation `!` to use it both ways:

- `ismissing` to just keep the `missing` values.
- `!ismissing` to keep anything but the `missing` values

```jl
# no bang # hide
sco("filter(:name => ismissing, df_missing)"; process=without_caption_label)
```

```jl
# with bang # hide
sco("filter(:name => !ismissing, df_missing)"; process=without_caption_label)
```

### Filling or Replacing Missing Values {#sec:missing_filling}

A common data wrangling pattern is to **replace or fill missing values**.

Like R (and SQL), Julia has the `coalesce` function.
We often use it in a broadcasted way over an array to fill all `missing` values with a specific value.

Here's an example of a vector containing two `missing` values:

```jl
sco("""
coalesce.([missing, \"some value\", missing], \"zero\")
"""; process=without_caption_label)
```

You can see that `coalesce` replaces `missing` values with `"zero"`.

We can definitely use it in a transform procedure (@sec:transform):

```jl
# missing coalesce # hide
sco("""transform(df_missing, :name => ByRow(x -> coalesce(x, \"John Doe\")); renamecols=false)"""; process=without_caption_label)
```

### Skipping over Missing Values {#sec:missing_skip}

As we saw on @sec:groupby_combine, we can use `combine` to apply summarizing functions to data.
However, as explained, **`missing` values propagate through most operations in Julia**.
Suppose you want to calculate the mean of `:grade_2020` column in our `df_missing`:

```jl
# combine with missing # hide
sco("""combine(df_missing, :grade_2020 => mean)"""; process=without_caption_label)
```

You can skip missing values in any array or summarizing function by passing the `skipmissing` function:

```jl
# combine with skipmissing # hide
sco("""combine(df_missing, :grade_2020 => mean ∘ skipmissing )"""; process=without_caption_label)
```

> **_NOTE:_**
> We are using the function composition operator `∘` (which you can type with `\circ<TAB>`) to compose two functions into one.
> It is just like the mathematical operator:
>
> \$\$f \\circ g (x) = f(g(x))\$\$
>
> Hence, `(mean ∘ skipmissing)(x)` becomes `mean(skipmissing(x))`.
