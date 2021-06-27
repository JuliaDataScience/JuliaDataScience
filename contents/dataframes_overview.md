# DataFrames.jl {#sec:dataframes_overview}

Most data is formatted as a table.
By a table, we mean that the data consists of rows and columns, and the columns are usually of the same data type, whereas rows have different types.
The rows, in practise, denote measurements and columns denote variables.
For example, we can have a table of tv shows, which country it was produced, and our own rating for the shows, see @tbl:tv_shows.

```{=comment}
Using a different example from the rest in the chapter to make the text a bit more interesting.
We could even ask the reader to answer the queries described below as exercises.
```

```jl
tv_shows = DataFrame(
    name=["Game of Thrones", "The Crown", "Friends", "..."],
    country=["America", "England", "America", "..."],
    rating=[8.2, 7.3, 7.8, "..."])
Options(tv_shows; label="tv_shows")
```

Here, the dots mean that this could be a very long table and we only show a few rows.
While doing research, questions on this data start to arise.
For large tables, computers would be able to answer these kinds of questions much quicker than you could do it by hand.
Examples of, so called _queries_, for this data could be:

- Which show did I give the highest rating?
- Which shows are made in America?
- Which shows where in the same country?

But, as a researcher, the real science often starts with having multiple tables or data sources.
For example, if we also have the table containing the ratings given by someone else (@tbl:ratings),

```jl
ratings = DataFrame(
    name=["Game of Thrones", "Friends", "..."],
    rating=[7, 6.4, "..."])
Options(ratings; label="ratings")
```

Now, questions we could ask ourselves could be

- What is the average rating that Game of Thrones received?
- Who gave the highest rating for Friends?
- What shows are rated by you but not by the other person?

In the rest of this chapter, we will show you how you can easily answer these questions in Julia.
To do so, we first show, in @sec:why_dataframes, why we need a Julia package called DataFrames.jl.
Next, we answer queries on single tables in @sec:select_filter.
After this, we unfortunately have to discuss how to handle missing data in @sec:missing_data.
Then, we are ready to answer queries on multiple tables in @sec:join.
Finally, we discuss how to aggregate rows for things like taking the mean in @sec:groupby.

## Why DataFrames.jl? {#sec:why_dataframes}

```{=comment}
Maybe, add a comparison with Excel to see where Julia is better.
In summary, because it is much easier to structure and reproduce the logic.
```

For example, we could have a table of grades like the one in @tbl:grades_for_2020.

```jl
JDS.grades_for_2020()
```

Here, the column name has type `string`, age has type `integer`, and grade has type `float`.

So far, this book has only handled Julia's basics.
These basics are great for many things, but not for tables.
To show that we need more, lets try to store the tabular data in arrays:

```jl
@sc(JDS.grades_array)
```

Now, the data is stored in, so called, column-major, which is cumbersome when we want to get data from a row:

```jl
@sco(JDS.second_row)
```

Or, if you want to have the grade for Alice, you first need to figure out in what row Alice is,

```jl
@sco(JDS.row_alice)
```

and, then, we can get the value

```jl
@sco(JDS.value_alice)
```

These kinds of problems are what is solved by DataFrames, which we can load with
```
using DataFrames
```
With DataFrames.jl, we can define

```jl
sco("""
name = ["Sally", "Bob", "Alice", "Hank"]
grade_2020 = [1, 5, 8.5, 4]
df = DataFrame(; name, grade_2020)
without_caption_label(df) # hide
""")

```

which gives us a variable `df` containing our table.

```{=comment}
Although this section is a duplicate of earlier chapters, I do think it might be a good idea to keep the duplicate.
According to MIT instructor Patrick Winston (https://youtu.be/Unzc731iCUY), convincing someone of something means repeating it a few times.
With this section, people who already understand it, understand it a bit better and people who didn't understand it yet might understand it here.
```

This works, but there is one thing that we need to change straight away.
In this example, we defined the variables `name`, `grade_2020` and `df` in global scope.
This means that these variables can be accessed and edited from anywhere.
If we would continue writing the book like this, we would have a few hundred variables at the end of the book even though the data that we put into the variable `name` should only be accessed via `DataFrames`!
The variables `name` and `grade_2020` where never meant to be kept for long!
Now, imagine that we would change the contents of `grade_2020` a few times in this book.
Given only the book as PDF, it could be a stand alone research project to figure out the contents of the variable by the end.

We can solve this very easily by using functions.
Lets do the same thing as before but now in a function.

```jl
@sco(JDS.grades_2020)
```

Note that `name` and `grade_2020` are destroyed after the function returns, that is, they are only available in the function.
There are two other benefits of doing this.
Firstly, it is now clear to the reader where `name` and `grade_2020` belong to, they below to the grades of 2020.
Secondly, it is easy to determine what the output of `grades_2020()` would be at any point in the book.
For example, we can now put the data in a variable

```jl
sco("""
df = JDS.grades_2020()
Options(df; caption=nothing, label=nothing) # hide
""")
```

change the content of the variable

```jl
sco("""
df = DataFrame(name = ["Malice"], grade_2020 = ["10"])
Options(df; caption=nothing, label=nothing) # hide
""")
```

and still get the original data back without any problem

```jl
sco("""
df = JDS.grades_2020()
without_caption_label(df) # hide
""")
```

This assumes that the function is not re-defined, of course.
We promise to not do that in this book, because it is a bad idea exactly for this reason.
Instead of "changing" a function, we will make a new one and give it a clear name.
Also, we won't always be using functions, but if we don't then you can rest assured that we won't reuse it much later in the book.

So, back to `DataFrames`.
As you might have seen, the way to create one is simply to pass vectors into `DataFrame`.
You can come up with any valid Julia vector and it will work as long as the vectors have the same length.
Duplicates, unicode symbols and not so round numbers are fine:

```jl
sco("""
without_caption_label( # hide
DataFrame(σ = ["a", "a", "a"], δ = [π, π/2, π/3])
) # hide
""")
```

## Indexing

Let's go back to the example data defined above

```jl
sco("""
df = JDS.grades_2020()
without_caption_label(df) # hide
""")
```

To get a the **vector** for `name` back, we can use

```jl
@sco(JDS.names_grades1)
```

or

```jl
@sco(JDS.names_grades2)
```

For the **row**, say the second row, we can use

```{=comment}
This should be able to take an argument.
```

```jl
@sco(JDS.grades_row(1))
```

Continuing on this, we can also get only `names` for the first 2 rows:

```jl
@sco(JDS.grades_indexing)
```

## Select and Filter {#sec:select_filter}


## Missing Data {#sec:missing_data}

## Join {#sec:join}

## Groupby {#sec:groupby}
