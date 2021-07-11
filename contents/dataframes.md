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
To do so, we first show why we need a Julia package called `DataFrames.jl`.

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

Or, if you want to have the grade for Alice, you first need to figure out in what row Alice is:

```jl
sco("""
function row_alice()
    names = grades_array().name
    i = findfirst(names .== "Alice")
end
row_alice()
"""; post=output_block)
```

and, then, we can get the value:

```{=comment}
Rik: The output isn't going through output_block.
TODO: I need to update `@sco` to allow this.
```

```jl
sco("""
function value_alice()
    grades = grades_array().grade_2020
    i = row_alice()
    grades[i]
end
value_alice()
"""; post=output_block)
```

`DataFrames.jl` can easily solve these kinds of issues.
You can start by loading `DataFrames.jl`:

```
using DataFrames
```

With `DataFrames.jl`, we can define

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
If we would continue writing the book like this, we would have a few hundred variables at the end of the book even though the data that we put into the variable `name` should only be accessed via `DataFrame`!
The variables `name` and `grade_2020` where never meant to be kept for long!
Now, imagine that we would change the contents of `grade_2020` a few times in this book.
Given only the book as PDF, it would be near impossible to figure out the contents of the variable by the end.

We can solve this very easily by using functions.
Lets do the same thing as before but now in a function.

```jl
@sco grades_2020()
```

Note that `name` and `grade_2020` are destroyed after the function returns, that is, they are only available in the function.
There are two other benefits of doing this.
Firstly, it is now clear to the reader where `name` and `grade_2020` belong to, they below to the grades of 2020.
Secondly, it is easy to determine what the output of `grades_2020()` would be at any point in the book.
For example, we can now put the data in a variable:

```jl
sco("""
df = grades_2020()
"""; process=without_caption_label)
```

change the content of the variable

```jl
sco("""
df = DataFrame(name = ["Malice"], grade_2020 = ["10"])
"""; process=without_caption_label)
```

and still get the original data back without any problem:

```jl
sco("""
df = grades_2020()
"""; process=without_caption_label)
```

This assumes that the function is not re-defined, of course.
We promise to not do that in this book, because it is a bad idea exactly for this reason.
Instead of "changing" a function, we will make a new one and give it a clear name.

So, back to the `DataFrames` constructor.
As you might have seen, the way to create one is simply to pass vectors as arguments into the `DataFrame` constructor.
You can come up with any valid Julia vector and it will work as long as the vectors have the same length.
Duplicates, unicode symbols and not so round numbers are fine:

```jl
sco("""
DataFrame(σ = ["a", "a", "a"], δ = [π, π/2, π/3])
"""; process=without_caption_label)
```

Typically, in your code, you would create a function which wraps around one or more DataFrames functions.
For example, we can make a function to get the grades for various `names`:

```jl
@sco process=without_caption_label JDS.grades_2020([3, 4])
```

This way of using functions to wrap around basic functionality from programming languages and packages is quite common.
Basically, you can think of Julia and DataFrames as providers of building blocks.
They provide very **generic** building blocks which allow you to build things for your **specific** use-case like this grades example.
By using the blocks, you can make a data analysis script, control a robot or whatever you like to build.

So far, the examples were quite cumbersome, because we had to use indexes.
In the next sections, we will show how to load and save data, and many powerful building blocks provided by DataFrames.jl.
