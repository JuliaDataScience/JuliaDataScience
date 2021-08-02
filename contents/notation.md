## Notation {#sec:notation}

In this book, we try to keep notation as consistent as possible.
This makes reading and writing code easier.
We can define the notation into three parts.

### Julia Style Guide

Firstly, we attempt to stick to the conventions from the [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/).
Most importantly, we write functions not scripts (see also @sec:engineering).
Furthermore, we use naming conventions consistent with Julia `base/`, meaning:

- Use camelcase for modules: `module JuliaDataScience`, `struct MyPoint`.
  (Note that camelcase is called "camelcase", because the capitalization of words, such as "iPad" or "CamelCase", make the word look like a camel.)
- Write function names in lowercase letters and separate the words by underscores.
  It is also allowed to omit the separator when naming functions.
  For example, these function names are all in line with the conventions: `my_function`, `myfunction` and `string2int`.

Also, we avoid brackets in conditionals, that is, we write `if a == b` instead of `if (a == b)` and use 4 spaces per indentation level.

### BlueStyle

The [Blue Style Guide](https://github.com/invenia/BlueStyle) adds multiple conventions on top of the default Julia Style Guide.
Some of these rules might sound pedantic, but we found that they make the code more readable.

From the style guide, we attempt to adhere specifically to:

- At most 92 characters per line in code (in Markdown files, longer lines are allowed).
- With `using`, import at most one module per line
- No trailing whitespace.
  Trailing whitespace makes inspecting changes in code more difficult since they do not change the behavior of the code but do show up as changes.
- Avoid extraneous spaces inside brackets.
  So, write `string(1, 2)` instead of `string( 1 , 2 )`.
- Global variables should be avoided.
- Try to limit function names to one or two words.
- Use the semicolon to clarify whether an argument is a keyword argument or not.
  For example, `func(x; y=3)` instead of `func(x, y=3)`.
- Avoid using multiple spaces to align things.
  So, write
  ```
  a = 1
  lorem = 2
  ```
  instead of
  ```
  a     = 1
  lorem = 2
  ```
- Whenever appropriate, surround binary operators with a space, for exaple, `1 == 2` or `y = x + 1`.
- Indent triple-quotes and triple-backticks:
  ```
  s = """
      my long text:
      [...]
      the end.
      """
  ```
- Do not omit zeros in floats (even though Julia allows it).
  Hence, write `1.0` instead of `1.` and write `0.1` instead of `.1`.
- Use `in` in for loops and not = or ∈ (even though Julia allows it).

### Our additions

- In text, we reference the function call `M.foo(3, 4)` as `M.foo` and not `M.foo(...)` or `M.foo()`.
- When talking about packages, like the DataFrames package, we explicitly write `DataFrames.jl` each time.
  This makes it easier to recognize that we are talking about a package.
- For filenames, we stick to "file.txt" and not `file.txt` or file.txt, because it is consistent with the code.
- For column names in tables, like the column `x`, we stick to column `:x`, because it is consistent with the code.
- Do not use unicode symbols in inline code.
  This is simply a bug in the PDF generation that we have to workaround for now.
