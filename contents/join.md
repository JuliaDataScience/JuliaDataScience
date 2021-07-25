## Join {#sec:join}

At the start of this chapter, we showed multiple tables and gave questions related to multiple tables.
However, we haven't talked about combining tables yet, which we will do in this section.
In `DataFrames.jl`, combining multiple tables is done via _joins_.
Joins are extremely powerful, but might take some time to wrap your head around.

In @sec:dataframes, we've introduced the grades for 2020:

```jl
s = "grades_2020()"
sco(s; process=without_caption_label)
```

Now, we're going to combine that with the information from 2021:

```jl
s = "grades_2021()"
sco(s; process=without_caption_label)
```

To do this, we are going to use a `join`.
The [`DataFrames.jl` documentation](https://dataframes.juliadata.org/stable/man/joins/) lists no less than seven kinds of joins.
We can just as well show them all here, because they are all useful depending on how your data will look.
This first mentioned one is `innerjoin`.
Suppose we have two datasets `A` and `B` with respectively columns `A_1, A_2, ..., A_n` and `B_1, B_2, ..., B_m` **and** one of the columns has the same name, say `A_1` and `B_1` are both called `:id`.
Then, the inner join on `:id` will go through all the elements in `A_1` and compare it to the elements in `B_1`.
If the elements are **the same**, then add all the information from `A_2, ..., A_n` and `B_2, ..., B_m` behind it.

Okay, so no worries if you didn't get this description.
The result on the grades datasets looks like this:

```jl
s = "innerjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Note that only "Sally" and "Hank" are in both datasets.
The name _inner_ join makes sense if you know that, in mathematics, the _set intersection_ is defined by "all elements in $A$, that are also in $B$, or all elements in $B$ that are also in $A$".

Maybe, you're now thinking "aha, if we have an _inner_, then we probably also have an _outer_".
That thinking would then be correct.
The `outerjoin` is much less strict than the `innerjoin` and just takes any row it can find which contains a name:

```jl
s = "outerjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Personally, this join makes me (Rik) a little bit sad, because our neat data without missing values suddenly has missing values.
But, that doesn't mean that there aren't good use-cases for this join or that you shouldn't use it.
We can get even more missing data if we use the `crossjoin`.
This gives the cartesian product of the rows, which is basically multiplication of rows, that is, for every row create a combination with any other row:

```jl
s = "crossjoin(grades_2020(), grades_2021(); on=:id)"
sce(s; post=trim_last_n_lines(2))
```

Oops.
Since the crossjoin doesn't take the elements in the row into account, we don't need to specify `on` what we want to join:

```jl
s = "crossjoin(grades_2020(), grades_2021())"
sce(s; post=trim_last_n_lines(6))
```

Oops again.
This is a very common error with DataFrames and joins.
The tables for the 2020 and 2021 grades have a duplicate column name, namely `:name`.
We can just pass `makeunique=true` to solve this:

```jl
s = "crossjoin(grades_2020(), grades_2021(); makeunique=true)"
sco(s; process=without_caption_label)
```

So, now, we have one row for each grade from everyone in grades 2020 and grades 2021 datasets.
For direct queries, such as "who has the highest grade?", the cartesian product is usually not so useful, but for (statistal) queries, it can be.

## Variable Transformations

```{=comment}
manipulate variables
DataFrames.transform
Ifelse and case_when
```

## Groupby {#sec:groupby}
