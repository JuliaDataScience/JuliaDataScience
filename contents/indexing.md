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

