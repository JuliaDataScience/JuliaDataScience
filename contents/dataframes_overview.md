# DataFrames.jl Overview {#sec:dataframes_overview}

Most data is formatted as a table.
By a table, we mean that the data consists of rows and columns, and the columns are usually of the same data type, whereas rows have different types.
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
JDS.value_alice()
```


