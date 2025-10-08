## Index and Summarize

Let's go back to the example `grades_2020()` data defined before:

```julia (editor=true, logging=false, output=true)
grades_2020()
```
To retrieve a **vector** for `name`, we can access the `DataFrame` with the `.`, as we did previously with `struct`s in @sec:julia_basics:

```julia (editor=true, logging=false, output=true)
JDS.names_grades1()
```
or we can index a `DataFrame` much like an `Array` with symbols and special characters. The **second index is the column indexing**:

```julia (editor=true, logging=false, output=true)
JDS.names_grades2()
```
Note that `df.name` is exactly the same as `df[!, :name]`, which you can verify yourself by doing:

```
julia> df = DataFrame(id=[1]);

julia> @edit df.name
```

In both cases, it gives you the column `:name`. There also exists `df[:, :name]` which copies the column `:name`. In most cases, `df[!, :name]` is the best bet since it is more versatile and does an in-place modification.

For any **row**, say the second row, we can use the **first index as row indexing**:

```julia (editor=true, logging=false, output=true)
df = grades_2020()
df[2, :]
df = DataFrame(df[2, :]) # hide
```
or create a function to give us any row `i` we want:

```julia (editor=true, logging=false, output=true)
JDS.grade_2020(2)
```
We can also get only `names` for the first 2 rows using **slicing** (again similar to an `Array`):

```julia (editor=true, logging=false, output=true)
JDS.grades_indexing(grades_2020())
```
If we assume that all names in the table are unique, we can also write a function to obtain the grade for a person via their `name`. To do so, we convert the table back to one of Julia's basic data structures (see @sec:data_structures) which is capable of creating mappings, namely `Dict`s:

```julia (editor=true, logging=false, output=true)
grade_2020("Bob")
```
which works because `zip` loops through `df.name` and `df.grade_2020` at the same time like a "zipper":

```julia (editor=true, logging=false, output=true)
df = grades_2020()
collect(zip(df.name, df.grade_2020))

```
However, converting a `DataFrame` to a `Dict` is only useful when the elements are unique. Generally that is not the case and that's why we need to learn how to `filter` a `DataFrame`.

## Filter and Subset {#sec:filter_subset}

There are two ways to remove rows from a `DataFrame`, one is `filter` (@sec:filter) and the other is `subset` (@sec:subset). `filter` was added earlier to `DataFrames.jl`, is more powerful and more consistent with syntax from Julia base, so that is why we start discussing `filter` first. `subset` is newer and often more convenient.

### Filter {#sec:filter}

From this point on, we start to get into the more powerful features of `DataFrames.jl`. To do this, we need to learn some functions, such as `select` and `filter`. But don't worry! It might be a relief to know that the **general design goal of `DataFrames.jl` is to keep the number of functions that a user has to learn to a minimum[^verbs]**.

[^verbs]: According to Bogumił Kamiński (lead developer and maintainer of `DataFrames.jl`) on Discourse ([https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/5](https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/5)).

Like before, we resume from the `grades_2020`:

```julia (editor=true, logging=false, output=true)
process=without_caption_label grades_2020()
```
We can filter rows by using `filter(source => f::Function, df)`. Note how this function is very similar to the function `filter(f::Function, V::Vector)` from Julia `Base` module. This is because `DataFrames.jl` uses **multiple dispatch** (see @sec:multiple_dispatch) to define a new method of `filter` that accepts a `DataFrame` as argument.

At first sight, defining and working with a function `f` for filtering can be a bit difficult to use in practice. Hold tight, that effort is well-paid, since **it is a very powerful way of filtering data**. As a simple example, we can create a function `equals_alice` that checks whether its input equals "Alice":

```julia (editor=true, logging=false, output=true)
post=output_block JDS.equals_alice("Bob
```
```julia (editor=true, logging=false, output=true)
equals_alice(\"Alice\"; post=output_block)
```
Equipped with such a function, we can use it as our function `f` to filter out all the rows for which `name` equals "Alice":

```julia (editor=true, logging=false, output=true)
filter(:name => equals_alice, grades_2020())
```
Note that this doesn't only work for `DataFrame`s, but also for vectors:

```julia (editor=true, logging=false, output=true)
filter(equals_alice, ["Alice", "Bob", "Dave"])
```
We can make it a bit less verbose by using an **anonymous function** (see @sec:function_anonymous):

```julia (editor=true, logging=false, output=true)
filter(n -> n == "Alice", ["Alice", "Bob", "Dave"])
```
which we can also use on `grades_2020`:

```julia (editor=true, logging=false, output=true)
filter(:name => n -> n == "Alice", grades_2020())
```
To recap, this function call can be read as "for each element in the column `:name`, let's call the element `n`, check whether `n` equals Alice". For some people, this is still too verbose. Luckily, Julia has added a *partial function application* of `==`. The details are not important – just know that you can use it just like any other function:

```julia (editor=true, logging=false, output=true)
filter(:name => ==("Alice"), grades_2020())
```
To get all the rows which are *not* Alice, `==` (equality) can be replaced by `!=` (inequality) in all previous examples:

```julia (editor=true, logging=false, output=true)
filter(:name => !=("Alice"), grades_2020())
```
Now, to show **why functions are so powerful**, we can come up with a slightly more complex filter. In this filter, we want to have the people whose names start with A or B **and** have a grade above 6:

```julia (editor=true, logging=false, output=true)
function complex_filter(name, grade)::Bool
    interesting_name = startswith(name, 'A') || startswith(name, 'B')
    interesting_grade = 6 < grade
    interesting_name && interesting_grade
end

```
```julia (editor=true, logging=false, output=true)
filter([:name, :grade_2020] => complex_filter, grades_2020())
```
### Subset {#sec:subset}

The `subset` function was added to make it easier to work with missing values (@sec:missing). In contrast to `filter`, `subset` works on complete columns instead of rows or single values. If we want to use our earlier defined functions, we should wrap it inside `ByRow`:

```julia (editor=true, logging=false, output=true)
subset(grades_2020(), :name => ByRow(equals_alice))
```
Also note that the `DataFrame` is now the first argument `subset(df, args...)`, whereas in `filter` it was the second one `filter(f, df)`. The reason for this is that Julia defines filter as `filter(f, V::Vector)` and `DataFrames.jl` chose to maintain consistency with existing Julia functions that were extended to `DataFrame`s types by multiple dispatch.

> ***NOTE:*** Most of native `DataFrames.jl` functions, which `subset` belongs to, have a **consistent function signature that always takes a `DataFrame` as first argument**.


Just like with `filter`, we can also use anonymous functions inside `subset`:

```julia (editor=true, logging=false, output=true)
subset(grades_2020(), :name => ByRow(name -> name == "Alice"))
```
Or, the partial function application for `==`:

```julia (editor=true, logging=false, output=true)
subset(grades_2020(), :name => ByRow(==("Alice")))
```
Ultimately, let's show the real power of `subset`. First, we create a dataset with some missing values:

```julia (editor=true, logging=false, output=true)
salaries()
```
This data is about a plausible situation where you want to figure out your colleagues' salaries, and haven't figured it out for Zed yet. Even though we don't want to encourage these practices, we suspect it is an interesting example. Suppose we want to know who earns more than 2000. If we use `filter`, without taking the `missing` values into account, it will fail:

```julia (editor=true, logging=false, output=true)
filter(:salary => >(2_000), salaries())
```
`subset` will also fail, but it will fortunately point us towards an easy solution:

```julia (editor=true, logging=false, output=true)
subset(salaries(), :salary => ByRow(>(2_000)))
```
So, we just need to pass the keyword argument `skipmissing=true`:

```julia (editor=true, logging=false, output=true)
subset(salaries(), :salary => ByRow(>(2_000)); skipmissing=true)
```
```{=comment}
Rik, we need a example of both filter and subset with multiple conditions, as in:

`filter(row -> row.col1 >= something1 && row.col2 <= something2, df)`

and:

`subset(df, :col1 => ByRow(>=(something1)), :col2 => ByRow(<=(something2)>))
```

