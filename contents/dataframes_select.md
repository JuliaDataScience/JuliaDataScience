## Select {#sec:select}

Whereas **`filter` removes rows**, **`select` removes columns**. However, `select` is much more versatile than just removing columns, as we will discuss in this section. First, let's create a dataset with multiple columns:

```julia (editor=true, logging=false, output=true)
responses()
```
Here, the data represents answers for five questions (`q1`, `q2`, ..., `q5`) in a given questionnaire. We will start by "selecting" a few columns from this dataset. As usual, we use **symbols** to specify columns:

```julia (editor=true, logging=false, output=true)
select(responses(), :id, :q1)
```
We can also use **strings** if we want:

```julia (editor=true, logging=false, output=true)
select(responses(), "id", "q1", "q2")
```
Additionally, we can use **Regular Expressions** with [Julia's regex string literal](https://docs.julialang.org/en/v1/manual/strings/#man-regex-literals). A string literal in Julia is a prefix that you use while constructing a `String`. For example, the regex string literal can be created with `r"..."` where `...` is the Regular Expression. For example, suppose you only want to select the columns that start with `q`:

```julia (editor=true, logging=false, output=true)
select(responses(), r"^q")
```
> ***NOTE:***


We won't cover regular expressions in this book, but you are encouraged to learn about them. To build and test regular expressions interactively, we advice to use online tools for them such as [https://regex101.com/](https://regex101.com/).

To select **everything *except* one or more columns**, use **`Not`** with either a single column:

```julia (editor=true, logging=false, output=true)
select(responses(), Not(:q5))
```
Or, with multiple columns:

```julia (editor=true, logging=false, output=true)
select(responses(), Not([:q4, :q5]))
```
It's also fine to mix and match columns that we want to preserve with columns that we do `Not` want to select:

```julia (editor=true, logging=false, output=true)
select(responses(), :q5, Not(:q5))
```
Note how `q5` is now the first column in the `DataFrame` returned by `select`. There is a more clever way to achieve the same using `:`. The colon `:` can be thought of as "all the columns that we didn't include yet". For example:

```julia (editor=true, logging=false, output=true)
select(responses(), :q5, :)
```
Or, to put `q5` at the second position[^sudete]:

[^sudete]: thanks to Sudete on Discourse ([https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/4](https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/4)) for this suggestion.

```julia (editor=true, logging=false, output=true)
select(responses(), 1, :q5, :)
```
> ***NOTE:*** As you might have observed there are several ways to select a column. These are known as [*column selectors*](https://bkamins.github.io/julialang/2021/02/06/colsel.html).
>
> We can use:
>
>   * **`Symbol`**: `select(df, :col)`
>   * **`String`**: `select(df, "col`
>   * **`Integer`**: `select(df, 1)`
>   * **`RegEx`**: `select(df, r"RegEx`


Even renaming columns is possible via `select` using the **`source => target`** pair syntax:

```julia (editor=true, logging=false, output=true)
select(responses(), 1 => "participant", :q1 => "age", :q2 => "nationality")
```
Additionally, thanks to the "splat" operator `...` (see @sec:splat), we can also write:

```julia (editor=true, logging=false, output=true)
renames = (1 => "participant", :q1 => "age", :q2 => "nationality")
select(responses(), renames...)
```
## Types and Categorical Data {#sec:types}

As discussed in @sec:load_save, `CSV.jl` will do its best to guess what kind of types your data have as columns. However, this won't always work perfectly. In this section, we show why suitable types are important and we fix wrong data types. To be more clear about the types, we show the text output for `DataFrame`s instead of a pretty-formatted table. In this section, we work with the following dataset:

```julia (editor=true, logging=false, output=true)
process=string post=output_block wrong_types()
```
Because the date column has the wrong type, sorting won't work correctly:

```{=comment}
Whoa! You haven't introduced the reader to sorting with `sort` yet.
```

```julia (editor=true, logging=false, output=true)
sort(wrong_types(), :date)
```
To fix the sorting, we can use the `Date` module from Julia's standard library as described in @sec:dates:

```julia (editor=true, logging=false, output=true)
process=string post=output_block fix_date_column(wrong_types())
```
Now, sorting will work as intended:

```julia (editor=true, logging=false, output=true)
df = fix_date_column(wrong_types())
sort(df, :date)
```
For the age column, we have a similar problem:

```julia (editor=true, logging=false, output=true)
sort(wrong_types(), :age)
```
This isn't right, because an infant is younger than adults and adolescents. The solution for this issue and any sort of categorical data is to use `CategoricalArrays.jl`:

### CategoricalArrays.jl {#sec:categoricalarrays}

```
using CategoricalArrays
```

With the `CategoricalArrays.jl` package, we can add levels that represent the ordering of our categorical variable to our data:

```julia (editor=true, logging=false, output=true)
process=string post=output_block fix_age_column(wrong_types())
```
> ***NOTE:*** Also note that we are passing the argument `ordered=true` which tells `CategoricalArrays.jl`'s `categorical` function that our categorical data is "ordered". Without this any type of sorting or bigger/smaller comparisons would not be possible.


Now, we can sort the data correctly on the age column:

```julia (editor=true, logging=false, output=true)
df = fix_age_column(wrong_types())
sort(df, :age)
```
Because we have defined convenient functions, we can now define our fixed data by just performing the function calls:

```julia (editor=true, logging=false, output=true)
process=string post=output_block correct_types()
```
Since age in our data is ordinal (`ordered=true`), we can properly compare categories of age:

```julia (editor=true, logging=false, output=true)
df = correct_types()
a = df[1, :age]
b = df[2, :age]
a < b

```
which would give wrong comparisons if the element type were strings:

```julia (editor=true, logging=false, output=true)
"infant" < "adult"
```
