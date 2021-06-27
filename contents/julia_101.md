# Julia 101 {#sec:julia_101}

We should include a nice warning box here saying:

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
### Array {#sec:array}
### Dict {#sec:dict}
### Tuple {#sec:tuple}
### Named Tuple {#sec:namedtuple}

