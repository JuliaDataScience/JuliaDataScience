# Julia Basics {#sec:julia_basics}

> ***NOTE:*** In this chapter we cover the basics of Julia as a programming language. Please note that this is not *strictly necessary* for you to use Julia as a tool for data manipulation and data visualization. Having a basic understanding of Julia will definitely make you more *effective* and *efficient* in using Julia. However, if you prefer to get started straight away, you can jump to @sec:dataframes to learn about tabular data with `DataFrames.jl`.


This is going to be a very brief and *not* an in-depth overview of the Julia language. If you are already familiar and comfortable with other programming languages, we highly encourage you to read Julia's documentation ([https://docs.julialang.org/](https://docs.julialang.org/)). The docs are an excellent resource for taking a deep dive into Julia. It covers all the basics and corner cases, but it can be cumbersome, especially if you aren't familiar with software documentation.

We'll cover the basics of Julia. Imagine that Julia is a fancy feature-loaded car, such as a brand-new Tesla. We'll just explain to you how to "drive the car, park it, and how to navigate in traffic". If you want to know what "all the buttons in the steering wheel and dashboard do", this is not the resource you are looking for.

## Development Environments {#sec:ide}

Before we can dive into the language syntax, we need to answer how to run code. Going into details about the various options is out of scope for this book. Instead, we will provide you with some pointers to various solutions.

The simplest way is to use the Julia REPL. This means starting the Julia executable (`julia` or `julia.exe`) and running code there. For example, we can start the Julia REPL and execute some code:

```julia-repl
julia> x = 2
2

julia> x + 1
3
```

This works all very well, but what if we want to save the code that we wrote? To save our code, one can write ".jl" files such as "script.jl" and load these into Julia. Say, that "script.jl" contains:

```julia (editor=true, logging=false, output=true)
x = 3
y = 4
```
We can load this into Julia:

```julia-repl
julia> include("script.jl")
julia> y
4
```

Now the problem becomes that we would like Julia to re-read our script every time before executing code. This can be done via [Revise.jl](https://github.com/timholy/Revise.jl). Because compilation time in Julia is often long, `Revise.jl` is a must-have for Julia development. For more information, see the `Revise.jl` documentation or simply Google a bit if you have specific questions.

We are aware that `Revise.jl` and the REPL requires some manual actions which aren't super clearly documented. Luckily, there is [Pluto.jl](https://github.com/fonsp/Pluto.jl). `Pluto.jl` automatically manages dependencies, runs code, and **reacts** to changes. For people who are new to programming, `Pluto.jl` is by far the easiest way to get started. The main drawback of the package is that it is less suitable for larger projects.

Other options are to use Visual Studio Code with various Julia extensions or manage your own IDE. If you **don't** know what an IDE is, but do want to manage large projects choose Visual Studio Code. If you **do** know what an IDE is, then you might like building your own IDE with Vim or Emacs and the REPL.

So, to summarize:

  * Easiest way to get started -> `Pluto.jl`
  * Larger projects -> Visual Studio Code
  * Advanced users -> Vim, Emacs and the REPL

## Language Syntax {#sec:syntax}

Julia is a **dynamic-typed language** with a just-in-time compiler. This means that you don't need to compile your program before you run it, like you would do in C++ or FORTRAN. Instead, Julia will take your code, guess types where necessary, and compile parts of code just before running it. Also, you don't need to explicitly specify each type. Julia will guess types for you on the go.

The main differences between Julia and other dynamic languages such as R and Python are the following. First, Julia **allows the user to specify type declarations**. You already saw some types declarations in *Why Julia?* (@sec:why_julia): they are those double colons `::` that sometimes come after variables. However, if you don't want to specify the type of your variables or functions, Julia will gladly infer (guess) them for you.

Second, Julia allows users to define function behavior across many combinations of argument types via multiple dispatch. We also covered multiple dispatch in @sec:julia_accomplish. We defined a different type behavior by defining new function signatures for argument types while using the same function name.

### Variables {#sec:variable}

Variables are values that you tell the computer to store with a specific name, so that you can later recover or change its value. Julia has several types of variables but, in data science, we mostly use:

  * Integers: `Int64`
  * Real Numbers: `Float64`
  * Boolean: `Bool`
  * Strings: `String`

Integers and real numbers are stored by using 64 bits by default, that's why they have the `64` suffix in the name of the type. If you need more or less precision, there are `Int8` or `Int128` types, for example, where higher means more precision. Most of the time, this won't be an issue so you can just stick to the defaults.

We create new variables by writing the variable name on the left and its value in the right, and in the middle we use the `=` assignment operator. For example:

```julia (editor=true, logging=false, output=true)
name = "Julia"
age = 9
```
Note that the return output of the last statement (`age`) was printed to the console. Here, we are defining two new variables: `name` and `age`. We can recover their values by typing the names given in the assignment:

```julia (editor=true, logging=false, output=true)
name
```
If you want to define new values for an existing variable, you can repeat the steps in the assignment. Note that Julia will now override the previous value with the new one. Supposed, Julia's birthday has passed and now it has turned 10:

```julia (editor=true, logging=false, output=true)
age = 10
```
We can do the same with its `name`. Suppose that Julia has earned some titles due to its blazing speed. We would change the variable `name` to the new value:

```julia (editor=true, logging=false, output=true)
name = "Julia Rapidus"
```
We can also do operations on variables such as addition or division. Let's see how old Julia is, in months, by multiplying `age` by 12:

```julia (editor=true, logging=false, output=true)
12 * age
```
We can inspect the types of variables by using the `typeof` function:

```julia (editor=true, logging=false, output=true)
typeof(age)
```
The next question then becomes: "What else can I do with integers?" There is a nice handy function `methodswith` that spits out every function available, along with its signature, for a certain type. Here, we will restrict the output to the first 5 rows:

```julia (editor=true, logging=false, output=true)
first(methodswith(Int64), 5)
```
### User-defined Types {#sec:struct}

Having variables around without any sort of hierarchy or relationships is not ideal. In Julia, we can define that kind of structured data with a `struct` (also known as a composite type). Inside each `struct`, you can specify a set of fields. They differ from the primitive types (e.g. integer and floats) that are by default defined already inside the core of Julia language. Since most `struct`s are user-defined, they are known as user-defined types.

For example, let's create a `struct` to represent scientific open source programming languages. We'll also define a set of fields along with the corresponding types inside the `struct`:

```julia (editor=true, logging=false, output=true)
struct Language
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end
```
To inspect the field names you can use the `fieldnames` and pass the desired `struct` as an argument:

```julia (editor=true, logging=false, output=true)
fieldnames(Language)
```
To use `struct`s, we must instantiate individual instances (or "objects"), each with its own specific values for the fields defined inside the `struct`. Let's instantiate two instances, one for Julia and one for Python:

```julia (editor=true, logging=false, output=true)
julia = Language("Julia", "Rapidus", 2012, true)
python = Language("Python", "Letargicus", 1991, false)
```
One thing to note with `struct`s is that we can't change their values once they are instantiated. We can solve this with a `mutable struct`. Also, note that mutable objects will, generally, be slower and more error prone. Whenever possible, make everything *immutable*. Let's create a `mutable struct`.

```julia (editor=true, logging=false, output=true)
mutable struct MutableLanguage
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end

julia_mutable = MutableLanguage("Julia", "Rapidus", 2012, true)
```
Suppose that we want to change `julia_mutable`'s title. Now, we can do this since `julia_mutable` is an instantiated `mutable struct`:

```julia (editor=true, logging=false, output=true)
julia_mutable.title = "Python Obliteratus"

julia_mutable
```
### Boolean Operators and Numeric Comparisons

Now that we've covered types, we can move to boolean operators and numeric comparison.

We have three boolean operators in Julia:

  * `!`: **NOT**
  * `&&`: **AND**
  * `||`: **OR**

Here are a few examples with some of them:

```julia (editor=true, logging=false, output=true)
!true
```
```julia (editor=true, logging=false, output=true)
(false && true) || (!false)
```
```julia (editor=true, logging=false, output=true)
(6 isa Int64) && (6 isa Real)
```
Regarding numeric comparison, Julia has three major types of comparisons:

1. **Equality**: either something is *equal* or *not equal* another

      * == "equal"
      * != or ≠ "not equal"
2. **Less than**: either something is *less than* or *less than or equal to*

      * <  "less than"
      * <= or ≤ "less than or equal to"
3. **Greater than**: either something is *greater than* or *greater than or equal to*

      * \> "greater than"
      * \>= or ≥ "greater than or equal to"

Here are some examples:

```julia (editor=true, logging=false, output=true)
1 == 1
```
```julia (editor=true, logging=false, output=true)
1 >= 10
```
It evens works between different types:

```julia (editor=true, logging=false, output=true)
1 == 1.0
```
We can also mix and match boolean operators with numeric comparisons:

```julia (editor=true, logging=false, output=true)
(1 != 10) || (3.14 <= 2.71)
```
### Functions {#sec:function}

Now that we already know how to define variables and custom types as `struct`s, let's turn our attention to **functions**. In Julia, a function **maps argument's values to one or more return values**. The basic syntax goes like this:

```julia (editor=true, logging=false, output=true)
function function_name(arg1, arg2)
    result = arg1 + arg2  # do stuff with the arg1 and arg2
    return result
end
```
The function declaration begins with the keyword `function` followed by the function name. Then, inside parentheses `()`, we define the arguments separated by a comma `,`. Inside the function, we specify what we want Julia to do with the parameters that we supplied. All variables that we define inside a function are deleted after the function returns. This is nice because it is like an automatic cleanup. After all the operations in the function body are finished, we instruct Julia to return the final result with the `return` statement. Finally, we let Julia know that the function definition is finished with the `end` keyword.

There is also the compact **assignment form**:

```julia (editor=true, logging=false, output=true)
f_name(arg1, arg2) = arg1 + arg2  # do stuff with the arg1 and arg2
```
It is the **same function** as before but with a different, more compact, form. As a rule of thumb, when your code can fit easily on one line of up to 92 characters, then the compact form is suitable. Otherwise, just use the longer form with the `function` keyword. Let's dive into some examples.

#### Creating new Functions {#sec:function_example}

Let's create a new function that adds numbers together:

```julia (editor=true, logging=false, output=true)
function add_numbers(x, y)
    return x + y
end
```
Now, we can use our `add_numbers` function:

```julia (editor=true, logging=false, output=true)
add_numbers(17, 29)
```
And it works also with floats:

```julia (editor=true, logging=false, output=true)
add_numbers(3.14, 2.72)
```
Also, we can define custom behavior by specifying type declarations. Suppose that we want to have a `round_number` function that behaves differently if its argument is either a `Float64` or `Int64`:

```julia (editor=true, logging=false, output=true)
function round_number(x::Float64)
    return round(x)
end

function round_number(x::Int64)
    return x
end
```
We can see that it is a function with multiple methods:

```julia (editor=true, logging=false, output=true)
methods(round_number)
```
There is one issue: what happens if we want to round a 32-bit float `Float32`? Or a 8-bit integer `Int8`?

If you want something to function on all float and integer types, you can use an **abstract type** as the type signature, such as `AbstractFloat` or `Integer`:

```julia (editor=true, logging=false, output=true)
function round_number(x::AbstractFloat)
    return round(x)
end
```
Now, it works as expected with any float type:

```julia (editor=true, logging=false, output=true)
x_32 = Float32(1.1)
round_number(x_32)
```
> ***NOTE:*** We can inspect types with the `supertypes` and `subtypes` functions.


Let's go back to our `Language` `struct` that we defined above. This is an example of multiple dispatch. We will extend the `Base.show` function that prints the output of instantiated types and `struct`s.

By default, a `struct` has a basic output, which you saw above in the `python` case. We can define a new `Base.show` method to our `Language` type, so that we have some nice printing for our programming languages instances. We want to clearly communicate programming languages' names, titles, and ages in years. The function `Base.show` accepts as arguments a `IO` type named `io` followed by the type you want to define custom behavior:

```julia (editor=true, logging=false, output=true)
Base.show(io::IO, l::Language) = print(
    io, l.name, ", ",
    2021 - l.year_of_birth, " years old, ",
    "has the following titles: ", l.title
)
```
Now, let's see how `python` will output:

```julia (editor=true, logging=false, output=true)
python
```
#### Multiple Return Values {#sec:function_multiple}

A function can, also, return two or more values. See the new function `add_multiply` below:

```julia (editor=true, logging=false, output=true)
function add_multiply(x, y)
    addition = x + y
    multiplication = x * y
    return addition, multiplication
end
```
In that case, we can do two things:

1. We can, analogously as the return values, define two variables to hold the function return values, one for each return value:

    `julia  return_1, return_2 = add_multiply(1, 2)  return_2`
2. Or we can define just one variable to hold the function's return values and access them with either `first` or `last`:

    `julia  all_returns = add_multiply(1, 2)  last(all_returns)`

#### Keyword Arguments {#sec:function*keyword*arguments}

Some functions can accept keyword arguments instead of positional arguments. These arguments are just like regular arguments, except that they are defined after the regular function's arguments and separated by a semicolon `;`. For example, let's define a `logarithm` function that by default uses base $e$ (2.718281828459045) as a keyword argument. Note that, here, we are using the abstract type `Real` so that we cover all types derived from `Integer` and `AbstractFloat`, being both themselves subtypes of `Real`:

```julia (editor=true, logging=false, output=true)
AbstractFloat <: Real && Integer <: Real
```
```julia (editor=true, logging=false, output=true)
function logarithm(x::Real; base::Real=2.7182818284590)
    return log(base, x)
end
```
It works without specifying the `base` argument as we supplied a **default argument value** in the function declaration:

```julia (editor=true, logging=false, output=true)
logarithm(10)
```
And also with the keyword argument `base` different from its default value:

```julia (editor=true, logging=false, output=true)
logarithm(10; base=2)
```
#### Anonymous Functions {#sec:function_anonymous}

Often we don't care about the name of the function and want to quickly make one. What we need are **anonymous functions**. They are used a lot in Julia's data science workflow. For example, when using `DataFrames.jl` (@sec:dataframes) or `Makie.jl` (@sec:DataVisualizationMakie), sometimes we need a temporary function to filter data or format plot labels. That's when we use anonymous functions. They are especially useful when we don't want to create a function, and a simple in-place statement would be enough.

The syntax is simple. We use the `->` operator. On the left of `->` we define the parameter name. And on the right of `->` we define what operations we want to perform on the parameter that we defined on the left of `->`. Here is an example. Suppose that we want to undo the log transformation by using an exponentiation:

```julia (editor=true, logging=false, output=true)
map(x -> 2.7182818284590^x, logarithm(2))
```
Here, we are using the `map` function to conveniently map the anonymous function (first argument) to `logarithm(2)` (the second argument). As a result, we get back the same number, because logarithm and exponentiation are inverse (at least in the base that we've chosen – 2.7182818284590)

### Conditional If-Else-Elseif {#sec:conditionals}

In most programming languages, the user is allowed to control the computer's flow of execution. Depending on the situation, we want the computer to do one thing or another. In Julia we can control the flow of execution with `if`, `elseif`, and `else` keywords. These are known as conditional statements.

The `if` keyword prompts Julia to evaluate an expression and, depending on whether it's `true` or `false`, execute certain portions of code. We can compound several `if` conditions with the `elseif` keyword for complex control flow. Finally, we can define an alternative portion to be executed if anything inside the `if` or `elseif`s is evaluated to `true`. This is the purpose of the `else` keyword. Finally, like all the previous keyword operators that we saw, we must tell Julia when the conditional statement is finished with the `end` keyword.

Here's an example with all the `if`-`elseif`-`else` keywords:

```julia (editor=true, logging=false, output=true)
a = 1
b = 2

if a < b
    "a is less than b"
elseif a > b
    "a is greater than b"
else
    "a is equal to b"
end
```
We can even wrap this in a function called `compare`:

```julia (editor=true, logging=false, output=true)
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
```
### For Loop {#sec:for}

The classical for loop in Julia follows a similar syntax as the conditional statements. You begin with a keyword, in this case `for`. Then, you specify what Julia should "loop" for, i.e., a sequence. Also, like everything else, you must finish with the `end` keyword.

So, to make Julia print every number from 1 to 10, you can use the following for loop:

```julia (editor=true, logging=false, output=true)
for i in 1:10
    println(i)
end
```
### While Loop {#sec:while}

The while loop is a mix of the previous conditional statements and for loops. Here, the loop is executed every time the condition is `true`. The syntax follows the same form as the previous one. We begin with the keyword `while`, followed by a statement that evaluates to `true` or `false`. As usual, you must end with the `end` keyword.

Here's an example:

```julia (editor=true, logging=false, output=true)
n = 0

while n < 3
    global n += 1
end

n
```
As you can see, we have to use the `global` keyword. This is because of **variable scope**. Variables defined inside conditional statements, loops, and functions exist only inside them. This is known as the *scope* of the variable. Here, we had to tell Julia that the `n` inside `while` loop is in the global scope with the `global` keyword.

Finally, we also used the `+=` operator which is a nice shorthand for `n = n + 1`.

## Native Data Structures {#sec:data_structures}

Julia has several native data structures. They are abstractions of data that represent some form of structured data. We will cover the most used ones. They hold homogeneous or heterogeneous data. Since they are collections, they can be *looped* over with the `for` loops.

We will cover `String`, `Tuple`, `NamedTuple`, `UnitRange`, `Arrays`, `Pair`, `Dict`, `Symbol`.

When you stumble across a data structure in Julia, you can find methods that accept it as an argument with the `methodswith` function. In Julia, the distinction between methods and functions is as follows. Every function can have multiple methods like we have shown earlier. The `methodswith` function is nice to have in your bag of tricks. Let's see what we can do with a `String` for example:

```julia (editor=true, logging=false, output=true)
first(methodswith(String), 5)
```
### Broadcasting Operators and Functions {#sec:broadcasting}

Before we dive into data structures, we need to talk about broadcasting (also known as *vectorization*) and the "dot" operator `.`.

We can broadcast mathematical operations like `*` (multiplication) or `+` (addition) using the dot operator. For example, broadcasted addition would imply a change from `+` to `.+`:

```julia (editor=true, logging=false, output=true)
[1, 2, 3] .+ 1
```
It also works automatically with functions. (Technically, the mathematical operations, or infix operators, are also functions, but that is not so important to know.) Remember our `logarithm` function?

```julia (editor=true, logging=false, output=true)
logarithm.([1, 2, 3])
```
### Functions with a bang `!` {#sec:function_bang}

It is a Julia convention to append a bang `!` to names of functions that modify one or more of their arguments. This convention warns the user that the function is **not pure**, i.e., that it has *side effects*. A function with side effects is useful when you want to update a large data structure or variable container without having all the overhead from creating a new instance.

For example, we can create a function that adds 1 to each element in a vector `V`:

```julia (editor=true, logging=false, output=true)
function add_one!(V)
    for i in eachindex(V)
        V[i] += 1
    end
    return nothing
end
```
```julia (editor=true, logging=false, output=true)
my_data = [1, 2, 3]

add_one!(my_data)

my_data
```
### String {#sec:string}

**Strings** are represented delimited by double quotes:

```julia (editor=true, logging=false, output=true)
typeof("This is a string")
```
We can also write a multiline string:

```julia-repl
julia> text = """
    This is a big multiline string.
    As you can see.
    It is still a String to Julia.
    """
```

But it is usually clearer to use triple quotation marks:

```julia-repl
julia> s = """
    This is a big multiline string with a nested "quotation".
    As you can see.
    It is still a String to Julia.
    """
```

When using triple-backticks, the indentation and newline at the start is ignored by Julia. This improves code readability because you can indent the block in your source code without those spaces ending up in your string.

#### String Concatenation {#sec:string_concatenation}

A common string operation is **string concatenation**. Suppose that you want to construct a new string that is the concatenation of two or more strings. This is accomplished in Julia either with the `*` operator or the `join` function. This symbol might sound like a weird choice and it actually is. For now, many Julia codebases are using this symbol, so it will stay in the language. If you're interested, you can read a discussion from 2015 about it at [https://github.com/JuliaLang/julia/issues/11030](https://github.com/JuliaLang/julia/issues/11030).

```julia-repl
julia> hello = "Hello"
"Hello"

julia> goodbye = "Goodbye"
"Goodbye"

julia> hello * goodbye
"HelloGoodbye"
```

As you can see, we are missing a space between `hello` and `goodbye`. We could concatenate an additional `" "` string with the `*`, but that would be cumbersome for more than two strings. That's where the `join` function comes in handy. We just pass as arguments the strings inside the brackets `[]` and the separator:

```julia-repl
julia> join([hello, goodbye], " ")
"Hello Goodbye"
```

#### String Interpolation {#sec:string_interpolation}

Concatenating strings can be convoluted. We can be much more expressive with **string interpolation**. It works like this: you specify whatever you want to be included in your string with the dollar sign `$`. Here's the example before but now using interpolation:

```julia (editor=true, logging=false, output=true)
"$hello $goodbye"
```
It even works inside functions. Let's revisit our `test` function from @sec:conditionals:

```julia (editor=true, logging=false, output=true)
function test_interpolated(a, b)
    if a < b
        "$a is less than $b"
    elseif a > b
        "$a is greater than $b"
    else
        "$a is equal to $b"
    end
end

test_interpolated(3.14, 3.14)
```
#### String Manipulations {#sec:string_manipulations}

There are several functions to manipulate strings in Julia. We will demonstrate the most common ones. Also, note that most of these functions accept a [Regular Expression (regex)](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions) as arguments. We won't cover Regular Expressions in this book, but you are encouraged to learn about them, especially if most of your work uses textual data.

First, let us define a string for us to play around with:

```julia (editor=true, logging=false, output=true)
julia_string = "Julia is an amazing open source programming language"
```
1. `contains`, `startswith` and `endswith`: A conditional (returns either `true` or `false`) if the second argument is a:

      * **substring** of the first argument

        ```julia (editor=true, logging=false, output=true)
        contains(julia_string, "Julia")
        ```
      * **prefix** of the first argument

        ```julia (editor=true, logging=false, output=true)
        startswith(julia_string, "Julia")
        ```
      * **suffix** of the first argument

        ```julia (editor=true, logging=false, output=true)
        endswith(julia_string, "language")
        ```
2. `lowercase`, `uppercase`, `titlecase` and `lowercasefirst`:

    `julia (editor=true, logging=false, output=true)  lowercase(julia_string)`

    `julia (editor=true, logging=false, output=true)  uppercase(julia_string)`

    `julia (editor=true, logging=false, output=true)  titlecase(julia_string)`

    `julia (editor=true, logging=false, output=true)  lowercasefirst(julia_string)`
3. `replace`: introduces a new syntax, called the `Pair`

    `julia (editor=true, logging=false, output=true)  replace(julia_string, "amazing" => "awesome")`
4. `split`: breaks up a string by a delimiter:

    `julia (editor=true, logging=false, output=true)  split(julia_string, " ")`

#### String Conversions {#sec:string_conversions}

Often, we need to **convert** between types in Julia. To convert a number to a string we can use the `string` function:

```julia (editor=true, logging=false, output=true)
my_number = 123
typeof(string(my_number))
```
Sometimes, we want the opposite: convert a string to a number. Julia has a handy function for that: `parse`.

```julia (editor=true, logging=false, output=true)
typeof(parse(Int64, "123"))
```
Sometimes, we want to play safe with these conversions. That's when `tryparse` function steps in. It has the same functionality as `parse` but returns either a value of the requested type, or `nothing`. That makes `tryparse` handy when we want to avoid errors. Of course, you would need to deal with all those `nothing` values afterwards.

```julia-repl
julia> tryparse(Int64, "A very non-numeric string")
nothing
```

### Tuple {#sec:tuple}

Julia has a data structure called **tuple**. They are really *special* in Julia because they are often used in relation to functions. Since functions are an important feature in Julia, every Julia user should know the basics of tuples.

A tuple is a **fixed-length container that can hold multiple different types**. A tuple is an **immutable object**, meaning that it cannot be modified after instantiation. To construct a tuple, use parentheses `()` to delimit the beginning and end, along with commas `,` as delimiters between values:

```julia (editor=true, logging=false, output=true)
my_tuple = (1, 3.14, "Julia")
```
Here, we are creating a tuple with three values. Each one of the values is a different type. We can access them via indexing. Like this:

```julia (editor=true, logging=false, output=true)
my_tuple[2]
```
We can also loop over tuples with the `for` keyword. And even apply functions to tuples. But we can **never change any value of a tuple** since they are **immutable**.

Remember functions that return multiple values back in @sec:function*multiple? Let's inspect what our `add*multiply` function returns:

```julia (editor=true, logging=false, output=true)
return_multiple = add_multiply(1, 2)
typeof(return_multiple)
```
This is because `return a, b` is the same as `return (a, b)`:

```julia (editor=true, logging=false, output=true)
1, 2
```
So, now you can see why they are often related.

One more thing about tuples. **When you want to pass more than one variable to an anonymous function, guess what you would need to use? Once again: tuples!**

```julia (editor=true, logging=false, output=true)
map((x, y) -> x^y, 2, 3)
```
Or, even more than two arguments:

```julia (editor=true, logging=false, output=true)
map((x, y, z) -> x^y + z, 2, 3, 1)
```
### Named Tuple {#sec:namedtuple}

Sometimes, you want to name the values in tuples. That's when **named tuples** comes in. Their functionality is pretty much same as tuples: they are **immutable** and can hold **any type of value**.

The construction of named tuples is slightly different from that of tuples. You have the familiar parentheses `()` and the comma `,` value separator. But now you **name the values**:

```julia (editor=true, logging=false, output=true)
my_namedtuple = (i=1, f=3.14, s="Julia")
```
We can access named tuple's values via indexing like regular tuples or, alternatively, **access by their names** with the `.`:

```julia (editor=true, logging=false, output=true)
my_namedtuple.s
```
To finish our discussion of named tuples, there is one important *quick* syntax that you'll see a lot in Julia code. Often Julia users create a named tuple by using the familiar parenthesis `()` and commas `,`, but without naming the values. To do so you **begin the named tuple construction by specifying first a semicolon `;` before the values**. This is especially useful when the values that would compose the named tuple are already defined in variables or when you want to avoid long lines:

```julia (editor=true, logging=false, output=true)
i = 1
f = 3.14
s = "Julia"

my_quick_namedtuple = (; i, f, s)
```
### Ranges {#sec:ranges}

A **range** in Julia represents an interval between start and stop boundaries. The syntax is `start:stop`:

```julia (editor=true, logging=false, output=true)
1:10
```
As you can see, our instantiated range is of type `UnitRange{T}` where `T` is the type inside the `UnitRange`:

```julia (editor=true, logging=false, output=true)
typeof(1:10)
```
And, if we gather all the values, we get:

```julia (editor=true, logging=false, output=true)
[x for x in 1:10]
```
We can also construct ranges for other types:

```julia (editor=true, logging=false, output=true)
typeof(1.0:10.0)
```
Sometimes, we want to change the default interval step size behavior. We can do that by adding a step size in the range syntax `start:step:stop`. For example, suppose we want a range of `Float64` from 0 to 1 with steps of size 0.2:

```julia (editor=true, logging=false, output=true)
0.0:0.2:1.0
```
If you want to "materialize" a range into a collection, you can use the function `collect`:

```julia (editor=true, logging=false, output=true)
collect(1:10)
```
We have an array of the type specified in the range between the boundaries that we've set. Speaking of arrays, let's talk about them.

### Array {#sec:array}

In its most basic form, **array**s hold multiple objects. For example, they can hold multiple numbers in one-dimension:

```julia (editor=true, logging=false, output=true)
myarray = [1, 2, 3]
```
Most of the time you would want **arrays of a single type for performance issues**, but note that they can also hold objects of different types:

```julia (editor=true, logging=false, output=true)
myarray = ["text", 1, :symbol]
```
They are the "bread and butter" of data scientist, because arrays are what underlies most of **data manipulation** and **data visualization** workflows.

Therefore, **Arrays are an essential data structure**.

#### Array Types {#sec:array_types}

Let's start with **array types**. There are several, but we will focus on the two most used in data science:

  * `Vector{T}`: **one-dimensional** array. Alias for `Array{T, 1}`.
  * `Matrix{T}`: **two-dimensional** array. Alias for `Array{T, 2}`.

Note here that `T` is the type of the underlying array. So, for example, `Vector{Int64}` is a `Vector` in which all elements are `Int64`s, and `Matrix{AbstractFloat}` is a `Matrix` in which all elements are subtypes of `AbstractFloat`.

Most of the time, especially when dealing with tabular data, we are using either one- or two-dimensional arrays. They are both `Array` types for Julia. But, we can use the handy aliases `Vector` and `Matrix` for clear and concise syntax.

#### Array Construction {#sec:array_construction}

How do we **construct** an array? In this section, we start by constructing arrays in a low-level way. This can be necessary to write high performing code in some situations. However, in most situations, this is not necessary, and we can safely use more convenient methods to create arrays. These more convenient methods will be described later in this section.

The low-level constructor for Julia arrays is the **default constructor**. It accepts the element type as the type parameter inside the `{}` brackets and inside the constructor you'll pass the element type followed by the desired dimensions. It is common to initialize vector and matrices with undefined elements by using the `undef` argument for type. A vector of 10 `undef` `Float64` elements can be constructed as:

```julia (editor=true, logging=false, output=true)
my_vector = Vector{Float64}(undef, 10)
```
For matrices, since we are dealing with two-dimensional objects, we need to pass two dimension arguments inside the constructor: one for **rows** and another for **columns**. For example, a matrix with 10 rows and 2 columns of `undef` elements can be instantiated as:

```julia (editor=true, logging=false, output=true)
my_matrix = Matrix{Float64}(undef, 10, 2)
```
We also have some **syntax aliases** for the most common elements in array construction:

  * `zeros` for all elements being initialized to zero. Note that the default type is `Float64` which can be changed if necessary:

    ```julia
    my_vector_zeros = zeros(10)
    ```

    ```julia
    my_matrix_zeros = zeros(Int64, 10, 2)
    ```
  * `ones` for all elements being initialized to one:

    ```julia
    my_vector_ones = ones(Int64, 10)
    ```

    ```julia
    my_matrix_ones = ones(10, 2)
    ```

For other elements, we can first instantiate an array with `undef` elements and use the `fill!` function to fill all elements of an array with the desired element. Here's an example with `3.14` ($\pi$):

```julia (editor=true, logging=false, output=true)
my_matrix_π = Matrix{Float64}(undef, 2, 2)
fill!(my_matrix_π, 3.14)
```
We can also create arrays with **array literals**. For example, here's a 2x2 matrix of integers:

```julia (editor=true, logging=false, output=true)
[[1 2]
 [3 4]]
```
Array literals also accept a type specification before the `[]` brackets. So, if we want the same 2x2 array as before but now as floats, we can do so:

```julia (editor=true, logging=false, output=true)
Float64[[1 2]
        [3 4]]
```
It also works for vectors:

```julia (editor=true, logging=false, output=true)
Bool[0, 1, 0, 1]
```
You can even **mix and match** array literals with the constructors:

```julia (editor=true, logging=false, output=true)
[ones(Int, 2, 2) zeros(Int, 2, 2)]
```
```julia (editor=true, logging=false, output=true)
[zeros(Int, 2, 2)
 ones(Int, 2, 2)]
```
```julia (editor=true, logging=false, output=true)
[ones(Int, 2, 2) [1; 2]
 [3 4]            5]
```
Another powerful way to create an array is to write an **array comprehension**. This way of creating arrays is better in most cases: it avoids loops, indexing, and other error-prone operations. You specify what you want to do inside the `[]` brackets. For example, say we want to create a vector of squares from 1 to 10:

```julia (editor=true, logging=false, output=true)
[x^2 for x in 1:10]
```
They also support multiple inputs:

```julia (editor=true, logging=false, output=true)
[x*y for x in 1:10 for y in 1:2]
```
And conditionals:

```julia (editor=true, logging=false, output=true)
[x^2 for x in 1:10 if isodd(x)]
```
As with array literals, you can specify your desired type before the `[]` brackets:

```julia (editor=true, logging=false, output=true)
Float64[x^2 for x in 1:10 if isodd(x)]
```
Finally, we can also create arrays with **concatenation functions**. Concatenation is a standard term in computer programming and means "to chain together". For example, we can concatenate strings with "aa" and "bb" to get "aabb":

```julia (editor=true, logging=false, output=true)
"aa" * "bb"
```
And, we can concatenate arrays to create new arrays:

  * `cat`: concatenate input arrays along a specific dimension `dims`

    `julia    cat(ones(2), zeros(2), dims=1)`

    `julia    cat(ones(2), zeros(2), dims=2)`
  * `vcat`: vertical concatenation, a shorthand for `cat(...; dims=1)`

    `julia    vcat(ones(2), zeros(2))`
  * `hcat`: horizontal concatenation, a shorthand for `cat(...; dims=2)`

    `julia    hcat(ones(2), zeros(2))`

#### Array Inspection {#sec:array_inspection}

Once we have arrays, the next logical step is to **inspect** them. There are a lot of handy functions that allow the user to have an insight into any array.

It is most useful to know what **type of elements** are inside an array. We can do this with `eltype`:

```julia (editor=true, logging=false, output=true)
eltype(my_matrix_π)
```
After knowing its types, one might be interested in **array dimensions**. Julia has several functions to inspect array dimensions:

  * `length`: total number of elements

    `julia    length(my_matrix_π)`
  * `ndims`: number of dimensions

    `julia    ndims(my_matrix_π)`
  * `size`: this one is a little tricky.   By default it will return a tuple containing the array's dimensions.

    `julia    size(my_matrix_π)`

    You can get a specific dimension with a second argument to `size`.   Here, the the second axis is columns

    `julia    size(my_matrix_π, 2)`

#### Array Indexing and Slicing {#sec:array_indexing}

Sometimes, we want to inspect only certain parts of an array. This is called **indexing** and **slicing**. If you want a particular observation of a vector, or a row or column of a matrix, you'll probably need to **index an array**.

First, we will create an example vector and matrix to play around:

```julia (editor=true, logging=false, output=true)
my_example_vector = [1, 2, 3, 4, 5]

my_example_matrix = [[1 2 3]
                     [4 5 6]
                     [7 8 9]]
```
Let's start with vectors. Suppose that you want the second element of a vector. You append `[]` brackets with the desired **index** inside:

```julia (editor=true, logging=false, output=true)
my_example_vector[2]
```
The same syntax follows with matrices. But, since matrices are 2-dimensional arrays, we have to specify *both* rows and columns. Let's retrieve the element from the second row (first dimension) and first column (second dimension):

```julia (editor=true, logging=false, output=true)
my_example_matrix[2, 1]
```
Julia also has conventional keywords for the **first** and **last** elements of an array: `begin` and `end`. For example, the second to last element of a vector can be retrieved as:

```julia (editor=true, logging=false, output=true)
my_example_vector[end-1]
```
This also works for matrices. Let's retrieve the element of the last row and second column:

```julia (editor=true, logging=false, output=true)
my_example_matrix[end, begin+1]
```
Often, we are not only interested in just one array element, but in a whole **subset of array elements**. We can accomplish this by **slicing** an array. It uses the same index syntax, but with the added colon `:` to denote the boundaries that we are slicing through the array. For example, suppose we want to get the 2nd to 4th element of a vector:

```julia (editor=true, logging=false, output=true)
my_example_vector[2:4]
```
We could do the same with matrices. Particularly with matrices if we want to select **all elements** in a following dimension we can do so with just a colon `:`. For example, to get all the elements in the second row:

```julia (editor=true, logging=false, output=true)
my_example_matrix[2, :]
```
You can interpret this with something like "take the 2nd row and all the columns".

It also supports `begin` and `end`:

```julia (editor=true, logging=false, output=true)
my_example_matrix[begin+1:end, end]
```
#### Array Manipulations {#sec:array_manipulation}

There are several ways we could **manipulate** an array. The first would be to manipulate a **singular element of the array**. We just index the array by the desired element and proceed with an assignment `=`:

```julia (editor=true, logging=false, output=true)
my_example_matrix[2, 2] = 42
my_example_matrix
```
Or, you can manipulate a certain **subset of elements of the array**. In this case, we need to slice the array and then assign with `=`:

```julia (editor=true, logging=false, output=true)
my_example_matrix[3, :] = [17, 16, 15]
my_example_matrix
```
Note that we had to assign a vector because our sliced array is of type `Vector`:

```julia (editor=true, logging=false, output=true)
typeof(my_example_matrix[3, :])
```
The second way we could manipulate an array is to **alter its shape**. Suppose that you have a 6-element vector and you want to make it a 3x2 matrix. You can do this with `reshape`, by using the array as the first argument and a tuple of dimensions as the second argument:

```julia (editor=true, logging=false, output=true)
six_vector = [1, 2, 3, 4, 5, 6]
three_two_matrix = reshape(six_vector, (3, 2))
three_two_matrix
```
You can convert it back to a vector by specifying a tuple with only one dimension as the second argument:

```julia (editor=true, logging=false, output=true)
reshape(three_two_matrix, (6, ))
```
The third way we could manipulate an array is to **apply a function over every array element**. This is where the "dot" operator `.`, also known as *broadcasting*, comes in.

```julia (editor=true, logging=false, output=true)
logarithm.(my_example_matrix)
```
The dot operator in Julia is extremely versatile. You can even use it to broadcast infix operators:

```julia (editor=true, logging=false, output=true)
my_example_matrix .+ 100
```
An alternative to broadcasting a function over a vector is to use `map`:

```julia (editor=true, logging=false, output=true)
map(logarithm, my_example_matrix)
```
For anonymous functions, `map` is usually more readable. For example,

```julia (editor=true, logging=false, output=true)
map(x -> 3x, my_example_matrix)
```
is quite clear. However, the same broadcast looks as follows:

```julia (editor=true, logging=false, output=true)
(x -> 3x).(my_example_matrix)
```
Next, `map` works with slicing:

```julia (editor=true, logging=false, output=true)
map(x -> x + 100, my_example_matrix[:, 3])
```
Finally, sometimes, and specially when dealing with tabular data, we want to apply a **function over all elements in a specific array dimension**. This can be done with the `mapslices` function. Similar to `map`, the first argument is the function and the second argument is the array. The only change is that we need to specify the `dims` argument to flag what dimension we want to transform the elements.

For example, let's use `mapslices` with the `sum` function on both rows (`dims=1`) and columns (`dims=2`):

```julia (editor=true, logging=false, output=true)
# rows
mapslices(sum, my_example_matrix; dims=1)
```
```julia (editor=true, logging=false, output=true)
# columns
mapslices(sum, my_example_matrix; dims=2)
```
#### Array Iteration {#sec:array_iteration}

One common operation is to **iterate over an array with a `for` loop**. The **regular `for` loop over an array returns each element**.

The simplest example is with a vector.

```julia (editor=true, logging=false, output=true)
simple_vector = [1, 2, 3]

empty_vector = Int64[]

for i in simple_vector
    push!(empty_vector, i + 1)
end

empty_vector
```
Sometimes, you don't want to loop over each element, but actually over each array index. **We can use the `eachindex` function combined with a `for` loop to iterate over each array index**.

Again, let's show an example with a vector:

```julia (editor=true, logging=false, output=true)
forty_twos = [42, 42, 42]

empty_vector = Int64[]

for i in eachindex(forty_twos)
    push!(empty_vector, i)
end

empty_vector
```
In this example, the `eachindex(forty_twos)` returns the indices of `forty_twos`, namely `[1, 2, 3]`.

Similarly, we can iterate over matrices. The standard `for` loop goes first over columns then over rows. It will first traverse all elements in column 1, from the first row to the last row, then it will move to column 2 in a similar fashion until it has covered all columns.

For those familiar with other programming languages: Julia, like most scientific programming languages, is "column-major". Column-major means that the elements in the column are stored next to each other in memory[^pointers]. This also means that iterating over elements in a column is much quicker than over elements in a row.

[^pointers]: or, that the memory address pointers to the elements in the column are stored next to each other.

Ok, let's show this in an example:

```julia (editor=true, logging=false, output=true)
column_major = [[1 3]
                [2 4]]

row_major = [[1 2]
             [3 4]]
```
If we loop over the vector stored in column-major order, then the output is sorted:

```julia (editor=true, logging=false, output=true)
indexes = Int64[]

for i in column_major
    push!(indexes, i)
end

indexes
```
However, the output isn't sorted when looping over the other matrix:

```julia (editor=true, logging=false, output=true)
indexes = Int64[]

for i in row_major
    push!(indexes, i)
end

indexes
```
It is often better to use specialized functions for these loops:

  * `eachcol`: iterates over an array column first

    `julia    first(eachcol(column_major))`
  * `eachrow`: iterates over an array row first

    `julia    first(eachrow(column_major))`

### Pair {#sec:pair}

Compared to the huge section on arrays, this section on pairs will be brief. **`Pair` is a data structure that holds two objects** (which typically belong to each other). We construct a pair in Julia using the following syntax:

```julia (editor=true, logging=false, output=true)
my_pair = "Julia" => 42
```
The elements are stored in the fields `first` and `second`.

```
julia my_pair.first

```

```

julia my_pair.second

```

But, in most cases, it's easier use `first` and `last`[^easier]:

```

julia first(my_pair)

```

```

julia last(my_pair)

```

[^easier]: it is easier because `first` and `last` also work on many other collections, so you need to remember less.

Pairs will be used a lot in data manipulation and data visualization since both `DataFrames.jl` (@sec:dataframes) or `Makie.jl` (@sec:DataVisualizationMakie) take objects of type `Pair` in their main functions. For example, with `DataFrames.jl` we're going to see that `:a => :b` can be used to rename the column `:a` to `:b`.

### Dict {#sec:dict}

If you understood what a `Pair` is, then `Dict` won't be a problem. For all practical purposes, **`Dict`s are mappings from keys to values**. By mapping, we mean that if you give a `Dict` some key, then the `Dict` can tell you which value belongs to that key. `key`s and `value`s can be of any type, but usually `key`s are strings.

There are two ways to construct `Dict`s in Julia. The first is by passing a vector of tuples as `(key, value)` to the `Dict` constructor:

```julia (editor=true, logging=false, output=true)
# tuples # hide
name2number_map = Dict([("one", 1), ("two", 2)])
```
There is a more readable syntax based on the `Pair` type described above. You can also pass `Pair`s of `key => value`s to the `Dict` constructor:

```julia (editor=true, logging=false, output=true)
# pairs # hide
name2number_map = Dict("one" => 1, "two" => 2)
```
You can retrieve a `Dict`'s `value` by indexing it by the corresponding `key`:

```julia (editor=true, logging=false, output=true)
name2number_map["one"]
```
To add a new entry, you index the `Dict` by the desired `key` and assign a `value` with the assignment `=` operator:

```julia (editor=true, logging=false, output=true)
name2number_map["three"] = 3
```
If you want to check if a `Dict` has a certain `key` you can use `keys` and `in`:

```julia (editor=true, logging=false, output=true)
"two" in keys(name2number_map)
```
To delete a `key` you can use either the `delete!` function:

```julia (editor=true, logging=false, output=true)
delete!(name2number_map, "three")
```
Or, to delete a key while returning its value, you can use `pop!`:

```julia (editor=true, logging=false, output=true)
popped_value = pop!(name2number_map, "two")
```
Now, our `name2number_map` has only one `key`:

```julia (editor=true, logging=false, output=true)
name2number_map
```
`Dict`s are also used for data manipulation by `DataFrames.jl` (@sec:dataframes) and for data visualization by `Makie.jl` (@sec:DataVisualizationMakie). So, it is important to know their basic functionality.

There is another useful way of constructing `Dict`s. Suppose that you have two vectors and you want to construct a `Dict` with one of them as `key`s and the other as `value`s. You can do that with the `zip` function which "glues" together two objects (just like a zipper):

```julia (editor=true, logging=false, output=true)
A = ["one", "two", "three"]
B = [1, 2, 3]

name2number_map = Dict(zip(A, B))
```
For instance, we can now get the number 3 via:

```julia (editor=true, logging=false, output=true)
name2number_map["three"]
```
### Symbol {#sec:symbol}

`Symbol` is actually *not* a data structure. It is a type and behaves a lot like a string. Instead of surrounding the text by quotation marks, a symbol starts with a colon (:) and can contain underscores:

```julia (editor=true, logging=false, output=true)
sym = :some_text
```
We can easily convert a symbol to string and vice versa:

```julia (editor=true, logging=false, output=true)
s = string(sym)
```
```julia (editor=true, logging=false, output=true)
sym = Symbol(s)
```
One simple benefit of symbols is that you have to type one character less, that is, `:some_text` versus `"some text"`. We use `Symbol`s a lot in data manipulations with the `DataFrames.jl` package (@sec:dataframes) and data visualizations with the `Makie.jl` package (@sec:DataVisualizationMakie).

### Splat Operator {#sec:splat}

In Julia we have the "splat" operator `...` which is used in function calls as a **sequence of arguments**. We will occasionally use splatting in some function calls in the **data manipulation** and **data visualization** chapters.

The most intuitive way to learn about splatting is with an example. The `add_elements` function below takes three arguments to be added together:

```julia (editor=true, logging=false, output=true)
add_elements(a, b, c) = a + b + c
```
Now, suppose that we have a collection with three elements. The naïve way to this would be to supply the function with all three elements as function arguments like this:

```julia (editor=true, logging=false, output=true)
my_collection = [1, 2, 3]
add_elements(my_collection[1], my_collection[2], my_collection[3])
```
Here is where we use the "splat" operator `...` which takes a collection (often an array, vector, tuple, or range) and converts it into a sequence of arguments:

```julia (editor=true, logging=false, output=true)
add_elements(my_collection...)
```
The `...` is included after the collection that we want to "splat" into a sequence of arguments. In the example above, the following are the same:

```julia (editor=true, logging=false, output=true)
add_elements(my_collection...) == add_elements(my_collection[1], my_collection[2], my_collection[3])
```
Anytime Julia sees a splatting operator inside a function call, it will be converted on a sequence of arguments for all elements of the collection separated by commas.

It also works for ranges:

```julia (editor=true, logging=false, output=true)
add_elements(1:3...)
```
## Filesystem {#sec:filesystem}

In data science, most projects are undertaken in a collaborative effort. We share code, data, tables, figures and so on. Behind everything, there is the **operating system (OS) filesystem**. In a perfect world, the same program would give the **same** output when running on **different** operating systems. Unfortunately, that is not always the case. One instance of this is the difference between Windows paths, such as `C:\Users\john`, and Linux paths, such as `/home/john`. This is why it is important to discuss **filesystem best practices**.

Julia has native filesystem capabilities that **handle the differences between operating systems**. They are located in the [`Filesystem`](https://docs.julialang.org/en/v1/base/file/) module from the core `Base` Julia library.

Whenever you are dealing with files such as CSV, Excel files or other Julia scripts, make sure that your code **works on different OS filesystems**. This is easily accomplished with the `joinpath`, `@__FILE__` and `pkgdir` functions.

If you write your code in a package, you can use `pkgdir` to get the root directory of the package. For example, for the Julia Data Science (JDS) package that we use to produce this book, the root directory is:

```

julia root = pkgdir(JDS)

```

As you can see, the code to produce this book was running on a Linux computer. If you're using a script, you can get the location of the script file via

```

julia root = dirname(@**FILE**)

```

The nice thing about these two commands is that they are independent of how the user started Julia. In other words, it doesn't matter whether the user started the program with `julia scripts/script.jl` or `julia script.jl`, in both cases the paths are the same.

The next step would be to include the relative path from `root` to our desired file. Since different OS have different ways to construct relative paths with subfolders (some use forward slashes `/` while other might use backslashes `\`), we cannot simply concatenate the  file's relative path with the `root` string. For that, we have the `joinpath` function, which will join different relative paths and filenames according to your specific OS filesystem implementation.

Suppose that you have a script named `my_script.jl` inside your project's directory. You can have a robust representation of the filepath to `my_script.jl` as:

```

julia> joinpath(root, "my*script.jl") "/path/to/project/my*script.jl"

```

`joinpath` also handles **subfolders**. Let's now imagine a common situation where you have a folder named `data/` in your project's directory. Inside this folder there is a CSV file named `my_data.csv`. You can have the same robust representation of the filepath to `my_data.csv` as:

```

julia (editor=true, logging=false, output=true) joinpath(root, "data", "my_data.csv")

```

It's a good habit to pick up, because it's very likely to save problems for you or other people later.

## Julia Standard Library {#sec:standardlibrary}

Julia has a **rich standard library** that is available with *every* Julia installation. Contrary to everything that we have seen so far, e.g. types, data structures and filesystem; you **must load standard library modules into your environment** to use a particular module or function.

This is done via `using` or `import`. In this book, we will load code via `using`:

```

julia using ModuleName

```

After doing this, you can access all functions and types inside `ModuleName`.

### Dates {#sec:dates}

Knowing how to handle dates and timestamps is important in data science. As we said in *Why Julia?* (@sec:why_julia) section, Python's `pandas` uses its own `datetime` type to handle dates. The same is true in the R tidyverse's `lubridate` package, which also defines its own `datetime` type to handle dates. In Julia packages don't need to write their own dates logic, because Julia has a dates module in its standard library called `Dates`.

To begin, let's load the `Dates` module:

```

julia using Dates

```

#### `Date` and `DateTime` Types {#sec:dates_types}

The `Dates` standard library module has **two types for working with dates**:

1. `Date`: representing time in days and
2. `DateTime`: representing time in millisecond precision.

We can construct `Date` and `DateTime` with the default constructor either by specifying an integer to represent year, month, day, hours and so on:

```

julia """ Date(1987) # year """ )

```

```

julia """ Date(1987, 9) # year, month """ )

```

```

julia """ Date(1987, 9, 13) # year, month, day """ )

```

```

julia """ DateTime(1987, 9, 13, 21) # year, month, day, hour """ )

```

```

julia """ DateTime(1987, 9, 13, 21, 21) # year, month, day, hour, minute """ )

```

For the curious, September 13th 1987, 21:21 is the official time of birth of the first author, Jose.

We can also pass `Period` types to the default constructor. **`Period` types are the human-equivalent representation of time** for the computer. Julia's `Dates` have the following `Period` abstract subtypes:

```

julia subtypes(Period)

```

which divide into the following concrete types, and they are pretty much self-explanatory:

```

julia subtypes(DatePeriod)

```

```

julia subtypes(TimePeriod)

```

So, we could alternatively construct Jose's official time of birth as:

```

julia DateTime(Year(1987), Month(9), Day(13), Hour(21), Minute(21))

```

#### Parsing Dates {#sec:dates_parsing}

Most of the time, we won't be constructing `Date` or `DateTime` instances from scratch. Actually, we will probably be **parsing strings as `Date` or `DateTime` types**.

The `Date` and `DateTime` constructors can be fed a string and a format string. For example, the string `"19870913"` representing September 13th 1987 can be parsed with:

```

julia> Date("19870913", "yyyymmdd") 1987-09-13

```

Notice that the second argument is a string representation of the format. We have the first four digits representing year `y`, followed by two digits for month `m` and finally two digits for day `d`.

It also works for timestamps with `DateTime`:

```

julia (editor=true, logging=false, output=true) DateTime("1987-09-13T21:21:00", "yyyy-mm-ddTHH:MM:SS")

```

You can find more on how to specify different date formats in the [Julia `Dates`' documentation](https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateFormat). Don't worry if you have to revisit it all the time, we ourselves do that too when working with dates and timestamps.

According to [Julia `Dates`' documentation](https://docs.julialang.org/en/v1/stdlib/Dates/#Constructors), using the `Date(date_string, format_string)` method is fine if it's only called a few times. If there are many similarly formatted date strings to parse, however, it is much more efficient to first create a `DateFormat` type, and then pass it instead of a raw format string. Then, our previous example becomes:

```

julia format = DateFormat("yyyymmddDate("19870913", format)

```

Alternatively, without loss of performance, you can use the string literal prefix `dateformat"..."`:

```

julia> Date("19870913", dateformat"yyyymmdd") 1987-09-13

```

#### Extracting Date Information {#sec:dates_information}

It is easy to **extract desired information from `Date` and `DateTime` objects**. First, let's create an instance of a very special date:

```

julia (editor=true, logging=false, output=true) my_birthday = Date("1987-09-13")

```

We can extract anything we want from `my_birthday`:

```

julia year(my_birthday)

```

```

julia month(my_birthday)

```

```

julia day(my_birthday)

```

Julia's `Dates` module also has **compound functions that return a tuple of values**:

```

julia yearmonth(my_birthday)

```

```

julia monthday(my_birthday)

```

```

julia yearmonthday(my_birthday)

```

We can also see the day of the week and other handy stuff:

```

julia dayofweek(my_birthday)

```

```

julia dayname(my_birthday)

```

```

julia dayofweekofmonth(my_birthday)

```

Yep, Jose was born on the second Sunday of September.

> ***NOTE:*** Here's a handy tip to just recover weekdays from `Dates` instances. Just use a `filter` on `dayofweek(your_date) <= 5`. For business day you can checkout the [`BusinessDays.jl`](https://github.com/JuliaFinance/BusinessDays.jl) package.


#### Date Operations {#sec:dates_operations}

We can perform **operations** in `Dates` instances. For example, we can add days to a `Date` or `DateTime` instance. Notice that Julia's `Dates` will automatically perform the adjustments necessary for leap years, and for months with 30 or 31 days (this is known as *calendrical* arithmetic).

```

julia my_birthday + Day(90)

```

We can add as many as we like:

```

julia my_birthday + Day(90) + Month(2) + Year(1)

```

In case you're ever wondering: "What can I do with dates again? What is available?", then you can use `methodswith` to check it out. We show only the first 20 results here:

```

julia first(methodswith(Date), 20)

```

From this, we can conclude that we can also use the plus `+` and minus `-` operator. Let's see how old Jose is, in days:

```

julia today() - my_birthday

```

The **default duration** of `Date` types is a `Day` instance. For the `DateTime`, the default duration is `Millisecond` instance:

```

julia DateTime(today()) - DateTime(my_birthday)

```

#### Date Intervals {#sec:dates_intervals}

One nice thing about `Dates` module is that we can also easily construct **date and time intervals**. Julia is clever enough to not have to define the whole interval types and operations that we covered in @sec:ranges. It just extends the functions and operations defined for range to `Date`'s types. This is known as multiple dispatch and we already covered this in *Why Julia?* (@sec:why_julia).

For example, suppose that you want to create a `Day` interval. This is easy done with the colon `:` operator:

```

julia> Date("2021-01-01"):Day(1):Date("2021-01-07") 2021-01-01:1 day:2021-01-07

```

There is nothing special in using `Day(1)` as the interval, we can **use whatever `Period` type** as interval. For example, using 3 days as the interval:

```

julia (editor=true, logging=false, output=true) Date("2021-01-01"):Day(3):Date("2021-01-07")

```

Or even months:

```

julia> Date("2021-01-01"):Month(1):Date("2021-03-01") 2021-01-01:1 month:2021-03-01

```

Note that the **type of this interval is a `StepRange` with the `Date` and concrete `Period` type** we used as interval inside the colon `:` operator:

```

julia (editor=true, logging=false, output=true) date*interval = Date("2021-01-01"):Month(1):Date("2021-03-01typeof(date*interval)

```

We can convert this to a **vector** with the `collect` function:

```

julia (editor=true, logging=false, output=true) collected*date*interval = collect(date_interval)

```

And have all the **array functionalities available**, like, for example, indexing:

```

julia (editor=true, logging=false, output=true) collected*date*interval[end]

```

We can also **broadcast date operations** to our vector of `Date`s:

```

julia (editor=true, logging=false, output=true) collected*date*interval .+ Day(10)

```

Similarly, these examples work for `DateTime` types too.

### Random Numbers {#sec:random}

Another important module in Julia's standard library is the `Random` module. This module deals with **random number generation**. `Random` is a rich library and, if you're interested, you should consult [Julia's `Random` documentation](https://docs.julialang.org/en/v1/stdlib/Random/). We will cover *only* three functions: `rand`, `randn` and `seed!`.

To begin, we first load the `Random` module. Since we know exactly what we want to load, we can just as well do that explicitly:

```

julia (editor=true, logging=false, output=true) using Random: seed!

```

We have **two main functions that generate random numbers**:

  * `rand`: samples a **random element** of a data structure or type.
  * `randn`: samples a random number from a **standard normal distribution** (mean 0 and standard deviation 1).

#### `rand` {#sec:random_rand}

By default, if you call `rand` without arguments it will return a `Float64` in the interval $[0, 1)$, which means between 0 inclusive to 1 exclusive:

```

julia (editor=true, logging=false, output=true) rand()

```

You can modify `rand` arguments in several ways. For example, suppose you want more than 1 random number:

```

julia (editor=true, logging=false, output=true) rand(3)

```

Or, you want a different interval:

```

julia (editor=true, logging=false, output=true) rand(1.0:10.0)

```

You can also specify a different step size inside the interval and a different type. Here we are using numbers without the dot `.` so Julia will interpret them as `Int64` and not as `Float64`:

```

julia (editor=true, logging=false, output=true) rand(2:2:20)

```

You can also mix and match arguments:

```

julia (editor=true, logging=false, output=true) rand(2:2:20, 3)

```

It also supports a collection of elements as a tuple:

```

julia (editor=true, logging=false, output=true) rand((42, "Julia", 3.14))

```

And also arrays:

```

julia rand([1, 2, 3])

```

`Dict`s:

```

julia rand(Dict(:one => 1, :two => 2))

```

For all the `rand` arguments options, you can specify the desired random number dimensions in a tuple. If you do this, the returned type will be an array. For example, here's a 2x2 matrix of `Float64` numbers between 1.0 and 3.0:

```

julia rand(1.0:3.0, (2, 2))

```

#### `randn` {#sec:random_randn}

`randn` follows the same general principle from `rand` but now it only returns numbers generated from the **standard normal distribution**. The standard normal distribution is the normal distribution with mean 0 and standard deviation 1. The default type is `Float64` and it only allows for subtypes of `AbstractFloat` or `Complex`:

```

julia randn()

```

We can only specify the size:

```

julia randn((2, 2))

```

#### `seed!` {#sec:random_seed}

To finish off the `Random` overview, let's talk about **reproducibility**. Often, we want to make something **replicable**. Meaning that, we want the random number generator to generate the **same random sequence of numbers**. We can do so with the `seed!` function:

```

julia

# comment to distinguish this block from the next # hide

seed!(123) rand(3)

```

```

julia seed!(123) rand(3)

```

In some cases, calling `seed!` at the beginning of your script is not good enough. To avoid `rand` or `randn` to depend on a global variable, we can instead define an instance of a `seed!` and pass it as a first argument of **either `rand` or `randn`**.

```

julia my_seed = seed!(123)

```

```

julia

# some comment to distinguish this block from the next # hide

rand(my_seed, 3)```

```

julia (editor=true, logging=false, output=true) rand(my_seed, 3)

```
> ***NOTE:*** Note that these numbers might differ for different Julia versions. To have stable streams across Julia versions use the `StableRNGs.jl` package.


### Downloads {#sec:downloads}

We'll also cover the standard library's **`Downloads` module**. It will be really brief because we will only be covering a single function named `download`.

Suppose you want to **download a file from the internet to your local storage**. You can accomplish this with the `download` function. The first and only required argument is the file's url. You can also specify as a second argument the desired output path for the downloaded file (don't forget the filesystem best practices!). If you don't specify a second argument, Julia will, by default, create a temporary file with the `tempfile` function.

Let's load the `Downloads` module:

```

julia (editor=true, logging=false, output=true) using Downloads

```
For example, let's download our [`JuliaDataScience` GitHub repository](https://github.com/JuliaDataScience/JuliaDataScience) `Project.toml` file. Note that `download` function is not exported by `Downloads` module, so we have to use the `Module.function` syntax. By default, it returns a string that holds the file path for the downloaded file:

```

julia (editor=true, logging=false, output=true) url = "https://raw.githubusercontent.com/JuliaDataScience/JuliaDataScience/main/Project.toml"

my_file = Downloads.download(url) # tempfile() being created

```
With `readlines`, we can look at the first 4 lines of our downloaded file:

```

julia (editor=true, logging=false, output=true) readlines(my_file)[1:4]

```
> ***NOTE:*** For more complex HTTP interactions such as interacting with web APIs, see the [`HTTP.jl` package](https://github.com/JuliaWeb/HTTP.jl).


### Project Management {#sec:project_management}

One last thing from Julia's standard library for us to cover is the **`Pkg` module**. As described in @sec:programmers, Julia offers a **built-in package manager**, with dependencies and version control tightly controlled, manageable, and replicable.

Unlike traditional package managers, which install and manage a single global set of packages, Julia's package manager is designed around "environments": independent sets of packages that can be local to an individual project or shared between projects. Each project maintains its own independent set of package versions.

#### `Project.toml` and `Manifest.toml` {#sec:project*management*toml}

Inside every project environment there is a simple setup involving [`.toml`](https://toml.io) files in a folder. The folder, in this context, can be perceived as a "project" folder. The project environment is derived on two `.toml` files:

  * **`Project.toml`**: *higher*-level description of the project environment with the top-level package list.
  * **`Manifest.toml`**: *lower*-level description of the project environment with the full dependencies list and their versions.

This file is machine-generated, which means that users are not encouraged to edit it.

#### Creating Project Environments {#sec:project*management*creating}

In order to create a new project environment, you can **enter the `Pkg` REPL mode by typing `]` (right-bracket) in the Julia REPL**:

```

julia-repl julia>]

```

Then it becomes the **`Pkg` REPL mode**:

```

julia-repl (@v1.8) pkg>

```

Here we can see that the REPL prompts changes from `julia>` to `pkg>`. There's also additional information inside the parentheses regarding which project environment is currently active, `(@v1.8)`. The `v1.8` project environment is the default environment for your currently Julia installation (which in our case is Julia version `1.8.X`).

> ***NOTE:*** You can see a list of available commands in the `Pkg` REPL mode with the **`help` command**.


Julia has separate default environments for each minor release, the `X`s in the `1.X` Julia version. Anything that we perform in this default environment will impact any fresh Julia session on that version. Hence, we need to create a new environment by using the **`activate` command**:

```

julia-repl (@v1.8) pkg> activate .   Activating project at `~/user/folder`

(folder) pkg>

```

This activates a project environment in the directory that your Julia REPL is running. In my case this is located at `~/user/folder`. Now we can start adding packages to our project environment with the **`add` command** in the `Pkg` REPL mode:

```

julia-repl (folder) pkg> add DataFrames     Updating registry at `~/.julia/registries/General.toml`    Resolving package versions...     Updating `~/user/folder/Project.toml`   [a93c6f00] + DataFrames v1.4.3     Updating `~/user/folder/Manifest.toml`   [34da2185] + Compat v4.4.0   [a8cc5b0e] + Crayons v4.1.1   [9a962f9c] + DataAPI v1.13.0   [a93c6f00] + DataFrames v1.4.3   [864edb3b] + DataStructures v0.18.13   [e2d170a0] + DataValueInterfaces v1.0.0   [59287772] + Formatting v0.4.2   [41ab1584] + InvertedIndices v1.1.0   [82899510] + IteratorInterfaceExtensions v1.0.0   [b964fa9f] + LaTeXStrings v1.3.0   [e1d29d7a] + Missings v1.0.2   [bac558e1] + OrderedCollections v1.4.1   [2dfb63ee] + PooledArrays v1.4.2   [08abe8d2] + PrettyTables v2.2.1   [189a3867] + Reexport v1.2.2   [66db9d55] + SnoopPrecompile v1.0.1   [a2af1166] + SortingAlgorithms v1.1.0   [892a3eda] + StringManipulation v0.3.0   [3783bdb8] + TableTraits v1.0.1   [bd369af6] + Tables v1.10.0   [56f22d72] + Artifacts   [2a0f44e3] + Base64   [ade2ca70] + Dates   [9fa8497b] + Future   [b77e0a4c] + InteractiveUtils   [8f399da3] + Libdl   [37e2e46d] + LinearAlgebra   [56ddb016] + Logging   [d6f4376e] + Markdown   [de0858da] + Printf   [3fa0cd96] + REPL   [9a3f8284] + Random   [ea8e919c] + SHA v0.7.0   [9e88b42a] + Serialization   [6462fe0b] + Sockets   [2f01184e] + SparseArrays   [10745b16] + Statistics   [8dfed614] + Test   [cf7118a7] + UUIDs   [4ec0a83e] + Unicode   [e66e0078] + CompilerSupportLibraries*jll v0.5.2+0   [4536629a] + OpenBLAS*jll v0.3.20+0   [8e850b90] + libblastrampoline_jll v5.1.1+0

```

From the `add` output, we can see that Julia automatically creates *both* the `Project.toml` and `Manifest.toml` files. In the `Project.toml`, it adds a new package to the project environment package list. Here are the contents of the `Project.toml`:

```

toml [deps] DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"

```

This is a `.toml` file where:

  * `[deps]`: a TOML table (also know as *hash tables* or *dictionaries*)
  * `DataFrames`: a key in the TOML `deps` table; this is the name of the package
  * `"a93c6f00-e57d-5684-b7b6-d8193f3e46c0"`: the value for the `DataFrames` key; this is the [universally unique identifier (UUID)](https://en.wikipedia.org/wiki/Universally_unique_identifier) of the package.

Let's also take a peek into the `Manifest.toml`. Here we will truncate the output since it is a big machine-generated file:

```

toml

# This file is machine-generated - editing it directly is not advised

julia*version = "1.8.3" manifest*format = "2.0" project_hash = "376d427149ea94494cc22001edd58d53c9b2bee1"

[[deps.Artifacts]] uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

...

[[deps.DataFrames]] deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"] git-tree-sha1 = "0f44494fe4271cc966ac4fea524111bef63ba86c" uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0" version = "1.4.3"

...

[[deps.libblastrampoline*jll]] deps = ["Artifacts", "Libdl", "OpenBLAS*jll"] uuid = "8e850b90-86db-534c-a0d3-1478176c7d93" version = "5.1.1+0"

```

The three dots above (`...`) represents truncated output. First, the `Manifest.toml` presents us a comment saying that it is machine-generated and discouragin editing it directly. Then, there are entries for the Julia version (`julia_version`), `Manifest.toml` format version (`manifest_format`), and project environment hash (`project_hash`). Finally, it proceeds with a TOML array of tables which are the double brackets entries (`[[...]]`). These entries stands for the dependencies of all packages necessary to create the environment described in the `Project.toml`. Therefore all of the `DataFrames.jl`'s dependencies and its dependencies' dependencies (and so on...) are listed here with their name, UUID, and version.

> ***NOTE:*** Julia's standard library module do not have a `version` key in the `Manifest.toml` because they are already specified by the Julia version (`julia_version`). This is the case for the `Artifacts` entry in the truncated `Manifest.toml` output above, since it is a module in Julia's standard library.


We can keep adding as many packages as we like with the `add` command. To remove a package you can use the **`rm` command** in the `Pkg` REPL mode:

```

julia-repl (folder) pkg> rm DataFrames     Updating `~/user/folder/Project.toml`   [a93c6f00] - DataFrames v1.4.3     Updating `~/user/folder/Manifest.toml`   [34da2185] - Compat v4.4.0   [a8cc5b0e] - Crayons v4.1.1   [9a962f9c] - DataAPI v1.13.0   [a93c6f00] - DataFrames v1.4.3   [864edb3b] - DataStructures v0.18.13   [e2d170a0] - DataValueInterfaces v1.0.0   [59287772] - Formatting v0.4.2   [41ab1584] - InvertedIndices v1.1.0   [82899510] - IteratorInterfaceExtensions v1.0.0   [b964fa9f] - LaTeXStrings v1.3.0   [e1d29d7a] - Missings v1.0.2   [bac558e1] - OrderedCollections v1.4.1   [2dfb63ee] - PooledArrays v1.4.2   [08abe8d2] - PrettyTables v2.2.1   [189a3867] - Reexport v1.2.2   [66db9d55] - SnoopPrecompile v1.0.1   [a2af1166] - SortingAlgorithms v1.1.0   [892a3eda] - StringManipulation v0.3.0   [3783bdb8] - TableTraits v1.0.1   [bd369af6] - Tables v1.10.0   [56f22d72] - Artifacts   [2a0f44e3] - Base64   [ade2ca70] - Dates   [9fa8497b] - Future   [b77e0a4c] - InteractiveUtils   [8f399da3] - Libdl   [37e2e46d] - LinearAlgebra   [56ddb016] - Logging   [d6f4376e] - Markdown   [de0858da] - Printf   [3fa0cd96] - REPL   [9a3f8284] - Random   [ea8e919c] - SHA v0.7.0   [9e88b42a] - Serialization   [6462fe0b] - Sockets   [2f01184e] - SparseArrays   [10745b16] - Statistics   [8dfed614] - Test   [cf7118a7] - UUIDs   [4ec0a83e] - Unicode   [e66e0078] - CompilerSupportLibraries*jll v0.5.2+0   [4536629a] - OpenBLAS*jll v0.3.20+0   [8e850b90] - libblastrampoline_jll v5.1.1+0 ```

> ***NOTE:*** Julia's `Pkg` REPL mode supports autocompletion with `<TAB>`. You can, for example, in the above command start typing `rm DataF<TAB>` and it will autocomplete to `rm DataFrames`.


We can see that `rm DataFrames` undoes `add DataFrame` by removing entries in *both* `Project.toml` and `Manifest.toml`.

#### Sharing Project Environments {#sec:project*management*sharing}

Once you have a project environment with *both* the `Project.toml` and `Manifest.toml` files, you can **share** it with any user to have a **perfectly reproducible project environment**.

Now let's cover the other end of the process. Suppose you received a `Project.toml` and a `Manifest.toml` from someone.

How would you proceed to **instantiate a Julia project environment**?

It is a simple process:

1. Put the `Project.toml` and a `Manifest.toml` files into a folder.
2. Open a Julia REPL in that folder and activate it as a project environment with `]activate`.
3. Instantiate the environment with the `]instantiate` command.

That's it! Once the project environment finished downloading and instantiating the dependencies listed in the `Project.toml` and `Manifest.toml` files, you'll have an exact copy of the project environment sent to you.

> ***NOTE:*** You can also add `[compat]` bounds in the `Project.toml` to specify which package versions your project environment is compatible with. This is an advanced-user functionality which we will not cover. Take a look at the [`Pkg.jl` standard library module documentation on compatibility](https://pkgdocs.julialang.org/v1/compatibility/). For people new to Julia, we recommend sharing *both* `Project.toml` and `Manifest.toml` for a fully reproducible environment.


