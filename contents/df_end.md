## Index and Summarize

Let's go back to the example `grades_2020()` data defined above

```jl
sco("""
without_caption_label( # hide
grades_2020()
) # hide
""")
```

To retreive a **vector** for `name`, we can use:

```{=comment}
These two functions cannot be replaced by inline code due to
`df.name` being converted to the same filename as `df[!, :name]` in Books.jl.
I need to fix it.
```

```jl
@sco JDS.names_grades1()
```

or

```jl
@sco JDS.names_grades2()
```

For any **row**, say the second row, we can use:

```jl
sco("""
df[2, :]
df = DataFrame(df[2, :]) # hide
without_caption_label(df) # hide
""")
```

or create a function to give us any row `i` that we want:

```jl
@sc JDS.grade_2020(1)
```

```jl
sco("""
without_caption_label( # hide
grade_2020(2)
) # hide
""")
```

We can also get only `names` for the first 2 rows:

```jl
@sco JDS.grades_indexing()
```

If we assume that all names in the table are unique, we can also write a function to obtain the grade for a person via their `name`.
To do so, we convert the table back to one of Julia's basic data structures which is capable of creating a mappings, namely dictionaries:

```jl
@sc grade_2020("")
```

```jl
sco("""
grade_2020("Bob")
""")
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

## Filter and Subset {#sec:filter}

Continuing from the earlier mentioned data.

```jl
sco("""
without_caption_label( # hide
grades_2020()
) # hide
""")
```

```{=comment}
Add ref to multiple dispatch in the intro
```

We can filter rows by using `filter(f::Function, df)`.
This function is very similar to the function `filter(f::Function, V::Vector)` from Julia itself.
Working with a function `f` for filtering can be a bit difficult to use in practice, but it is very powerful.
As a simple example, we can create a function which checks whether it's input equals "Alice":

```jl
@sc JDS.equals_alice("")
```

```jl
sco("""
equals_alice("Bob")
""")
```

```jl
sco("""
equals_alice("Alice")
""")
```

With such a function, we can now filter out all the rows for which `name` equals "Alice"

```jl
sco("""
without_caption_label( # hide
filter(:name => equals_alice, grades_2020())
) # hide
""")
```

Note that this doesn't only work for DataFrames, but also for vectors:

```jl
sco("""
filter(equals_alice, ["Alice", "Bob", "Dave"])
""")
```

We can make it a bit less verbose by using an anonymous function:

```jl
sco("""
filter(n -> n == "Alice", ["Alice", "Bob", "Dave"])
""")
```

or, for the table,

```jl
sco("""
without_caption_label( # hide
filter(:name => n -> n == "Alice", grades_2020())
) # hide
""")
```

This line can be read as "for each element in the column `:name`, let's call the element `n`, check whether `n` equals Alice".
For some people, this is still to verbose.
Luckily, Julia has added a _partial function application_ of `==`.
The details of these words are not important, only that you can use it via

```jl
sco("""
s = "Workaround a bug in books" # hide
without_caption_label( # hide
filter(:name => ==("Alice"), grades_2020())
) # hide
""")
```

To get all the rows which are **not** Alice, `==` can be replaced by `!=` in all previous examples:

```jl
sco("""
without_caption_label( # hide
filter(:name => !=("Alice"), grades_2020())
) # hide
""")
```

Now, to show why anonymous functions are so powerful, we can come up with a more complex filter.
In this filter, we want to have the people whos name start with A or B **and** who have a grade above a 6.

```jl
sc("""
function complex_filter(name, grade)::Bool
    interesting_name = startswith(name, 'A') || startswith(name, 'B')
    interesting_grade = 6 < grade
    interesting_name && interesting_grade
end
""")
```

```jl
sco("""
without_caption_label( # hide
filter([:name, :grade_2020] => complex_filter, grades_2020())
) # hide
""")
```

## Select {#sec:select}

## Types and Missing Data, Categorical {#sec:missing_data}

```{=comment}
Try to combine with transformations
```

## Variable Transformations

```{=comment}
manipulate variables
DataFrames.transform
Ifelse and case_when
```

## Join {#sec:join}

## Groupby {#sec:groupby}

## CategoricalArrays.jl
