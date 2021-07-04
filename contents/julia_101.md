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
Julia have several type of variables but what we most use in Data Science are:

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
name = "Julia Scientificus Rapidus"
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

We can inspect variables types by using `typeof()` function:

```{=comment}
Rik: I have no idea why `scob` doesn't work here.
It is overloaded somewhere in the wrong way it seems.
```

```jl
sco("typeof(age)")
```

The next question the becomes: "What else can I do with `jl typeof(age)`?"
There is a nice handy function `methodswith()` that spits out every function available, along with its signature, for a certain type.
Here I will restrict the output only to the first 5 rows:

```{=comment}
Since the type is a Vector, Books converts it to multiple output statements.
In this case, I've enforced to show the output of `Base.show`.
```

```jl
sco(
"""
first(methodswith(Int64), 5)
"""; post=Books.catch_show
)
```

### User-defined Types {#sec:struct}

Having variables around without any sort of hierarchy and relationships are not ideal.
In Julia we can define that kind of structured data with a `struct` (also known as composite types).
Inside each `struct` there is an optional set of fields.
They differ from the primitive types (e.g. integer and floats) that are by default defined already inside the core of Julia language.
Since most `struct`s are user-defined they are known as user-defined types.

For example lets create a `struct` to represent scientific opensource programming languages.
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

To inspect the field names you can use the `fieldnames()` and passing the desired `struct` as an argument:

```jl
sco("fieldnames(Language)")
```

To use `struct`s, we must instantiate individual instances (or "objects"), each with its own specific values for the fields defined inside the `struct`.
Let's instantiate two instances, one for Julia and one for Python with the appropriate types as fields inside the `Language()` constructor:

```jl
scob(
"""
julia = Language("Julia", "Scientificus Rapidus", 2012, true)
python = Language("Python", "C/FORTRAN Dependentus Letargicus", 1991, false)
"""
)
```

One thing to note with `struct`s is that we cannot change their values once they are instantiated.
We can solve this with a `mutable struct`.
Also note that everything in Julia that we impose mutability will take a performance hit.
Whenever possible make everything *immutable*.
Let's create a `mutable struct`.

```jl
scob(
"""
mutable struct MutableLanguage
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end

julia_mutable = MutableLanguage("Julia", "Scientificus Rapidus", 2012, true)
""")
```

Suppose that we want to change `julia_mutable`'s title.
Now we can do this, since `julia_mutable` is an instantiated `mutable struct`:

```jl
scob(
"""
julia_mutable.title = "Python Obliteratus"

julia_mutable
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

Now, we can use our `add_numbers()` function:

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
Suppose we want to have a `round_number()` function that behaves differently if its argument is either a `Float64` or `Int64`:

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
> We can inspect types with the `supertypes()` and `subtypes()` functions.

Let's go back to our `Language` `struct` that we defined above.
This is an example of multiple dispatch.
We will extend the `Base.show()` function that prints the output of instantiated types and `struct`s.

By default a `struct` has a basic output, which you saw above in the `python` case.
We can define `Base.show()` function to our `Language` type, so that we have some nice printing for our programming languages instances.
We want to clearly communicate programming languages' names, titles and ages in years of old.
The function `Base.show()` accepts as arguments a `IO` type named `io` followed by the type you want to define custom behaviour:

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
scob(
"""
python
"""
)
```

#### Multiple Return Values {#sec:function_multiple}

A function can, also, return two or more values.
See the new function `add_multiply()` below:

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
   """
   )
   ```

2. Or we can define just one variable to hold the function return values and access them with either `first()` or `last()`:
   ```jl
   scob(
   """
   all_returns = add_multiply(1, 2)
   last(all_returns)
   """
   )
   ```

#### Optional Arguments {#sec:function_optional_arguments}

### For Loop {#sec:for}
### While Loop {#sec:while}
### Conditional If-Else-Elseif {#sec:conditionals}

## Native Data Structures {#sec:data_structures}

```{=comment}
methodswith
```

### String {#sec:string}

```{=comment}
interpolation, concatenation, contains, replace, lowercase, uppercase, titlecase, lowercasefirst, startswith, endswith, split, string conversion, parse, tryparse

One example per method
```

### Tuple {#sec:tuple}

```{=comment}
the way to get data out of functions
```

### Named Tuple {#sec:namedtuple}
### Array {#sec:array}
### Dict {#sec:dict}

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
