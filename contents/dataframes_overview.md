# Tabular data {#sec:dataframes_overview}

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
Examples of, so called _queries_, for this data could be:

- Which show did I give the highest rating?
- Which shows are made in America?
- Which shows where in the same country?

For large tables, computers would be able to answer these kinds of questions much quicker than you could do it by hand.
But, as a researcher, the real science often starts with having multiple tables.
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

These kinds of problems are what is solved by DataFrames.

## Select and Filter {#sec:select_filter}

## Missing Data {#sec:missing_data}

## Join {#sec:join}

## Groupby {#sec:groupby}
