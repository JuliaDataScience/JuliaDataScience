# Julia 101 {#sec:julia_101}

> **_NOTE:_**
> In this chapter we will cover the basic of Julia as a programming language.
> Please note that this is not *strictly necessary* for you to use Julia as a tool of data manipulation and data visualization.
> Having a basic understanding of Julia will definitely make you more *effective* and *efficient* in using Julia.
> However, if you prefer to get started straight away, you can jump to [@sec:dataframes] to learn about tabular data with DataFrames.jl.

## Language Syntax {#sec:syntax}
### Functions {#sec:fun}
### For Loop {#sec:for}
### While Loop {#sec:while}
### Conditional If-Else-Elseif {#sec:conditionals}
### User-defined Types

```jl
sc(
"""
struct Person
    name::AbstractString
    age::Int64
end
""")
```

```jl
sco(
"""
rik = Person("Rik", 27)
""")
```

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
