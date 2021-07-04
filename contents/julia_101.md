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
Specially if you are a beginner into programming and haven't yet become familiar with opensource software documentation.

We'll cover just the basics of Julia.
Since we love analogies, imagine that Julia is a fancy feature-loaded car, such as a brand-new Tesla.
We'll just explain you how to "drive the car, park it and how to navigate in traffic".
If you want to know what all "buttons in the steering wheel and dashboard do", this is not the resource you are looking for.

## Language Syntax {#sec:syntax}

Julia is a **dynamic-typed language**.
This means that you don't need to compile it before you run code, like you would do in C++ or FORTRAN.
The main differences from Julia to other dynamic languages such as R and Python are the following.

First, Julia, contrary to most dynamic-typed languages, **enables the user to specify type declaration**.
You already saw some types declarations in the [*Why Julia?*](why_julia.html) section: they are those double colon `::` that suffixes the variables inside `struct`s and `function`'s calls.
But if you don't want to specify what type are your variables or functions, Julia will gladly deduce it for you.

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
sco(
"""
name = "Julius Scientificus"
age = 9
"""
)
```

Note that the return output of the last statement (`age`) was printed to the console.
Here we are defining two new variables: `name` and `age`.
We can recover its values by typing its name given in the assignment:

```jl
sco(
"""
name
"""
)
```

If you want to define new values for an existing variable, you can repeat the steps in the assignment.
Note that Julia will now override the previous variable's value with the new one.
Supposed Julius' birthday has passed and now he has turned 34:

```jl
sco(
"""
age = 10
"""
)
```

We can do the same with his name, suppose that Julius has earned a new title due to his blazing speed:

```jl
sco(
"""
name = "Julius Scientificus Rapidus"
"""
)
```

We can also do operations on variables such as addition or division.
Let's see how much months of age Julius has by multiplying `age` by 12:

```jl
sco(
"""
age * 12
"""
)
```

We can inspect variables types by using `typeof()` function:

```jl
sco(
"""
typeof(age)
"""
)
```

So age is a `jl typeof(age)`.
The next question the becomes: "What else can I do with `jl typeof(age)`?"
There is a nice handy function `methodswith()` that spits out every function available, along with its signature, for a certain type.
Here I will restrict the output only to the first 5 rows:

```jl
sco(
"""
first(methodswith(Int64), 5)
"""
)
```


### User-defined Types {#sec:struct}

Having variables around without any sort of hierarchy and relationships are not ideal.
In Julia we can define that kind of structured data with a `struct` (also known as composite types).
Inside each `struct` there is an optional set of fields.
They differ from the primitive types (e.g. integer and floats) that are by default defined already inside the core of Julia language.

For example lets create a `struct` to represent scientific opensource programming languages:

```jl
sc(
"""
struct Language
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end
""")
```

To inspect the field names you can use the `fieldnames()` and passing the desired `struct` as an argument:

```jl
sco(
"""
fieldnames(Language)
"""
)
```

To use `struct`s, we must instantiate individual instances (or "objects"), each with its own specific values for the fields defined inside the `struct`.
Let's instantiate two instances, one for Julia and one for Python with the appropriate types as fields inside the `Language()` constructor:

```jl
sco(
"""
julia = Language("Julia", "Scientificus Rapidus", 2012, true)
python = Language("Python", "C/FORTRAN Dependentus Letargicus", 1991, false)
"""
)
```

By default a `struct` has a basic output, which you saw above in the `python` case.
Now, we'll use multiple dispatch to overload the `Base.show()` function, so that we have some nice printing for our programming languages.
We want to clearly communicate programming languages' names, titles and ages in years of old:

```jl
sco(
"""
Base.show(io::IO, l::Language) = print(
    io, l.name, " ",
    2021 - l.year_of_birth, ", years old, ",
    "has the following titles: ", l.title
)

julia
"""
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

One thing to note with `struct`s is that we cannot change their values once they are instantiated.
We can solve this with a `mutable struct`.
Also note that everything in Julia that we impose mutability will take a performance hit.
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

Base.show(io::IO, l::MutableLanguage) = print(
    io, l.name, " ",
    2021 - l.year_of_birth, ", years old, ",
    "has the following titles: ", l.title
)

julia_mutable = MutableLanguage("Julia", "Scientificus Rapidus", 2012, true)
""")
```

Now we can change `julia_mutable`'s title:

```jl
sco(
"""
julia_mutable.title = "Python Obliteratus"

julia_mutable
"""
)
```

### Functions {#sec:function}

Now that we already know how to define variables and custom types as `struct`s, let's ...
If you want something to function on all Float's and Int's you can use an abtract type as type signature.

### For Loop {#sec:for}
### While Loop {#sec:while}
### Conditional If-Else-Elseif {#sec:conditionals}

## Native Data Structures {#sec:data_structures}

```{=comment}
methodswith
```

### Strings {#sec:strings}

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
