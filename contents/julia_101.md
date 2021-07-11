# Julia 101 {#sec:julia_101}

> **_NOTE:_**
> In this chapter we will cover the basic of Julia as a programming language.
> Please note that this is not *strictly necessary* for you to use Julia as a tool of data manipulation and data visualization.
> Having a basic understanding of Julia will definitely make you more *effective* and *efficient* in using Julia.
> However, if you prefer to get started straight away, you can jump to [@sec:dataframes] to learn about tabular data with DataFrames.jl.

This is going to be a very brief and *not* in-depth overview of Julia language.
If you are already familiar and confortable with other programming languages, we highly encourage you to read [Julia's documentation](https://docs.julialang.org/).
It is a thoroughly deep dive into Julia.
It covers all the basics and corner cases, but it can be cumbersome.
Especially, if you are aren't familiar with open-source software documentation.

We'll cover the basics of Julia.
Imagine that Julia is a fancy feature-loaded car, such as a brand-new Tesla.
We'll just explain to you how to "drive the car, park it and how to navigate in traffic".
If you want to know what all "buttons in the steering wheel and dashboard do", this is not the resource you are looking for.

## Language Syntax {#sec:syntax}

Julia is a **dynamic-typed language**.
This means that you don't need to compile it before you run code, like you would do in C++ or FORTRAN.
The main differences from Julia to other dynamic languages such as R and Python are the following.

First, Julia, contrary to most dynamic-typed languages, **enables the user to specify type declaration**.
You already saw some types declarations in the [*Why Julia?*](why_julia.html) section: they are those double colon `::` that sometimes comes after variables
But if you don't want to specify what type are your variables or functions, Julia will gladly infer it for you.

Second, Julia also allows users to define function behavior across many combinations of argument types via multiple dispatch.
We also covered multiple dispatch in [*Why Julia?*](julia_accomplish.html) section.
We defined a different type behavior by defining new function signatures for different type's argument while using the same function name.

### Variables {#sec:variable}

Variables are values that you tell the computer to store with an specific name, so that you can later recover or change its value.
Julia have several type of variables but what we most use in data science are:

* Integers: `Int64`
* Real Numbers: `Float64`
* Boolean: `Bool`
* Strings: `String`

Integers and real numbers have by default 64 bits, thats why they have the `64` suffix in their type.
If you need more or less precision, there are `Int8` or `Int128` for example.
Most of the time this won't be an issue and can be overwhelming having to deal with different types.

We create new variables by writing the variable name on the left and its value in the right, and in the middle we use the `=` assign operator.
For example:

```jl
scob(
"""
name = "Julia"
age = 9
"""
)
```

Note that the return output of the last statement (`age`) was printed to the console.
Here, we are defining two new variables: `name` and `age`.
We can recover their values by typing its name given in the assignment:

```jl
scob(
"""
name
"""
)
```

If you want to define new values for an existing variable, you can repeat the steps in the assignment.
Note that Julia will now override the previous variable's value with the new one.
Supposed `jl name`'s birthday has passed and now it has turned `jl age+1`:

```jl
scob(
"""
age = 10
"""
)
```

We can do the same with its `name`, suppose that Julia has earned some titles due to its blazing speed.
We would change the variable `name` to the new value:

```jl
scob(
"""
name = "Julia Rapidus"
"""
)
```

We can also do operations on variables such as addition or division.
Let's see how much months of age `jl name` has by multiplying `age` by 12:

```jl
scob(
"""
age * 12
"""
)
```

We can inspect variables types by using `typeof` function:

```{=comment}
Rik: I have no idea why `scob` doesn't work here.
It is overloaded somewhere in the wrong way it seems.
```

```jl
sco("typeof(age)")
```

The next question then becomes: "What else can I do with integers?"
There is a nice handy function `methodswith` that spits out every function available, along with its signature, for a certain type.
Here I will restrict the output to the first 5 rows:

```{=comment}
Since the type is a Vector, Books converts it to multiple output statements.
In this case, I've enforced to show the output of `Base.show`.
```

```jl
sco(
"""
first(methodswith(Int64), 5)
"""; process=Books.catch_show
)
```

### User-defined Types {#sec:struct}

Having variables around without any sort of hierarchy and relationships are not ideal.
In Julia we can define that kind of structured data with a `struct` (also known as composite types).
Inside each `struct` there is an optional set of fields.
They differ from the primitive types (e.g. integer and floats) that are by default defined already inside the core of Julia language.
Since most `struct`s are user-defined they are known as user-defined types.

For example lets create a `struct` to represent scientific open-source programming languages.
We'll also define a set of fields along with the corresponding types inside the `struct`:

```jl
sco("""
struct Language
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end
"""; post=x -> "")
```

To inspect the field names you can use the `fieldnames` and passing the desired `struct` as an argument:

```jl
sco("fieldnames(Language)")
```

To use `struct`s, we must instantiate individual instances (or "objects"), each with its own specific values for the fields defined inside the `struct`.
Let's instantiate two instances, one for Julia and one for Python with the appropriate types as fields inside the `Language` constructor:

```jl
sco(
"""
julia = Language("Julia", "Rapidus", 2012, true)
python = Language("Python", "Letargicus", 1991, false)
"""
)
```

One thing to note with `struct`s is that we cannot change their values once they are instantiated.
We can solve this with a `mutable struct`.
Also, note that mutable objects will, generally, be slower and more error prone.
Whenever possible make everything *immutable*.
Let's create a `mutable struct`.

```jl
sco(
"""
mutable struct MutableLanguage
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end

julia_mutable = MutableLanguage("Julia", "Rapidus", 2012, true)
""")
```

Suppose that we want to change `julia_mutable`'s title.
Now we can do this, since `julia_mutable` is an instantiated `mutable struct`:

```jl
sco(
"""
julia_mutable.title = "Python Obliteratus"

julia_mutable
"""
)
```

### Boolean Operators an Numeric Comparison

Now that we've covered types, we can move to boolean operators and numeric comparison.

We have three boolean operators in Julia:

* `!`: **NOT**
* `&&`: **AND**
* `||`: **OR**

Here are a few examples with some of them:

```jl
scob(
"""
!true
"""
)
```

```jl
scob(
"""
(false && true) || (!false)
"""
)
```

```jl
scob(
"""
(6 isa Int64) && (6 isa Real)
"""
)
```

Regarding numeric comparison, Julia has three major types of comparisons:

1. **Equality**: either something is *equal* or *not equal* another
    * == "equal"
    * != or ≠ "not equal"
1. **Less than**: either something is *less than* or *less than or equal to*
    * <  "less than"
    * <= or ≤ "less than or equal to"
1. **Greater than**: either something is *greater than* or *greater than or equal to*
    * \> "greater than"
    * \>= or ≥ "greater than or equal to"

Here are some examples:

```jl
scob(
"""
1 == 1
"""
)
```

```jl
scob(
"""
1 >= 10
"""
)
```

It evens works between different types:

```jl
scob(
"""
1 == 1.0
"""
)
```

We can also mix and match boolean operators with numeric comparisons:

```jl
scob(
"""
(1 != 10) || (3.14 <= 2.71)
"""
)
```

### Functions {#sec:function}

Now that we already know how to define variables and custom types as `struct`s, let's turn our attention to **functions**.
In Julia, a function is an **object that maps argument's values to a return value**.
The basic syntax goes something like this:

```julia
function f_name(arg1, arg2)
    stuff_done = stuff with the arg1 and arg2
    return stuff_done
end
```

Every function declaration begins with the keyword `function` followed by the function name.
Then, inside parentheses `()`, we define the arguments separated by a comma `,`.
Inside the function, we specify what we want Julia to do with the parameters that we supplied.
After all the operations that we want the function to do has been performed, we ask Julia to return the result of those operations with the `return` statement.
Finally, we let Julia know that our function is well-defined and finished with the `end` keyword.

There is also the compact **assignment form**:

```julia
f_name(arg1, arg2) = stuff with the arg1 and arg2
```

It is the **same function** as before but with a different, more compact, form.
Let's dive into some examples.

#### Creating new Functions {#sec:function_example}

Let's create a new function that adds number together:

```jl
sco(
"""
function add_numbers(x, y)
    return x + y
end
"""
)
```

Now, we can use our `add_numbers` function:

```jl
scob(
"""
add_numbers(17, 29)
"""
)
```

And it works also with floats:

```jl
scob(
"""
add_numbers(3.14, 2.72)
"""
)
```

We can also define custom behavior by specifying types declarations.
Suppose we want to have a `round_number` function that behaves differently if its argument is either a `Float64` or `Int64`:

```jl
sco(
"""
function round_number(x::Float64)
    return round(x)
end

function round_number(x::Int64)
    return x
end
"""
)
```

We can see that it is a function with multiple methods:

```jl
sco(
"""
methods(round_number)
"""
)
```

There is one issue: what happens if we want to round a 32-bit float `Float32`?
Or a 8-bit integer `Int8`?

If you want something to function on all float's and integer's types you can use an abstract type as type signature, such as `AbstractFloat` or `Integer`:

```jl
sco(
"""
function round_number(x::AbstractFloat)
    return round(x)
end
"""
)
```

Now, it works as expected with any float type:

```jl
scob(
"""
x_32 = Float32(1.1)
round_number(x_32)
"""
)
```

> **_NOTE:_**
> We can inspect types with the `supertypes` and `subtypes` functions.

Let's go back to our `Language` `struct` that we defined above.
This is an example of multiple dispatch.
We will extend the `Base.show` function that prints the output of instantiated types and `struct`s.

By default a `struct` has a basic output, which you saw above in the `python` case.
We can define `Base.show` function to our `Language` type, so that we have some nice printing for our programming languages instances.
We want to clearly communicate programming languages' names, titles and ages in years of old.
The function `Base.show` accepts as arguments a `IO` type named `io` followed by the type you want to define custom behavior:

```jl
sco(
"""
Base.show(io::IO, l::Language) = print(
    io, l.name, " ",
    2021 - l.year_of_birth, ", years old, ",
    "has the following titles: ", l.title
)
"""; post=x -> ""
)
```

Now let's see how `python` will output:

```jl
sco(
"""
python
"""
)
```

#### Multiple Return Values {#sec:function_multiple}

A function can, also, return two or more values.
See the new function `add_multiply` below:

```jl
sco(
"""
function add_multiply(x, y)
    addition = x + y
    multiplication = x * y
    return addition, multiplication
end
"""
)
```

In that case we can do two things:

1. We can, analogously as the return values, define two variables to hold the function return values, one for each return value:
   ```jl
   scob(
   """
   return_1, return_2 = add_multiply(1, 2)
   return_2
   """
   )
   ```

2. Or we can define just one variable to hold the function return values and access them with either `first` or `last`:
   ```jl
   scob(
   """
   all_returns = add_multiply(1, 2)
   last(all_returns)
   """
   )
   ```

#### Keyword Arguments {#sec:function_keyword_arguments}

Some functions can accept keywords arguments instead of positional arguments.
These arguments are just like regular arguments, except that they are defined after the regular function's arguments and separated by a semicolon `;`.
Another difference is that we must supply a **default value** for every keyword argument.
For example, let's define a `logarithm` function that by default uses base $e$ (2.718281828459045) as a keyword argument.
Note that here we are using the abstract type `Real` so that we cover all types derived from `Integer` and `AbstractFloat`, being both themselves subtypes of `Real`:

```jl
scob(
"""
AbstractFloat <: Real && Integer <: Real
"""
)
```

```jl
sco(
"""
function logarithm(x::Real; base::Real=2.7182818284590)
    return log(base, x)
end
"""
)
```

It works without specifying the `base` argument:

```jl
scob(
"""
logarithm(10)
"""
)
```

And also with the keyword argument `base` different from its default value:

```jl
scob(
"""
logarithm(10; base=2)
"""
)
```

#### Anonymous Functions {#sec:function_anonymous}

A lot of times, we don't care about the name of the function and want to quickly make one.
What we need are **anonymous functions**.
They come a lot in Julia's data science workflow.
For example, when using [`DataFrames.jl`](dataframes.html) or [`Plots.jl`](plots.html), sometimes we need a quick and dirty function to filter data or format plot labels.
That's when we reach out for anonymous functions.
They are specially useful when we don't want to create a function and a simple in-place statement would be enough.

The syntax is simple.
We use the `->` operator.
On the left of `->` we define the parameter name.
And on the right of `->` we define what operations we want to perform on the parameter we defined on the left of `->`.
Here's an example, suppose we want to undo the log transformation by using an exponentiation:

```jl
scob(
"""
map(x -> 2.7182818284590^x, logarithm(2))
"""
)
```

Here, we are using the `map` function to conveniently map the anonymous function (first argument) to `logarithm(2)` (the second argument).
As a result, we get back the same number, because logarithm and exponentiation are inverse (at least in the base that we've chosen -- 2.7182818284590)

### Conditional If-Else-Elseif {#sec:conditionals}

In most programming languages, the user is allowed to control the computer's flow of execution.
Depending on the situation, we want the computer to do one thing or another.
In Julia we can control the flow of execution with `if`, `elseif` and `else` keywords.
There are known as conditional syntax.

`if` keyword prompts Julia to evaluate an expression and depending whether `true` or `false` certain portions of code will be executed.
We can compound several `if` conditions with the `elseif`  keyword, for complex an nuanced control flow.
Finally we can define an alterative portion to be executed if anything inside the `if` or `elseif`s are evaluated as `true`.
This is the purpose of the `else` keyword.
Finally, like all the previous keyword operators that we saw, we must tell Julia when the conditional statement is finished with the `end` keyword.

Here's an example with all the `if`-`elseif`-`else` keywords:

```jl
scob(
"""
a = 1
b = 2

if a < b
    "a is less than b"
elseif a > b
    "a is greater than b"
else
    "a is equal to b"
end
"""
)
```

We can even wrap this in a function called `compare`:

```jl
scob(
"""
function compare(a, b)
    if a < b
        "a is less than b"
    elseif a > b
        "a is greater than b"
    else
        "a is equal to b"
    end
end

compare(3.14, 3.14)
"""
)
```


### For Loop {#sec:for}

The classical for loop in Julia follow a similar syntax as the conditional statements.
You begin with a keyword, in this case `for`.
Then you specify what Julia should "loop" for, i.e. a sequence.
Also, like everything else, you must finish with the `end` keyword.

So, to make Julia print every number from 1 to 10, you'll need the following for loop:

```jl
sco(
"""
for i in 1:10
    println(i)
end
"""; post=x -> ""
)
```

### While Loop {#sec:while}

The while loop is a mix of the previous conditional statements and for loops.
Here the loop is executed everytime the condition is `true`.
The syntax follows the same fashion as the previous one.
We begin with the keyword `while`, followed by the statement to evaluated as either `true`.
Like previously, you must end with the `end` keyword.

Here's an example:

```jl
scob(
"""
n = 0

while n < 3
    global n += 1
end

n
"""
)
```

As you can see we have to use the `global` keyword.
This is because of **variable scope**.
Variables defined inside conditional statements, loops and functions exist only inside it.
This is known as the *scope* of the variable.
Here we had to tell Julia that the `n` inside `while` loop is in the global scope with the `global` keyword.

Finally, we used also the `+=` operator which is a nice short hand for `n = n + 1`.


## Native Data Structures {#sec:data_structures}

Julia have several native data structures.
They are abstractions of data that represent somehow structured data.
We will cover the most used ones.
They hold homogeneous or heterogeneous data.
Since they are collections, they can be *looped* over with the `for` loops.

We will cover `String`, `Tuple`, `NamedTuple`, `UnitRange`, `Arrays`, `Pair`, `Dict`, `Symbol`.

When you stumble into a data structure in Julia, you can find functions/methods that accept it as an argument with the `methodswith` function.
Just like we did before with types.
This is a nice thing to have in your bag of tricks.
We personally use it often.
Let's see what we can do with an `String` for example:

```jl
sco(
"""
first(methodswith(String), 5)
"""; process=Books.catch_show
)
```


### Broadcasting Operators and Functions

Before we dive into data structures, we need to talk about broadcasting (also known as *vectorization*) and the "dot" operator `.`.

For mathematical operation, like `*` (multiplication) or `+` (addition), we can broadcast it using the dot operator.
For example, broadcasted addition would imply in changing the `+` to `.+`:

```jl
sco(
"""
[1, 2, 3] .+ 1
"""
)
```

It also works with functions automatically.
Remember our `logarithm` function?

```jl
sco(
"""
logarithm.([1, 2, 3])
"""
)
```

#### Functions with a bang `!` {#sec:function_bang}

In Julia syntax is is common to append `!` to names of functions that modify their arguments.
This is a convention that warns the user that the function is **not pure**, i.e. it has *side effects*.
A function with side effects is useful when you want to update a large data structure or variable container without having all the overhead from creating a new instance.

Most of the `!` functions' arguments are data structures.

For example, we can create a function that adds 1 to its argument:

```jl
sc(
"""
function add_one!(x)
    for i in 1:length(x)
        x[i] += 1
    end
    return nothing
end
"""
)
```

```jl
sco(
"""
my_data = [1, 2, 3]

add_one!(my_data)

my_data
"""
)
```

### String {#sec:string}

**Strings** are represented delimited by double quotes:

```jl
sco(
"""
typeof("This is a string")
"""
)
```

We can also write a multiline string:

```jl
sco("""
s = "
This is a big multiline string.
As you can see.
It is still a String to Julia.
"
"""; post=output_block)
```

But, it is typically more clear to use triple-backtics:

```jl
sco("""
s = \"\"\"
    This is a big multiline string.
    As you can see.
    It is still a String to Julia.
    \"\"\"
"""; post=output_block)
```

When using triple-backticks, the indentation and newline at the start is ignored by Julia.
This helps code readability.

#### String Concatenation {#sec:string_concatenation}

A common string operation is **string concatenation**.
Suppose you want to construct a new string that is the concatenation of two or more strings.
This is accomplish in julia either with the `*` operator (this is where Julia departs from other scientific open-source programming languages) or the `join` function:

```jl
scob(
"""
hello = "Hello"
goodbye = "Goodbye"

hello * goodbye
"""
)
```

As you can see we are missing a space between `hello` and `goodbye`.
We could concatenate an additional `" "` string with the `*`, but that would be cumbersome for more than two strings.
That's when the `join` function comes up.
We just pass as arguments the strings inside the brackets `[]` and the separator:

```jl
scob(
"""
join([hello, goodbye], " ")
"""
)
```

#### String Interpolation {#sec:string_interpolation}

Concatenating strings can be convoluted.
We can be much more expressive with **string interpolation**.
It works like this: you specify whatever you want to be included in you string with the dollar sign `$`.
Here's the example before but now using interpolation:

```jl
scob(
"""
"\$hello \$goodbye"
"""
)
```

It works even inside functions.
Let's revisit our `test` function from [@sec:conditionals]:

```jl
scob(
"""
function test_interpolated(a, b)
    if a < b
        "\$a is less than \$b"
    elseif a > b
        "\$a is greater than \$b"
    else
        "\$a is equal to \$b"
    end
end

test_interpolated(3.14, 3.14)
"""
)
```

#### String Manipulations {#sec:string_manipulations}

There are several functions to manipulate strings in Julia.
We will demonstrate the most common ones.
Also, note that most of these functions accepts a [Regular Expression (RegEx)](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions) as arguments.
We won't cover RegEx in this book, but you are encouraged to learn about them, specially if most of your work uses textual data.

First, let us define a string for us to play around with:

```jl
scob(
"""
julia_string = "Julia is an amazing opensource programming language"
"""
)
```


1. `occursin`, `startswith` and `endswith`: A conditional (returns either `true` or `false`) if the first argument is a:
    * **substring** of the second argument

       ```jl
       scob(
       """
       occursin("Julia", julia_string)

       """
       )
       ```

    * **prefix** of the second argument

       ```jl
       scob(
       """
       startswith("Julia", julia_string)
       """
       )
       ```

    * **suffix** of the second argument

       ```jl
       scob(
       """
       endswith("Julia", julia_string)
       """
       )
       ```

2. `lowercase`, `uppercase`, `titlecase` and `lowercasefirst`:

    ```jl
    scob(
    """
    lowercase(julia_string)
    """
    )
    ```

    ```jl
    scob(
    """
    uppercase(julia_string)
    """
    )
    ```

    ```jl
    scob(
    """
    titlecase(julia_string)
    """
    )
    ```

    ```jl
    scob(
    """
    lowercasefirst(julia_string)
    """
    )
    ```

3. `replace`: introduces a new syntax, called the `Pair`

    ```jl
    scob(
    """
    replace(julia_string, "amazing" => "awesome")
    """
    )
    ```

4. `split`: breaks up a string by a delimiter:

    ```jl
    sco(
    """
    split(julia_string, " ")
    """
    )
    ```

#### String Conversions {#sec:string_conversions}

Often, we need to convert between types in Julia.
We can use the `string` function:

```jl
sco(
"""
my_number = 123
typeof(string(my_number))
"""
)
```

Sometimes, we want the opposite: convert a string to a number.
Julia has a handy function for that: `parse`

```jl
sco(
"""
typeof(parse(Int64, "123"))
"""
)
```

Sometimes, we want to play safe with these convertions.
That's when `tryparse` function steps in.
It has the same functionality as `parse` but returns either a value of the requested type, or `nothing`.
That makes `tryparse` handy when we want to avoid errors.
Of course, you would need to deal with all those `nothing` values afterwards.

```jl
sco(
"""
tryparse(Int64, "A very non-numeric string")
"""
)
```

### Tuple {#sec:tuple}

Julia has a data structure called **tuple**.
They are really *special* in Julia because they are *closely related* to functions.
Since functions are a important feature in Julia, every Julia user should know the basics of tuples.

A tuple is a **fixed-length container that can hold any type of value**.
A tuple is an **imutable object**, meaning that it cannot be modified after instantiation.
To construct a tuple you use parentheses `()` to delimitate the beginning and end, along with commas `,` as value's delimiters:

```jl
sco(
"""
my_tuple = (1, 3.14, "Julia")
"""
)
```

Here we are creating a tuple with three values.
Each one of the values is a different type.
We can access them via indexing.
Like this:

```jl
scob(
"""
my_tuple[2]
"""
)
```

We can also loop over tuples with the `for` keyword.
And even apply functions to tuples.
But we can **never change any value of a tuple**, since they are **immutable**.

The relationship between tuples and functions is a very important one.
Remember functions that return multiple values back in [@sec:function_multiple]?
Let's inspect what our `add_multiply` function returns:

```jl
sco(
"""
return_multiple = add_multiply(1, 2)
typeof(return_multiple)
"""
)
```

So, now you can see how they are related.
**Functions that return multiple arguments do so by returning a `Tuple`** with the types inside the `{}` brackets.

One more thing about tuples.
**When you want to pass more than one variable to an anonymous function, guess what you would need to use?
Once again: tuples!**

```jl
scob(
"""
map((x, y) -> x^y, 2, 3)
"""
)
```

Or even more than two arguments:

```jl
scob(
"""
map((x, y, z) -> x^y + z, 2, 3, 1)
"""
)
```

### Named Tuple {#sec:namedtuple}

Sometimes you want to name the values in tuples.
That's when **named tuples** comes in.
Their functionality is pretty much same the same as tuples: they are **immutable** and can hold **any type of value**.

Named tuple's construction are slightly different from tuples.
You have the familiar parentheses `()` and comma `,` value separator.
But now you must **name the values**:

```jl
sco(
"""
my_namedtuple = (i=1, f=3.14, s="Julia")
"""
)
```

We can access a named tuple's values via indexing like regular tuples or, alternatively, **access by their names** with the `.`:

```jl
scob(
"""
my_namedtuple.s
"""
)
```

To finish named tuples, there is one important *quick* syntax that you'll see a lot in Julia code.
Often Julia users create a tuple by using the familiar parenthesis `()` and commas `,`, but without naming the values.
To do so you **begin the named tuple construction by specifying first a semicolon `;` before the values**.
This is specially useful when the values that would compose the named tuple are already defined in variables:

```jl
sco(
"""
i = 1
f = 3.14
s = "Julia"

my_quick_namedtuple = (; i, f, s)
"""
)
```

### Ranges {#sec:ranges}

A range in Julia represents an interval between a start and stop boundaries.
The syntax is `start:stop`:

```jl
sco(
"""
1:10
"""
)
```

As you can see our instantiated range is of type `UnitRange{T}` where `T` is the type inside the `UnitRange`:

```jl
sco(
"""
typeof(1:10)
"""
)
```

And, if we gather all the values, we get:

```jl
sco("[x for x in 1:10]")
```

We can construct ranges also for other types:

```jl
sco(
"""
typeof(1.0:10.0)
"""
)
```

Sometimes, we want to change the default interval stepsize behavior.
We can do that by adding a stepsize in the range syntax `start:step:stop`.
For example, suppose we want a range of `Float64` from 0 to 1 with steps of size 0.2:

```jl
sco(
"""
0.0:0.2:1.0
"""
)
```

If you want to "materialize" a `UnitRange` into a collection you can use the function `collect`:

```jl
sco(
"""
collect(1:10)
"""
)
```

We have an array of the type specified in the `UnitRange` between the boundaries that we've set.
Speaking in arrays, let's talk about them.

### Array {#sec:array}

Arrays are a **systematic arrangement of similar objects, usually in _rows_ and _columns_**.
Most of the time you would want **arrays of a single type for performance issues**, but note that they can also hold objects of different types.
They are the "bread and butter" of data scientist, because arrays are what constitutes most of **data manipulation** and **data visualization** workflows.

**Arrays are a powerful data structure**. They are one of the main features that makes Julia blazing fast.

#### Array Types {#sec:array_types}

Let's start with arrays types.
There are several, but we will focus on two the most used in data science:

* `Vector{T}`: **one-dimensional** array. Alias for `Array{T, 1}`.
* `Matrix{T}`: **two-dimensional** array. Alias for `Array{T, 2}`.

Note here that `T` is the type of the underlying array.
So, for example, `Vector{Int64}` is a `Vector` which all elements are `Int64`s and `Matrix{AbstractFloat}` is a `Matrix` which all elements are subtypes of `AbstractFloat`.

Most of the time, specially when dealing with tabular data, we are using either one- or two-dimensional arrays.
They are both `Array` types for Julia.
But we can use the handy aliases `Vector` and `Matrix` for clear and concise syntax.

#### Array Construction {#sec:array_construction}

How do we construct an array?
The simplest answer is to use the **default constructor**.
It accepts the element type as the type parameter inside the `{}` brackets and inside the constructor you'll pass the element type followed by the desired dimensions.
It is common to initialize vector and matrices with undefined elements by using the `undef` argument for type.
A vector of 10 `undef` `Float64` elements can be constructed as:

```jl
sco(
"""
my_vector = Vector{Float64}(undef, 10)
"""
)
```

For matrices, since we are dealing with two-dimensional objects, we need to pass two dimensions arguments inside the constructor: one for **rows** and another for **columns**.
For example, a matrix with 10 rows, 2 columns and `undef` elements can be instantiate as:

```jl
sco(
"""
my_matrix = Matrix{Float64}(undef, 10, 2)
"""
)
```

We also have some **syntax aliases** for the most common elements in array construction:

* `zeros` for all elements being initialized to value zero.
  Note that the default type is `Float64` which can be changed if necessary:

    ```jl
    sco(
    """
    my_vector_zeros = zeros(10)
    """
    )
    ```

    ```jl
    sco(
    """
    my_matrix_zeros = zeros(Int64, 10, 2)
    """
    )
    ```

* `ones` for all elements being initialized to value one:

    ```jl
    sco(
    """
    my_vector_ones = ones(Int64, 10)
    """
    )
    ```

    ```jl
    sco(
    """
    my_matrix_ones = ones(10, 2)
    """
    )
    ```

For other elements we can first intantiate an array with `undef` elements and use the `fill!` function to fill all elements of an array with the desired element.
Here's an example with `3.14` ($\pi$):

```jl
sco(
"""
my_matrix_π = Matrix{Float64}(undef, 2, 2)
fill!(my_matrix_π, 3.14)
"""
)
```

We can also create arrays with **arrays literals**.
For example a 2x2 matrix of integers:

```jl
sco(
"""
[[1 2]
 [3 4]]
"""
)
```

Array literals also accept a type specification before the `[]` brackets.
So, if we want the same 2x2 array as before but now as floats, we can do so:

```jl
sco(
"""
Float64[[1 2]
        [3 4]]
"""
)
```

It also works for vectors:

```jl
sco(
"""
Bool[0, 1, 0, 1]
"""
)
```

You can even **mixmatch** array literals with the constructors:

```jl
sco(
"""
[ones(Int, 2, 2) zeros(Int, 2, 2)]
"""
)
```

```jl
sco(
"""
[zeros(Int, 2, 2)
 ones(Int, 2, 2)]
"""
)
```


```jl
sco(
"""
[ones(Int, 2, 2) [1; 2]
 [3 4]            5]
"""
)
```

Another powerful way to create arrays are **array comprehensions**.
This way of creating arrays is our *preferred* way, it avoids loops, indexing and other error-prone operations.
You specify what you want to do inside the `[]` brackets.
For example, say we want to create a vector of squares from 1 to 100:

```jl
sco(
"""
[x^2 for x in 1:10]
"""
)
```

They also support multiple inputs:

```jl
sco(
"""
[x*y for x in 1:10 for y in 1:2]
"""
)
```

And conditionals:

```jl
sco(
"""
[x^2 for x in 1:10 if isodd(x)]
"""
)
```

As with array literals you can specify your desired type before the `[]` brackets:


```jl
sco(
"""
Float64[x^2 for x in 1:10 if isodd(x)]
"""
)
```

Finally, we can also create arrays with **concatenation functions**:

* `cat`: concatenate input arrays along a specific dimension `dims`

    ```jl
    sco(
    """
    cat(ones(2), zeros(2), dims=1)
    """
    )
    ```

    ```jl
    sco(
    """
    cat(ones(2), zeros(2), dims=2)
    """
    )
    ```

* `vcat`: vertical concatenation, a shorthand for `cat(...; dims=1)`

    ```jl
    sco(
    """
    vcat(ones(2), zeros(2))
    """
    )
    ```

* `hcat`: horizontal concatenation, a shorthand for `cat(...; dims=2)`

    ```jl
    sco(
    """
    hcat(ones(2), zeros(2))
    """
    )
    ```

#### Array Inspection {#sec:array_inspection}

Once we have arrays, the next logical step is to inspect them.
There are a lot of handy functions that allows the user to have an inner insight into any array.

It is most useful to know what **type of elements** are inside an array.
We can do this with `eltype`:

```jl
sco(
"""
eltype(my_matrix_π)
"""
)
```

After knowing its types, one might be interested in array dimensions.
Julia has several functions to inspect array dimensions:

* `length`: total number of elements

    ```jl
    scob(
    """
    length(my_matrix_π)
    """
    )
    ```

* `ndims`: number of dimensions

    ```jl
    scob(
    """
    ndims(my_matrix_π)
    """
    )
    ```

* `size`: this one is a little tricky.
    By default it will return a tuple containing the array's dimensions.

    ```jl
    sco(
    """
    size(my_matrix_π)
    """
    )
    ```

    You can get a specific dimension with a second argument to `size`

    ```jl
    scob(
    """
    size(my_matrix_π, 2) # columns
    """
    )
    ```


#### Array Indexing and Slicing {#sec:array_indexing}

Sometimes we want to only inspect certain parts of an array.
This is called **indexing** and **slicing**.
If you want a particular observation of a vector, or a row or column of a matrix; you'll probably need to **index an array**.

First, I will create an example vector and matrix to play around:

```jl
sc(
"""
my_example_vector = [1, 2, 3, 4, 5]

my_example_matrix = [[1 2 3]
                     [4 5 6]
                     [7 8 9]]
"""
)
```

Let's see first an example with vectors.
Suppose you want the second element of a vector.
You append `[]` brackets with the desired **index** inside:

```jl
scob(
"""
my_example_vector[2]
"""
)
```

The same syntax follows with matrices.
But, since matrices are 2-dimensional arrays, we have to specify *both* rows and columns.
Let's retrieve the element from the second row (first dimension) and first column (second dimension):

```jl
scob(
"""
my_example_matrix[2, 1]
"""
)
```

Julia also have conventional keywords for the first and last elements of an array: `begin` and `end`.
For example, the second to last element of a vector can be retrieved as:

```jl
scob(
"""
my_example_vector[end-1]
"""
)
```

It also work for matrices.
Let's retrieve the element of the last row and second column:

```jl
scob(
"""
my_example_matrix[end, begin+1]
"""
)
```

Often, we are not only interested in just one array element, but in a whole **subset of array elements**.
We can accomplish this by **slicing** an array.
It uses the same index syntax, but with the added colon `:` to denote the boundaries that we are slicing through the array.
For example, suppose we want to get the 2nd to 4th element of a vector:

```jl
sco(
"""
my_example_vector[2:4]
"""
)
```

We could do the same with matrices.
Particularly with matrices if we want to select all elements in a following dimension we can do so with just a colon `:`.
For example, all elements in the second row:

```jl
sco(
"""
my_example_matrix[2, :]
"""
)
```

You can interpret this with something like "take 2nd row and all columns".

It also supports `begin` and `end`:

```jl
sco(
"""
my_example_matrix[begin+1:end, end]
"""
)
```

#### Array Manipulations {#sec:array_manipulation}

There are several ways we could manipulate an array.
The first would be to manipulate a **singular element of the array**.
We just index the array by the desired element and proceed with an assignment `=`:

```jl
sco(
"""
my_example_matrix[2, 2] = 42
my_example_matrix
"""
)
```

Or you can manipulate a certain **subset of elements of the array**.
In this case, we need to slice the array and then assign with `=`:

```jl
sco(
"""
my_example_matrix[3, :] = [17, 16, 15]
my_example_matrix
"""
)
```

Note that we had to assign a vector because we our sliced array is of type `Vector`:

```jl
sco(
"""
typeof(my_example_matrix[3, :])
"""
)
```

The second way we could manipulate an array is to **alter its shape**.
Suppose you have a 6-element vector and you want to make it a 3x2 matrix.
You can do so with `reshape`, by using the array as first argument and a tuple of dimensions as second argument:

```jl
sco(
"""
six_vector = [1, 2, 3, 4, 5, 6]
tree_two_matrix = reshape(six_vector, (3, 2))
tree_two_matrix
"""
)
```

You can do the reverse, convert it back to a vector, by specifying a tuple with only one dimension as second argument:

```jl
sco(
"""
reshape(tree_two_matrix, (6, ))
"""
)
```

The third way we could manipulate an array is to **apply a function over every array element**.
This is where the familiar broadcasting "dot" operator `.` comes in.

```jl
sco(
"""
logarithm.(my_example_matrix)
"""
)
```

We also broadcast operators:

```jl
sco(
"""
my_example_matrix .+ 100
"""
)
```

We can use also `map` to apply a function to every element of an array:

```jl
sco(
"""
map(logarithm, my_example_matrix)
"""
)
```

It also accepts an anonymous function:

```jl
sco(
"""
map(x -> x*3, my_example_matrix)
"""
)
```

It also works with slicing:

```jl
sco(
"""
map(x -> x + 100, my_example_matrix[:, 3])
"""
)
```

Finally, sometimes, and specially when dealing with tabular data, we want to apply a **function over all elements in a specific array dimension**.
This can be done with the `mapslices` function.
Similar to `map`, the first argument is the function and the second argument is the array.
The only change is that we need to specify the `dims` argument to flag what dimension we want to transform the elements.

For example let's use `mapslice` with the `sum` function on both rows (`dims=1`) and columns (`dims=2`):

```jl
sco(
"""
# rows
mapslices(sum, my_example_matrix; dims=1)
"""
)
```

```jl
sco(
"""
# columns
mapslices(sum, my_example_matrix; dims=2)
"""
)
```

#### Array Iteration {#sec:array_iteration}

One common operation is to **iterate over an array with a `for` loop**.
The **regular `for` loop over an array returns each element**.

The simplest example is with a vector.

```jl
sco(
"""
simple_vector = [1, 2, 3]

empty_vector = Int64[]

for i in simple_vector
    push!(empty_vector, i + 1)
end

empty_vector
"""
)
```

Sometimes you don't want to loop over each element, but actually over each array index.
**We can `eachindex` function combined with a `for` loop to iterate over each array index**.

Again, let's show an example with a vector:

```jl
sco(
"""
forty_two_vector = [42, 42, 42]

empty_vector = Int64[]

for i in eachindex(forty_two_vector)
    push!(empty_vector, i)
end

empty_vector
"""
)
```

In this example the `eachindex(forty_two_vector)` iterator inside the `for` loop returns not `forty_two_vector`'s values but its indices: `[1, 2, 3]`.

Iterating over matrices involves more details.
The standard `for` loop goes first over columns then over rows.
It will first traverse all elements in column 1, from the first row to the last row, then it will move to column 2 in a similar fashion until it has covered all columns.

Those familiar with other programming languages, Julia, like most scientific programming languages, is "column-major".
This means that arrays are stored contiguously using a column orientation.
If any time you are seeing problems of performance and there is an array `for` loop involved, chances are that you are mismatching Julia's native column-major storage orientation.

Ok, let's show this in an example:

```jl
sc(
"""
column_major = [[1 2]
                [3 4]]

row_major = [[1 3]
             [2 4]]
"""
)
```

```jl
sco(
"""
empty_vector = Int64[]

for i in column_major
    push!(empty_vector, i)
end

empty_vector
"""
)
```

```jl
sco(
"""
empty_vector = Int64[]

for i in row_major
    push!(empty_vector, i)
end

empty_vector
"""
)
```

There are some handy functions to iterate over matrices.

* `eachcol`: iterates over an array column first

    ```jl
    sco(
    """
    first(eachcol(column_major))
    """
    )
    ```

* `eachrow`: iterates over an array row first

    ```jl
    sco(
    """
    first(eachrow(column_major))
    """
    )
    ```

### Pair {#sec:pair}

Compared to the huge section on arrays, this section on pairs will be brief.
**`Pair` is a data structure that holds two types**.
How we construct a pair in Julia is using the following syntax:

```jl
sco(
"""
my_pair = Pair("Julia", 42)
"""
)
```

Alternatively, we can create a pir by specifying both values and in between we use the pair `=>` operator:

```jl
sco(
"""
my_pair = "Julia" => 42
"""
)
```

The elements are stored in the fields `first` and `second`.

```jl
scob(
"""
my_pair.first
"""
)
```

```jl
scob(
"""
my_pair.second
"""
)
```

Pairs will be used a lot in data manipulation and data visualization since both [`DataFrames.jl`](dataframes.html) and [`Plots.jl`](plots.html) main functions depends on `Pair` as type arguments.

### Dict {#sec:dict}

If you understood what a `Pair` is, then `Dict` won't be a problem.
**`Dict` in Julia is just a "hash table" with pairs of `key` and `value`**.
`key`s and `value`s can be of any type, but generally you'll see `key`s as strings.

There are two ways to construct `Dict`s in Julia.
The first is using the **default constructor `Dict` and passing a vector of tuples composed of `(key, value)`**:

```jl
sco(
"""
my_dict = Dict([("one", 1), ("two", 2)])
"""
)
```

We *prefer* the second way of constructing `Dict`s.
It offers a much elegant and expressive syntax.
You use the same **default constructor `Dict`**, but now you pass **`pair`s of `key` and `value`**:


```jl
sco(
"""
my_dict = Dict("one" => 1, "two" => 2)
"""
)
```

You can retrieve a `Dict`s `value` by indexing it by the corresponding `key`:

```jl
scob(
"""
my_dict["one"]
"""
)
```

Similarly, to add a new entry you index the `Dict` by the desired `key` and assign a `value` with the assignment `=` operator:

```jl
scob(
"""
my_dict["three"] = 3
"""
)
```

If you want to check if a `Dict` has a certain `key` you can use the `haskey` function:

```jl
scob(
"""
haskey(my_dict, "two")
"""
)
```

To delete a `key` you can use either the `delete!` function:

```jl
sco(
"""
delete!(my_dict, "three")
"""
)
```

Or to delete a `key` while retuning its `value` you can use the `pop!` function:

```jl
scob(
"""
popped_value = pop!(my_dict, "two")
"""
)
```

Now our `my_dict` has only one `key`:

```jl
scob(
"""
length(my_dict)
"""
)
```

```jl
sco(
"""
my_dict
"""
)
```

`Dict`s are also used in data manipulations by [`DataFrames.jl`](dataframes.html) and data visualization by [`Plots.jl`](plots.html).
So it is important to know their basic functionality.

There is one useful `Dict` constructor that we use a lot.
Suppose you have two vectors and you want to construct a `Dict` with one of them as `key`s and the other as `value`s.
You can do that with the `zip` function which "glues" together two objects just like a zipper:

```jl
sco(
"""
A = ["one", "two", "three"]
B = [1, 2, 3]

dic = Dict(zip(A, B))
"""
)
```

For instance, we can now get the number 3 via:

```jl
scob(
"""
dic["three"]
"""
)
```

### Symbol {#sec:symbol}

`Symbol` is actually *not* a data structure.
It is a type and behaves at lot like a string.
Instead of surrounding the text by quotation marks, a symbol starts with a colon (:) and can contain underscores:

```jl
sco("""
sym = :some_text
""")
```

Since symbols and strings are so similar, we can easily convert a symbol to string and vice versa:

```jl
scob("""
s = string(sym)
""")
```

```jl
sco("""
sym = Symbol(s)
""")
```

One simple benefit of symbols is that you have to type one character less, that is, `:some_text` versus `"some text"`.
We use `Symbol`s a lot in data manipulitions with the `DataFrames.jl` package (@sec:dataframes) and data visualizations (@sec:plots and -@sec:makie).

## Filesystem {#sec:filesystem}

In data science, most projects are undertaken in a collaborative effort.
We share code, data, tables, figures and so on.
Behind everything, there is the **operational system (OS) filesystem**.
In an ideal work, code would run the *same* in *different* OS.
But that is not what actually happens.
One instance of this is the difference of Windows paths, such as `C:\\user\john\`, and Linux paths, such as `/home/john`.
This is why is important to discuss **filesystem best practices**.

Julia has native filesystem capabilities that can **handle all different OS demands**.
They are located in the [`Filesystem`](https://docs.julialang.org/en/v1/base/file/) module from the core `Base` Julia library.
This means that Julia provides everything you need to make your code perform flawlessly in any OS that you want to.

Whenever you are dealing with files such as CSV, Excel files or other Julia scripts, make sure that your code is compliant with all different OS filesystems.
This is easily accomplished with the `joinpath` and `pwd` functions.

The `pwd` functions is an acronym for **p**rint **w**orking **d**irectory and it returns a string containing the current working directory.
One nice thing about `pwd` is that it is robust to OS, i.e. it will return the correct string in Linux, MacOS, Windows or any other OS.
For example, let's see what are our current directory and record it in a variable `root`:

```jl
scob(
"""
root = pwd()
"""
)
```

The next step would be to include the relative path from `root` to our desired file.
Since different OS have different ways to construct relative paths with subfolders, some use forward slash `/` while other might use backslashes `\`, we cannot simply concatenate the our file's relative path with the `root` string.
For that, we have the `joinpath` function, which will join different relative paths and filenames into your specific OS filesystem implementation.

Suppose you have a script named `my_script.jl` inside your project's directory.
You can have a robust representation of the filepath to `my_script.jl` as:

```jl
scob(
"""
joinpath(root, "my_script.jl")
"""
)
```

`joinpath` also handles subfolders.
Let's now imagine a common situation where you have a folder named `data/` in your project's directory.
Inside this folder there is a CSV file named `my_data.csv`.
You can have the same robust representation of the filepath to `my_data.jl` as:

```jl
scob(
"""
joinpath(root, "data", "my_data.csv")
"""
)
```

Always make sure that your code can run anywhere.
It's a good habit to pick up, because it's very likely to save problems later.

## Julia Standard Library {#sec:standardlibrary}

Julia has a rich standard library that ships with *every* Julia installation.
Contrary to everything that we have seen so far, e.g. types, data structures and filesystem; you **must import standard library modules into your environment** to use a particular module or function.

This is done with the `using` keyword:

```julia
using ModuleName
```

Now you can access all functions and types inside `ModuleName`.

### Dates {#sec:dates}

How to handle dates and timestamps is something quite important in data science.
Like we said in [*Why Julia?*](why_julia.html) section, Python's `pandas` uses its own `Datetime` type to handle dates.
The same with R tidyverse's `lubridate` package, which also defines its own `datetime` type to handle dates.
Julia doesn't need any of this, it has all the **date stuff already baked onto its standard library, in a module named `Dates`**.

To begin, let's import the `Dates` module:

```julia
using Dates
```

#### `Date` and `DateTime` Types {#sec:dates_types}

The `Dates` standard library module has **two types for working with dates**:

1. `Date`: representing time in days; and
2. `DateTime`: representing time in millisecond precision.

We can construct `Date` and `DateTime` with the default constructor either by specifying an integer to represent year, month, day, hours and so on:

```jl
sco(
"""
Date(1987) # year
"""
)
```

```jl
sco(
"""
Date(1987, 9) # month
"""
)
```

```jl
sco(
"""
Date(1987, 9, 13) # day
"""
)
```

```jl
sco(
"""
DateTime(1987, 9, 13, 21) # hour
"""
)
```

```jl
sco(
"""
DateTime(1987, 9, 13, 21, 21) # minute
"""
)
```

For the curious, September 13th 1987, 21:21 is the official time of birth of the first author, Jose.


We can also pass `Period` types to the default constructor.
**`Period` types are the human-equivalent representation of time** for the computer.
Julia's `Dates` have the following `Period` abstract subtypes:

```jl
sco(
"""
subtypes(Period)
"""
)
```

Which divide into the following concrete types, they are pretty much self-explanatory:

```jl
sco(
"""
subtypes(DatePeriod)
"""
)
```

```jl
sco(
"""
subtypes(TimePeriod)
"""
)
```

So we could alternatively construct Jose's official time of birth as:

```jl
sco(
"""
DateTime(Year(1987), Month(9), Day(13), Hour(21), Minute(21))
"""
)
```

#### Parsing Dates {#sec:dates_parsing}

Most of the time we won't be constructing `Date` or `DateTime` instances from scratch.
Actually, we probably will be **parsing strings as `Date` or `DateTime` types**.

The `Date` and `DateTime` constructors can be fed a string and a format string.
For example, the string `"20210101"` representing January 1st can be parsed with:

```jl
sco(
"""
Date("19870913", "yyyymmdd")
"""
)
```

Notice that the second argument is a string representation of the format.
We have the first four digits representing year `y`, followed by two digits for month `m` and finally two digits for day `d`.

It also works for timestamps with `DateTime`:

```jl
sco(
"""
DateTime("1987-09-13T21:21:00", "yyyy-mm-ddTHH:MM:SS")
"""
)
```

You can find more on how to specify different format as strings in the [Julia `Dates`' documentation](https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateFormat).
Don't worry if you have to revisit it all the time, we ourselves have to do it all the time when working with dates and timestamps.

According to [Julia `Dates`' documentation](https://docs.julialang.org/en/v1/stdlib/Dates/#Constructors), using the `Date(date_string, format_string)` method is fine if only called a few times.
If there are many similarly formatted date strings to parse, however, it is much more efficient to first create a `DateFormat` type, and then pass it instead of a raw format string.
So our previous example would become:

```jl
sco(
"""
format = DateFormat("yyyymmdd")
Date("19870913", format)
"""
)
```

Alternatively, without loss of performance, you can use the string literal prefix `dateformat"..."`:

```jl
sco(
"""
Date("19870913", dateformat"yyyymmdd")
"""
)
```

#### Extracting Date Information {#sec:dates_information}

It is easy to **extract desired information from `Date` and `DateTime` objects**.
First, let's create an instance of a very special date:

```jl
sco(
"""
my_birthday = Date("1987-09-13")
"""
)
```

We can extract anything we want from `my_birthday`:

```jl
scob(
"""
year(my_birthday)
"""
)
```

```jl
scob(
"""
month(my_birthday)
"""
)
```

```jl
scob(
"""
day(my_birthday)
"""
)
```

Julia's `Dates` module also have **compound functions that returns a tuple of values**:

```jl
sco(
"""
yearmonth(my_birthday)
"""
)
```

```jl
sco(
"""
monthday(my_birthday)
"""
)
```

```jl
sco(
"""
yearmonthday(my_birthday)
"""
)
```

We can also see day of the week and other handy stuff:

```jl
scob(
"""
dayofweek(my_birthday)
"""
)
```

```jl
scob(
"""
dayname(my_birthday)
"""
)
```

```jl
scob(
"""
dayofweekofmonth(my_birthday) # second sunday
"""
)
```

Yep, Jose was born on the second sunday of September.

> **_NOTE:_**
> Here's a handy tip to just recover weekdays from `Dates` instances.
> Just use a `filter` on `dayofweek(your_date) <= 5`.
> For business day you can check the package [`BusinessDays.jl`](https://github.com/JuliaFinance/BusinessDays.jl).

#### Date Operations {#sec:dates_operations}

We can perform **operations** in `Dates` instances.
For example, we can add days to a `Date` or `DateTime` instance.
Notice that Julia's `Dates` will automatically perform the adjustments necessary for leapyears, of months with 30 or 31 days (this is known as *calendrical* arithmetic).

```jl
sco(
"""
my_birthday + Day(90)
"""
)
```

We can add as many as we like:

```jl
sco(
"""
my_birthday + Day(90) + Month(2) + Year(1)
"""
)
```

To get **date duration**, we just use the **subtraction** `-` operator.
Let's see how many days Jose is old:

```jl
sco(
"""
today() - my_birthday
"""
)
```

The **default duration** of `Date` types is a `Day` instance.
For the `DateTime`, the default duration is `Millisecond` instance:

```jl
sco(
"""
DateTime(today()) - DateTime(my_birthday)
"""
)
```

#### Date Intervals {#sec:dates_intervals}

One nice thing about `Dates` module is that we can also easily construct date and time intervals.
Julia is clever enough to not have to define the whole interval types and operations that we covered in [@sec:ranges].
It just extends the functions and operations defined for `UnitRange` to `Date`'s types.
This is known as multiple dispatch and we already covered in [*Why Julia?*](why_julia.html).

For example suppose you want to create a `Day` interval.
This is easy done with the colon `:` operator:

```jl
sco(
"""
Date("2021-01-01"):Day(1):Date("2021-01-07")
"""
)
```

There is nothing special in using `Day(1)` as interval, we can **use whatever `Period` type** as interval.
For example using 3 days as intervals:

```jl
sco(
"""
Date("2021-01-01"):Day(3):Date("2021-01-07")
"""
)
```

Or even months:

```jl
sco(
"""
Date("2021-01-01"):Month(1):Date("2021-03-01")
"""
)
```

Note that the **type of this interval is a `StepRange` with the `Date` and concrete `Period` type** we used as interval inside the colon `:` operator:

```jl
sco(
"""
my_date_interval = Date("2021-01-01"):Month(1):Date("2021-03-01")
typeof(my_date_interval)
"""
)
```

We can convert this to a **vector** with the `collect` function:

```jl
sco(
"""
my_date_interval_vector = collect(my_date_interval)
"""
)
```

And have all the **array functionalities available**, like, for example, indexing:

```jl
sco(
"""
my_date_interval_vector[end]
"""
)
```

We can also **broadcast date operations** to our vector of `Date`s:

```jl
sco(
"""
my_date_interval_vector .+ Day(10)
"""
)
```

All we've done with `Date` types can be extended to `DateTime` types in the same manner.

### Random Numbers {#sec:random}

Another important module in Julia's standard library is the `Random` module.
This module deals with **random number generation**.
`Random` is a rich library and, if you interested in it, you should consult [Julia's `Random` documentation](https://docs.julialang.org/en/v1/stdlib/Random/).
We will cover *only* three functions: `seed!`, `rand` and `randn`.

To begin we first import the `Random` module:

```julia
using Random
```

We have **two main functions that generate random numbers**:

* `rand`: samples a **random element** of a data structure or type.
* `randn`: generates a random number that follows a **standard normal distribution** (mean 0 and standard deviation 1) of a specific type.

> **_NOTE:_**
> Note that those two functions are already in the Julia `Base` module.
> So you don't need to import `Random` if you planning to use them

#### `rand` {#sec:random_rand}

By default if you call `rand` without arguments it will return a `Float64` in the interval $[0, 1)$, which means between 0 inclusive to 1 exclusive:

```jl
scob(
"""
rand()
"""
)
```

You can modify `rand` arguments in several ways.
For example, suppose you want more than 1 random number:

```jl
sco(
"""
rand(3)
"""
)
```

Or you want a different interval:

```jl
scob(
"""
rand(1.0:10.0)
"""
)
```

You can also specify a different step size inside the interval and a different type.
Here we are using number without the `.` so Julia will interpret them as `Int64`:

```jl
scob(
"""
rand(2:2:20)
"""
)
```

You can also mixmatch arguments:

```jl
sco(
"""
rand(2:2:20, 3)
"""
)
```

It also supports a collection of elements as a tuple:

```jl
scob(
"""
rand((42, "Julia", 3.14))
"""
)
```

And also arrays:

```jl
scob(
"""
rand([1, 2, 3])
"""
)
```

`Dict`s:

```jl
sco(
"""
rand(Dict("one"=>1, "two"=>2))
"""
)
```

To finish off all the `rand` arguments options, you can specify the desired random number dimensions in a tuple.
If you do this, the returned type will be an array.
For example, a 2x2 matrix of `Float64` between 1.0 and 3.0:

```jl
sco(
"""
rand(1.0:3.0, (2, 2))
"""
)
```

#### `randn` {#sec:random_randn}

`randn` follows the same general principle from `rand` but now it only returns numbers generated from standard normal distribution.
The standard normal distribution is the normal distribution with mean 0 and standard deviation 1.
The default type is `Float64` and it only allows for subtypes of `AbstractFloat` or `Complex`:

```jl
scob(
"""
randn()
"""
)
```

We can only specify the size:

```jl
sco(
"""
randn((2, 2))
"""
)
```

#### `seed!` {#sec:random_seed}

To finish off the `Random` overview, let's talk about **reproducibility**.
Often, we want to make something replicable.
Meaning that, we want the random number generator to generate the same random sequence of numbers,
despite paradoxical that might sound...
We can do so with the `seed!` function.

Let me show you an example of a `rand` that generates the same three numbers given a certain seed:

```jl
sco(
"""
Random.seed!(123)
rand(3)
"""
)
```

```jl
sco(
"""
Random.seed!(123)
rand(3)
"""
)
```

Note that `seed!` is not automatically exported by the `Random` module.
We have to call it with the `Module.function` syntax.

In order to avoid tedious and inefficient repetition of `seed!` all over the place we can instead define an instance of a `seed!` and pass it as a first argument of **either `rand` or `randn`**.

```jl
sco(
"""
my_seed = Random.seed!(123)
"""
)
```


```jl
sco(
"""
rand(my_seed, 3)
"""
)
```

```jl
sco(
"""
rand(my_seed, 3)
"""
)
```

> **_NOTE:_**
> If you want your code to be reproducible you can just call `Random.seed!` in the beggining of your script.
> This will take care of reproducibility in sequential `Random` operations.
> No need to use it all `rand` and `randn` usage.

### Downloads {#sec:downloads}

One last thing from Julia's standard library for us to cover is the `Download` module.
It will be really brief because we will only be covering a single function named `download`.

Suppose you want to **download a file from the internet to your local storage**.
You can accomplish this with the `download` function.
The first and only required argument is the file's url.
You can also specify as a second argument the desired output path for the downloaded file (don't forget the filesystem best practices!).
If you don't specify a second argument, Julia will, by default, create a temporary file with the `tempfile` function.

Let's import the `Download` module:

```julia
using Download
```

For example let's download our [`JuliaDataScience` GitHub repository](https://github.com/JuliaDataScience/JuliaDataScience) `Project.toml` file.
Note that `download` function is not exported by `Downloads` module, so we have to use the `Module.function` syntax.
By default it returns a string that holds the file path for the downloaded file:

```jl
scob(
"""
url = "https://raw.githubusercontent.com/JuliaDataScience/JuliaDataScience/main/Project.toml"

my_file = Downloads.download(url) # tempfile() being created
"""
)
```

Let's just show the first 4 lines of our downloaded file with the `readlines` function:

```jl
sco(
"""
readlines(my_file)[1:4]
"""; process=Books.catch_show
)
```

> **_NOTE:_**
> If you want to interact with web requests or web APIs, you would probably need to use the [`HTTP.jl` package](https://github.com/JuliaWeb/HTTP.jl).
