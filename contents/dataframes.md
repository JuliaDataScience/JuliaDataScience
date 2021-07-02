# DataFrames.jl {#sec:dataframes}

Data comes mostly in a tabular format.
By tabular, we mean that the data consists of a table containing rows and columns.
Columns are usually of the same data type, whereas rows have different types.
The rows, in practice, denote observations and columns denote variables.
For example, we can have a table of TV shows containing in which country it was produced and our personal rating, see @tbl:TV_shows.

```{=comment}
Using a different example from the rest in the chapter to make the text a bit more interesting.
We could even ask the reader to answer the queries described below as exercises.
```

```jl
tv_shows = DataFrame(
    name=["Game of Thrones", "The Crown", "Friends", "..."],
    country=["United States", "England", "United States", "..."],
    rating=[8.2, 7.3, 7.8, "..."])
Options(tv_shows; label="TV_shows")
```

Here, the dots mean that this could be a very long table and we only show a few rows.
While analyzing data, we always have interesting questions about the data, also known as _data queries_.
For large tables, computers would be able to answer these kinds of questions much quicker than you could do it by hand.
Examples of, so called _queries_, for this data could be:

- Which TV show has the highest rating?
- Which TV shows were produced in the United States?
- Which TV shows were produced in the same country?

But, as a researcher, real science often starts with having multiple tables or data sources.
For example, if we also have data from someone else's ratings for the TV shows (@tbl:ratings),

```jl
ratings = DataFrame(
    name=["Game of Thrones", "Friends", "..."],
    rating=[7, 6.4, "..."])
Options(ratings; label="ratings")
```

Now, questions that we could ask ourselves could be:

- What is Game of Thrones' average rating?
- Who gave the highest rating for Friends?
- What TV shows were rated by you but not by the other person?

In the rest of this chapter, we will show you how you can easily answer these questions in Julia.
To do so, we first show, in @sec:why_dataframes, why we need a Julia package called DataFrames.jl.
Next, we answer queries on single tables in @sec:filter.
After this, we have to discuss how to handle missing data in @sec:missing_data, which unfortunately happens a lot.
Then, we are ready to answer queries on multiple tables in @sec:join.
Finally, we discuss how to aggregate groups (rows) for things like taking the mean in @sec:groupby.

**Why DataFrames.jl?**

```{=comment}
TODO: Add a comparison with Excel to see where Julia is better.
In summary, because it is much easier to structure and reproduce the logic.
(Jose approves)
```

Let's look at a table of grades like the one in @tbl:grades_for_2020.

```jl
JDS.grades_for_2020()
```

Here, the column name has type `string`, age has type `integer`, and grade has type `float`.

So far, this book has only handled Julia's basics.
These basics are great for many things, but not for tables.
To show that we need more, lets try to store the tabular data in arrays:

```jl
@sc JDS.grades_array()
```

Now, the data is stored in, so called, column-major, which is cumbersome when we want to get data from a row:

```jl
@sco JDS.second_row()
```

Or, if you want to have the grade for Alice, you first need to figure out in what row Alice is,

```jl
@sco JDS.row_alice()
```

and, then, we can get the value

```jl
@sco JDS.value_alice()
```

DataFrames.jl can easily solve these kinds of issues.
You can start by loading DataFrames.jl:

```
using DataFrames
```

With DataFrames.jl, we can define

```jl
sco("""
names = ["Sally", "Bob", "Alice", "Hank"]
grades = [1, 5, 8.5, 4]
df = DataFrame(; name=names, grade_2020=grades)
without_caption_label(df) # hide
""")
```

which gives us a variable `df` containing our data in table format.

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
Given only the book as PDF, it would be near impossible to figure out the contents of the variable by the end.

We can solve this very easily by using functions.
Lets do the same thing as before but now in a function.

```jl
@sco JDS.grades_2020()
```

Note that `name` and `grade_2020` are destroyed after the function returns, that is, they are only available in the function.
There are two other benefits of doing this.
Firstly, it is now clear to the reader where `name` and `grade_2020` belong to, they below to the grades of 2020.
Secondly, it is easy to determine what the output of `grades_2020()` would be at any point in the book.
For example, we can now put the data in a variable

```jl
sco("""
df = grades_2020()
without_caption_label(df) # hide
""")
```

change the content of the variable

```jl
sco("""
df = DataFrame(name = ["Malice"], grade_2020 = ["10"])
without_caption_label(df) # hide
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
Also, sometimes we will still be defining variables, but if we do, then you can rest assured that we won't reuse it much later in the book.

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

Typically, in your code, you would create a function which wraps around one or more DataFrames functions.
For example, we can make a function to get the grades for various `names`:

```jl
@sc JDS.grades_2020([1])
```

```jl
sco("""
without_caption_label( # hide
grades_2020([3, 4])
) # hide
"""; M=JDS)
```

This way of using functions to wrap around basic functionality from programming languages and packages is quite common.
Basically, you can think of Julia and DataFrames as providers of building blocks.
They provide very **generic** building blocks which allow you to build things for your **specific** use-case like this grades example.
By using the blocks, you can make a data analysis script, control a robot or whatever you like to build.

So far, the examples were quite cumbersome since we had to use indexes.
In the next sections, we will show more powerful building blocks provided by DataFrames.jl.

## Load and Save Files

```{=comment}
CSV + Excel
```

## Indexing and Summarizing

```{=comment}
summaries
```

Let's go back to the example data defined above

```jl
sco("""
without_caption_label( # hide
grades_2020()
) # hide
""")
```

To get a the **vector** for `name` back, we can use

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

For the **row**, say the second row, we can use

```jl
sco("""
df[2, :]
df = DataFrame(df[2, :]) # hide
without_caption_label(df) # hide
""")
```

or create a function to give us row `i`

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

Continuing on this, we can also get only `names` for the first 2 rows:

```jl
@sco JDS.grades_indexing()
```

If we assume that all names in the table are unique, we can also write a function to obtain the grade for a person via their `name`.
To do this, we convert the table back to one of Julia's basic data structures which is capable of creating a mappings, namely dictionaries:

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

Continuing from the earlier mentioned table.

```jl
sco("""
without_caption_label( # hide
grades_2020()
) # hide
""")
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

With this function, we can now filter out all the rows for which `name` equals "Alice"

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

This line can be read as "for each element in the column `:name`, let's call this thing `n`, check whether `n` equals Alice".
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

Now, to show why these functions are so powerful, we can come up with a more complex filter.
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
