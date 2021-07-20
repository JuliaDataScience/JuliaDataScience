## Index and Summarize

Let's go back to the example `grades_2020()` data defined above:

```jl
sco("grades_2020()"; process=without_caption_label)
```

To retreive a **vector** for `name`, we can use:

```jl
@sco JDS.names_grades1()
```

or:

```jl
@sco JDS.names_grades2()
```

Note that `df.name` is exactly the same as `df[!, :name]`, which you can verify yourself by doing:

```
julia> df = DataFrame(id = [1]);

julia> @edit df.name
```

In both cases, it gives you the column `:name`.
There also exists `df[:, :name]` which modifies the column `:name` in place.
In most cases, `df[!, :name]` is the best bet since it is more versatile.

For any **row**, say the second row, we can use:

```jl
s = """
    df = grades_2020()
    df[2, :]
    df = DataFrame(df[2, :]) # hide
    """
sco(s; process=without_caption_label)
```

or create a function to give us any row `i` that we want:

```jl
@sco process=without_caption_label JDS.grade_2020(2)
```

We can also get only `names` for the first 2 rows:

```jl
@sco JDS.grades_indexing(grades_2020())
```

If we assume that all names in the table are unique, we can also write a function to obtain the grade for a person via their `name`.
To do so, we convert the table back to one of Julia's basic data structures which is capable of creating a mappings, namely dictionaries:

```jl
@sco post=output_block grade_2020("Bob")
```

which works because `zip` loops through `df.name` and `df.grade_2020` at the same time like a zipper:

```jl
sco("""
df = grades_2020()
collect(zip(df.name, df.grade_2020))
""")
```

However, converting a DataFrame to a Dictionary is only useful when the elements are unique.
When that is not the case, it is time to `filter` (@sec:filter).

## Filter and Subset {#sec:filter_subset}

There are two ways to remove rows from a DataFrame, one is `filter` (@sec:filter) and the other is `subset` (@sec:subset).
`filter` was added earlier to `DataFrames.jl`, is more powerful, and more consistent with syntax from Julia base, so that is why we start with discussing `filter`.
`subset` is newer and often more convenient.

### Filter {#sec:filter}

From this point on, we start to get to the more eowerful features of `DataFrames.jl`.
To do this, we need to learn some verbs, such as `select` and `filter`, but it might be a relieve to know that the general design goal of `DataFrames.jl` is to keep the number of verbs that a user has to learn to a minimum[^verbs].
Continuing from the earlier mentioned data:

[^verbs]: According to Bogumił Kamiński on [Discourse](https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/5).

```jl
sco("grades_2020()"; process=without_caption_label)
```

```{=comment}
Add ref to multiple dispatch in the intro
```

We can filter rows by using `filter(f::Function, df)`.
This function is very similar to the function `filter(f::Function, V::Vector)` from Julia itself.
Working with a function `f` for filtering can be a bit difficult to use in practice, but it is very powerful.
As a simple example, we can create a function which checks whether it's input equals "Alice":

```jl
@sco post=output_block JDS.equals_alice("Bob")
```

```jl
sco("equals_alice(\"Alice\")"; post=output_block)
```

With such a function, we can now filter out all the rows for which `name` equals "Alice"

```jl
s = "filter(:name => equals_alice, grades_2020())"
sco(s; process=without_caption_label)
```

Note that this doesn't only work for DataFrames, but also for vectors:

```jl
s = """filter(equals_alice, ["Alice", "Bob", "Dave"])"""
sco(s)
```

We can make it a bit less verbose by using an anonymous function:

```jl
s = """filter(n -> n == "Alice", ["Alice", "Bob", "Dave"])"""
sco(s)
```

which we can also use on `grades_2020`:

```jl
s = """filter(:name => n -> n == "Alice", grades_2020())"""
sco(s; process=without_caption_label)
```

This line can be read as "for each element in the column `:name`, let's call the element `n`, check whether `n` equals Alice".
For some people, this is still to verbose.
Luckily, Julia has added a _partial function application_ of `==`.
The details of these words are not important, only that you can use it via

```jl
sco("""
s = "This is here to workaround a bug in books" # hide
filter(:name => ==("Alice"), grades_2020())
"""; process=without_caption_label)
```

To get all the rows which are *not* Alice, `==` can be replaced by `!=` in all previous examples:

```jl
s = """filter(:name => !=("Alice"), grades_2020())"""
sco(s; process=without_caption_label)
```

Now, to show why anonymous functions are so powerful, we can come up with a more complex filter.
In this filter, we want to have the people whos name start with A or B **and** who have a grade above a 6:

```jl
s = """
    function complex_filter(name, grade)::Bool
        interesting_name = startswith(name, 'A') || startswith(name, 'B')
        interesting_grade = 6 < grade
        interesting_name && interesting_grade
    end
    """
sc(s)
```

```jl
s = "filter([:name, :grade_2020] => complex_filter, grades_2020())"
sco(s; process=without_caption_label)
```

### Subset {#sec:subset}

The `subset` function was added to make it easier to work with missing values (@sec:missing_data).
In contrast to `filter`, `subset` works on complete columns.
If we want to use our earlier defined functions, we can use `ByRow`:

```jl
s = "subset(grades_2020(), :name => ByRow(equals_alice))"
sco(s; process=without_caption_label)
```

Also note that the DataFrame is now the first argument, whereas it was the second argument in `filter`, that is, use `filter(f, df)` and use `subset(df, args...)`.
The reason for this is that Julia defines filter as `filter(f, V::Vector)` and the developers of `DataFrames.jl` chose to be consistent with that.

Just like with `filter`, we can also use anonymous functions inside `subset`:

```jl
s = "subset(grades_2020(), :name => ByRow(name -> name == \"Alice\"))"
sco(s; process=without_caption_label)
```

Or, the partial function application for `==`:

```jl
s = "subset(grades_2020(), :name => ByRow(==(\"Alice\")))"
sco(s; process=without_caption_label)
```

Ultimately, let's show the real power of `subset`.
First, we create a dataset with some missing values:

```jl
@sco salaries()
```

This data is about a plausible situation where you want to figure out how many your colleagues earn, and haven't figured it out for Zed yet.
Even though we don't want to encourage these practices, we suspect it is an interesting example.
Say that we want to know who earns more than 2000.
When using `filter` without taking the `missing` values into account, it will fail:

```jl
s = "filter(:salary => >(2_000), salaries())"
sce(s, post=trim_last_n_lines(25))
```

`subset` will also fail, but will point us toward an easy solution:

```jl
s = "subset(salaries(), :salary => ByRow(>(2_000)))"
sce(s, post=trim_last_n_lines(25))
```

So, we just need to pass the keyword argument `skipmissing=true`:

```jl
s = "subset(salaries(), :salary => ByRow(>(2_000)); skipmissing=true)"
sco(s; process=without_caption_label)
```

## Select {#sec:select}

Whereas `filter` removes rows, `select` removes columns.
However, `select` is much more versatile than just removing columns, as we will discuss in this section.
First, let's create a dataset with multiple columns:

```jl
@sco responses()
```

Here, the data represents answers on five questions (`q1`, `q2`, ..., `q5`) in a questionnaire.
We will start by "selecting" a few columns from this dataset.
Again, we use symbols to specify columns:

```jl
s = "select(responses(), :id, :q1)"
sco(s, process=without_caption_label)
```

We can also use strings if we want:

```jl
s = """select(responses(), "id", "q1", "q2")"""
sco(s, process=without_caption_label)
```

To select everything _except_ one or more columns, use `Not` with either a single column name:

```jl
s = """select(responses(), Not(:q5))"""
sco(s, process=without_caption_label)
```

Or, with multiple column names:

```jl
s = """select(responses(), Not([:q4, :q5]))"""
sco(s, process=without_caption_label)
```

It's also fine to combine column names with `Not`:

```jl
s = """select(responses(), :q5, Not(:id))"""
sco(s, process=without_caption_label)
```

Note how `q5` is now the first column.
But, there is a more clever way to do this, and that is with `:`.
The colon `:` can be thought of as "all the columns that we didn't include yet".
For example:

```jl
s = """select(responses(), :q5, :)"""
sco(s, process=without_caption_label)
```

Or, to put `q5` at the second position[^sudete]:

[^sudete]: Thanks to Sudete on [Discourse](https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/4) for this suggestion.

```jl
s = "select(responses(), 1, :q5, :)"
sco(s, process=without_caption_label)
```

Even renaming columns is possible via `select`:

```jl
s = """select(responses(), 1 => "participant", :q1 => "age", :q2 => "nationality")"""
sco(s, process=without_caption_label)
```

which, thanks to the `...` operator, we can also write as:

```jl
s = """
    renames = (1 => "participant", :q1 => "age", :q2 => "nationality")
    select(responses(), renames...)
    """
sco(s, process=without_caption_label)
```

> **Note:** Another example of splatting via the `...` operator is:
> ```jl
  s = """
      V = ["a", "b", "c"]
      joinpath(V...)
      """
  scob(s)
  ```

## Types and Missing Data {#sec:missing_data}

```{=comment}
Try to combine with transformations

categorical
allowmissing
disallowmissing
```

As discussed in @sec:load_save, `CSV.jl` will do its best to guess data types for your data.
However, this won't always work perfectly.
In this section, we show why suitable types are important and we fix wrong data types.
To be more clear about the types, we show the text output for DataFrames instead of a pretty table.
In this section, we work with the following dataset:

```jl
@sco process=string post=output_block wrong_types()
```

Because the date column has the wrong type, sorting won't work correctly:

```jl
s = "sort(wrong_types(), :date)"
scsob(s)
```

To fix the sorting, we can use `Date` as described in @sec:dates:

```jl
@sco process=string post=output_block fix_date_column(wrong_types())
```

Now, sorting will work correctly:

```jl
s = """
    df = fix_date_column(wrong_types())
    sort(df, :date)
    """
scsob(s)
```

For the age column, we have a similar problem:

```jl
s = "sort(wrong_types(), :age)"
scsob(s)
```

This isn't right, because an infant is younger than adults and adolescents.
The solution for this categorical data problem is to use `CategoricalArrays.jl`:

```
using CategoricalArrays
```

with the `CategoricalArrays.jl` package, we can add levels to our data:

```jl
@sco process=string post=output_block fix_age_column(wrong_types())
```

Now, we can sort the data correctly on the age column:

```jl
s = """
    df = fix_age_column(wrong_types())
    sort(df, :age)
    """
scsob(s)
```

Since we have worked with functions, we can now define our fixed data as:

```jl
@sco process=string post=output_block correct_types()
```

Note that the keyword argument `ordered` set to `true` signals `CategoricalArrays.jl` that the data is ordinal.
In other words, because the data is ordinal, we can compare elements:

```jl
s = """
    df = correct_types()
    a = df[1, :age]
    b = df[2, :age]
    a < b
    """
scob(s)
```

which would have been wrong for strings:

```jl
s = "\"infant\" < \"adult\""
scob(s)
```

## Join {#sec:join}

At the start of this chapter, we showed multiple tables and gave questions related to multiple tables.
However, we haven't talked about combining tables yet, which we will do in this section.
In `DataFrames.jl`, combining multiple tables is done via _joins_.
Joins are extremely powerful, but might take some time to wrap your head around.

```{=comment}
Here, add the grades stuff from my blog.
```

## Variable Transformations

```{=comment}
manipulate variables
DataFrames.transform
Ifelse and case_when
```


## Groupby {#sec:groupby}
