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
There is a nice handy function `methodswit` that spits out every function available, along with its signature, for a certain type.
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

Here is a few examples with some of them:

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

Regarding numeric comparison, Julia have three major types of comparisons:

1. **Equality**: either something is *equal* or *not equal* another
   * `==`: equality
   * `!-` or `≠`: inequality
2. **Less than**: either something is *less than* or *less than or equal to*
    * `<`: less than
    * `<=` or `≤`: less than or equal to
4. **Greater than**: either something is *greater than* or *greater than or equal to*
    * `>`: greater than
    * `>=` or `≥`: less than or equal to

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

Now it works as expected with any float type:

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
For example, let's define a `logarithm` function that by default uses base $e$ (2.2.7182818284590) as a keyword argument.
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

A lot of times we need to quickly use functions without having to define a full-fledged function with the `function ... end` syntax.
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

Here we are using the `map` function to conveniently map the anonymous function (first argument) to `logarithm(2)` (the second argument).
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

We can even wrap this in a function called `test`:

```jl
scob(
"""
function test(a, b)
    if a < b
        "a is less than b"
    elseif a > b
        "a is greater than b"
    else
        "a is equal to b"
    end
end

test(3.14, 3.14)
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
for i ∈ 1:10
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

We will cover `String`, `Tuple`, `NamedTuple`, `Arrays`, `Dict` and `Symbol`.

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

**Strings** in Julia are represented delimited by double quotes:

```jl
sco(
"""
typeof("This is a string")
"""
)
```

For long strings we can use triple double quotes:

```jl
sco(
"""
typeof(
\"\"\"
This is a big multiline string.
As you can see.
It is still a String to Julia.
\"\"\"
)
"""
)
```

#### String Concatenation {#sec:string_concatenation}

One nice thing we can do with strings in Julia is **string concatenation**.
Suppose you want to construct a new string that is the concatenation of two or more strings.
This is accomplish in julia either with the `*` operator (this is where Julia departs from other scientific open-source programming languages) or the `join` function:

```jl
scob(
"""
hello = "Hello"
goodbye = "Goobye"

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

Sometimes we want the opposite: convert a string to a number.
Julia has a handy function for that: `parse`

```jl
sco(
"""
typeof(parse(Int64, "123"))
"""
)
```

Sometimes we want to play safe with these convertions.
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
sco(
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
s="Julia"

my_quick_namedtuple = (; i, f, s)
"""
)
```

### Array {#sec:array}

Arrays are a **systematic arrangement of similar objects, usually in _rows_ and _columns_**.
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

```{=comment}
Array comprehensions
cat vcat hcat hvcat
```

#### Array Inspection {#sec:array_inspection}

```{=comment}
eltype
length
ndims
size
```

#### Array Indexing and Slicing {#sec:array_indexing}

```{=comment}
Serious discussion about indexing `begin` and `end` keywords.
```

#### Array Manipulations {#sec:array_manipulation}

```{=comment}
index assignment
reshape
fill
broadcasting functions and operators
map
mapslices
```

#### Array Iteration {#sec:array_iteration}


```{=comment}
for a in A
    # Do something with the element a
end

for i in eachindex(A)
    # Do something with i and/or A[i]
end

For Loops
eachindex
eachcol
eachrow
```

### Pair {#sec:pair}

### Dict {#sec:dict}

### Symbol {#sec:symbol}

```{=comment}
They are import for DataFrames and StatsPlots stuff
```

## Filesystem {#sec:filesystem}

```{=comment}
joinpath (windows, Mac, Linux)
```

## Julia Standard Library {#sec:standardlibrary}
### Dates {#sec:dates}
### Random Numbers {#sec:random}

```{=comment}
seed!, rand and randn
```

### Downloads {#sec:downloads}
