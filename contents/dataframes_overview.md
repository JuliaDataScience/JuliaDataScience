# DataFrames.jl Overview {#sec:dataframes_overview}

Most data is formatted as a table.
For example, we could have a table of grades like the one in @tbl:grades_for_2020.

```jl
grades_for_2020()
```

So far, this book has only handled Julia's basics.
These basics are great for many things, but not for tables.
To show that we need more, lets try to store the data in some arrays:

```jl
@sc(grades_array)
```

Now, the data is stored in, so called, column-major, which is cumbersome when we want to get data from a row:

```jl
@sco(second_row)
```

Or, if you want to have the grade for Alice, you first need to figure out in what row Alice is,

```jl
@sco(row_alice)
```

and, then, we can get the value

```jl
value_alice()
```

# src/df.jl
```pretend this is in jl file
# STUPID IDEA NOT WORKING, cannot define struct at top level.
function P()
    struct Point
        a::Int
        b::Int
    end
end

function call_P()
    Point = P() # hide
    Point(1, 2)
end
```


```jl
# @sf(P)
struct Point
    a::Int
    b::Int
end
```

```jl

```
