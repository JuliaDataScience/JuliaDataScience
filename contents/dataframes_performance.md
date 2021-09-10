## Performance {#sec:df_performance}

So far, we didn't think about making our `DataFrames.jl` code **fast**.
Like everything in Julia, `DataFrames.jl` can be really fast.
In this section, we will give some performance tips and tricks.

### In-place operations {#sec:df_performance_inplace}

Like we explained in @sec:function_bang, functions that end with a bang `!` are a common pattern to denote functions that modify one or more of their arguments.
In the context of high performance Julia code, this *means* that **functions with `!` will just change in-place the objects that we have supplied as arguments.

Almost all the `DataFrames.jl` functions that we've seen have a \"`!` twin\".
For example, `filter` has an _in-place_ `filter!`, `select` has `select!`, `subset` has `subset!`, and so on.
Notice that these functions **do not** return a new `DataFrame`, but instead they **update** the `DataFrame` that they act upon.
Additionally, there are some functions that do not have a `!` counterpart.
For example, all the `join`s, for technical reasons, *cannot* be done in-place.
Thus, we don't have any `join!` functions in `DataFrames.jl`.

If you want the highest speed and performance in your code, you should definitely use the `!` functions instead of regular `DataFrames.jl` functions.

Let's go back to the example of the `select` function in the beginning of @sec:select.
Here is the responses `DataFrame`:

```jl
sco("responses()"; process=without_caption_label)
```

Now, let's perform the selection with the `select` function, like we did before:

```jl
s = """
    # allocating function # hide
    select(responses(), :id, :q1)
    """
sco(s, process=without_caption_label)
```

And here is the _in-place_ function:

```jl
s = """
    # non allocarting function # hide
    select!(responses(), :id, :q1)
    """
sco(s; process=without_caption_label)
```

The `@allocated` macro tells us how much memory was allocated.
In other words, **how much new information the computer had to store in its memory while running the code**.
Let's see how they will perform: 

```jl
s = """
    # allocation # hide
    df = responses()
    @allocated select(df, :id, :q1)
    """
sco(s; process=string, post=plainblock)
```

```jl
s = """
    # non allocation # hide
    df = responses()
    @allocated select!(df, :id, :q1)
    """
sco(s; process=string, post=plainblock)
```

As we can see, `select!` allocates less than `select`.
So, it should be faster and while consuming less memory.

### Copying vs Not Copying Columns {#sec:df_performance_df_copy}

There are **two ways to access a DataFrame column**.
They differ in how they are accessed: one creates a "view" to the column without copying and the other creates a whole new column by copying the original column.

The first is the regular dot `.` operator followed by the column name, like in `df.col`.
This kind of access **does not copy** the column `col`.
Instead `df.col` creates a "view" which is a link to the original column without performing any allocation.
Additionally, the syntax `df.col` is the same as `df[!, :col]` with the bang `!` as the row selector.

The second way to access a `DataFrame` column is the `df[:, :col]` with the colon `:` as the row selector.
This kind of access **does copy** the column `col`, so beware that it may produce unwanted allocations.

As before, let's try out these two ways to access a column in the responses `DataFrame`:

```jl
s = """
    # allocation # hide
    df = responses()
    @allocated col = df[:, :id]
    """
sco(s; process=string, post=plainblock)
```


```jl
s = """
    # non allocation # hide
    df = responses()
    @allocated col = df[!, :id]
    """
sco(s; process=string, post=plainblock)
```

When we access a column without copying it we are making zero allocations and our code should be faster.
So, if you don't need a copy always access your `DataFrame`s columns with `df.col` or `df[!, :col]` instead of `df[:, :col]`.

### CSV.read versus CSV.File {#sec:df_performance_csv_read_file}

If you take a look at the help output for `CSV.read`, you will see that there is a convenience function identical to the function called `CSV.File` with the same keywords arguments.
Both `CSV.read` and `CSV.File` will read the contents of a CSV file, but they differ in the default behavior.
**`CSV.read`, by default, will not make copies** of the incoming data.
Instead, `CSV.read` will pass all the data to the second argument (known as the "sink").

So, something like this:

```julia
df = CSV.read("file.csv", DataFrame)
```

will pass all the incoming data from `file.csv` to the `DataFrame` sink, thus returning a `DataFrame` type that we store in the `df` variable.

For the case of **`CSV.File`, the default behavior is the opposite: it will make copies of every column contained in the CSV file**.
Also, the syntax is slightly different.
We need to wrap anything that `CSV.File` returns in a `DataFrame` constructor function:

```julia
df = DataFrame(CSV.File("file.csv"))
```

Or, in a more preferred idiomatic syntax with the pipe `|>` operator:


```julia
df = CSV.File("file.csv") |> DataFrame
```

Like we said, `CSV.File` will make copies of each column in the underlying CSV file.
Ultimately, if you want the most performance, you would definitely use `CSV.read` instead of `CSV.File`.
That's why we only covered `CSV.read` in @sec:csv.

### CSV.jl Multiple Files {#sec:df_performance_csv_multiple}

Now let's turn our attention to the `CSV.jl`.
Specially when we have multiple CSV files to read into a single `DataFrame`.
Since version 0.9 of `CSV.jl` we can provide a vector of strings representing filenames.
Before, we needed to perform some sort of multiple file reading and then concatenate vertically the results into a single `DataFrame`.
To exemplify, the code below reads from multiple CSV files and then concatenates them vertically using `vcat` into a single `DataFrame` with the `reduce` function:

```julia
files = filter(endswith(".csv"), readdir())
df = reduce(vcat, CSV.read(file, DataFrame) for file in files)
```

One additional trait is that `reduce` will not paralelize because it needs to keep the order of `vcat` which follows the same ordering of the `files` vector.

With this functionality in `CSV.jl` we simply pass the `files` vector into the `CSV.read` function:

```julia
files = filter(endswith(".csv"), readdir())
df = CSV.read(files, DataFrame)
```

`CSV.jl` will design a file for each thread available in the computer while it lazily concatenates each thread parsed output into a `DataFrame`.
So we have the **additional benefit of multithreading** that we don't have with the `reduce` option.

### CategoricalArrays.jl compression {#sec:df_performance_categorical_compression}

If you are handling data with a lot of categorical values, i.e. a lot of columns with textual data that represent somehow different qualitative data, you would probably benefit by using `CategoricalArrays.jl` compression.

By default, **`CategoricalArrays.jl` will use an unsigned integer of size 32 bits `UInt32` to represent the underlying categories**:

```jl
s = """
    typeof(categorical(["A", "B", "C"]))
    """
sco(s; process=string, post=plainblock)
```

This means that `CategoricalArrays.jl` can represent up to $2^{32}$ different categories in a given vector or column, which is a huge value (close to 4.3 billion).
You probably would never need to have this sort of capacity in dealing with regular data[^bigdata].
That's why `categorical` has a `compress` argument that accepts either `true` or `false` to whether compress or not the underlying categorical data.
If you pass **`compress=true`, `CategoricalArrays.jl` will try to compress the underlying categorical to the smallest possible representation in `UInt`**.
For example, the previous `categorical` vector would be represented as an unsigned integer of size 8 bits `UInt8` (mostly because this is the smallest unsigned integer available in Julia):

[^bigdata]: also notice that regular data (about <10 000 rows) is not big data (about >100 000 rows). So, if you are dealing primarily with big data please take caution in capping your categorical values.

```jl
s = """
    typeof(categorical(["A", "B", "C"]; compress=true))
    """
sco(s; process=string, post=plainblock)
```

What does this all mean?
Suppose you have a big vector.
For example, a vector with one million entries, but only 4 underlying categories: A, B, C or D.
If you do not compress the resulting categorical vector, you will have one million entries stored as `UInt32`.
On the other hand, if you do compress it, you will have one million entries stored instead as `UInt8`.
By using `Base.summarysize` function we can get the underlying size, in bytes, of a given object.
So let's quantify how much more memory we would need to have if we did not compressed our one million categorical vector:

```julia
using Random 
```

```jl
s = """
    one_mi_vec = rand(["A", "B", "C", "D"], 1_000_000)
    Base.summarysize(categorical(one_mi_vec))
    """
sco(s; process=string, post=plainblock)
```

4 million bytes, which is approximate 3.8 MB.
Don't get us wrong, this is a good improvement over the raw string size:

```jl
s = """
    Base.summarysize(one_mi_vec)
    """
sco(s; process=string, post=plainblock)
```

We reduced 50% of the raw data size by using the default `CategoricalArrays.jl` underlying representation as `UInt32`.

Now let's see how we would fare with compression:

```jl
s = """
    Base.summarysize(categorical(one_mi_vec; compress=true))
    """
sco(s; process=string, post=plainblock)
```

We reduced the size to 25% (one quarter) of the original uncompressed vector size without losing information.
Our compressed categorical vector has now 1 million bytes which is aproximate 1.0MB.

So whenever possible, in the interest of performance, consider using `compress=true` in your categorical data.

