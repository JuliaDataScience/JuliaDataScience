## Join {#sec:join}

At the start of this chapter, we showed multiple tables and raised questions also related to multiple tables. However, we haven't talked about combining tables yet, which we will do in this section. In `DataFrames.jl`, combining multiple tables is done via *joins*. Joins are extremely powerful, but it might take a while to wrap your head around them. It is not necessary to know the joins below by heart, because the [`DataFrames.jl` documentation](https://DataFrames.juliadata.org/stable/man/joins/), along with this book, will list them for you. But, it's essential to know that joins exist. If you ever find yourself looping over rows in a `DataFrame` and comparing it with other data, then you probably need one of the joins below.

In @sec:dataframes, we've introduced the grades for 2020 with `grades_2020`:

```julia (editor=true, logging=false, output=true)
grades_2020()
```
Now, we're going to combine `grades_2020` with grades from 2021:

```julia (editor=true, logging=false, output=true)
grades_2021()
```
To do this, we are going to use joins. `DataFrames.jl` lists no less than seven kinds of join. This might seem daunting at first, but hang on because they are all useful and we will showcase them all.

### innerjoin {#sec:innerjoin}

This first is **`innerjoin`**. Suppose that we have two datasets `A` and `B` with respectively columns `A_1, A_2, ..., A_n` and `B_1, B_2, ..., B_m` **and** one of the columns has the same name, say `A_1` and `B_1` are both called `:id`. Then, the inner join on `:id` will go through all the elements in `A_1` and compare it to the elements in `B_1`. If the elements are **the same**, then it will add all the information from `A_2, ..., A_n` and `B_2, ..., B_m` after the `:id` column.

Okay, so no worries if you didn't get this description. The result on the grades datasets looks like this:

```julia (editor=true, logging=false, output=true)
innerjoin(grades_2020(), grades_2021(); on=:name)
```
Note that only "Sally" and "Hank" are in both datasets. The name *inner* join makes sense since, in mathematics, the *set intersection* is defined by "all elements in $A$, that are also in $B$, or all elements in $B$ that are also in $A$".

### outerjoin {#sec:outerjoin}

Maybe you're now thinking "aha, if we have an *inner*, then we probably also have an *outer*". Yes, you've guessed right!

The **`outerjoin`** is much less strict than the `innerjoin` and just takes any row it can find which contains a name in **at least one of the datasets**:

```julia (editor=true, logging=false, output=true)
outerjoin(grades_2020(), grades_2021(); on=:name)
```
So, this method can create `missing` data even though none of the original datasets had missing values.

### crossjoin {#sec:crossjoin}

We can get even more `missing` data if we use the **`crossjoin`**. This gives the **Cartesian product of the rows**, which is basically multiplication of rows, that is, for every row create a combination with any other row:

```julia (editor=true, logging=false, output=true)
crossjoin(grades_2020(), grades_2021(); on=:id)
```
Oops. Since `crossjoin` doesn't take the elements in the row into account, we don't need to specify the `on` argument for what we want to join:

```julia (editor=true, logging=false, output=true)
crossjoin(grades_2020(), grades_2021())
```
Oops again. This is a very common error with `DataFrame`s and `join`s. The tables for the 2020 and 2021 grades have a duplicate column name, namely `:name`. Like before, the error that `DataFrames.jl` outputs shows a simple suggestion that might fix the issue. We can just pass `makeunique=true` to solve this:

```julia (editor=true, logging=false, output=true)
crossjoin(grades_2020(), grades_2021(); makeunique=true)
```
So, now, we have one row for each grade from everyone in grades 2020 and grades 2021 datasets. For direct queries, such as "who has the highest grade?", the Cartesian product is usually not so useful, but for "statistical" queries, it can be.

### leftjoin and rightjoin {#sec:leftjoin_rightjoin}

**More useful for scientific data projects are the `leftjoin` and `rightjoin`**. The left join gives all the elements in the *left* `DataFrame`:

```julia (editor=true, logging=false, output=true)
leftjoin(grades_2020(), grades_2021(); on=:name)
```
Here, grades for "Bob" and "Alice" were `missing` in the grades 2021 table, so that's why there are also `missing` elements. The right join does sort of the opposite:

```julia (editor=true, logging=false, output=true)
rightjoin(grades_2020(), grades_2021(); on=:name)
```
Now, grades in 2020 are missing.

Note that **`leftjoin(A, B) != rightjoin(B, A)`**, because the order of the columns will differ. For example, compare the output below to the previous output:

```julia (editor=true, logging=false, output=true)
leftjoin(grades_2021(), grades_2020(); on=:name)
```
### semijoin and antijoin {#sec:semijoin_antijoin}

Lastly, we have the **`semijoin`** and **`antijoin`**.

The semi join is even more restrictive than the inner join. It returns **only the elements from the left `DataFrame` which are in both `DataFrame`s**. This is like a combination of the left join with the inner join.

```julia (editor=true, logging=false, output=true)
semijoin(grades_2020(), grades_2021(); on=:name)
```
The opposite of the semi join is the anti join. It returns **only the elements from the left `DataFrame` which are *not* in the right `DataFrame`**:

```julia (editor=true, logging=false, output=true)
antijoin(grades_2020(), grades_2021(); on=:name)
```
