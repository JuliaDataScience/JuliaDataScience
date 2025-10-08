## Using LaTeXStrings.jl

LaTeX support in `Makie.jl` is also available via `LaTeXStrings.jl`:

```
using LaTeXStrings
```

Simple use cases are shown below (@fig:latex_strings). A basic example includes LaTeX strings for x-y labels and legends:

```julia (editor=true, logging=false, output=true)
LaTeX_Strings()
```
```julia (editor=true, logging=false, output=true)

with_theme(LaTeX_Strings, publication_theme())
label = "latex_strings" # hide
caption = "Plot with LaTeX strings." # hide
link_attributes = "width=60%" # hide
Options(current_figure(); filename=label, caption, label, link_attributes) # hide
```
A more involved example will be one with an equation as `text` and increasing legend numbering for curves in a plot:

```julia (editor=true, logging=false, output=true)
JDS.multiple_lines()
```
Where `latexstring` from `LaTeXStrings.jl` has been used to parse the string. An alternative to this simple case is `L"%$i x"`, which is used in the next example.

But, before that, there is another problem, some lines have repeated colors and that's no good. Adding some markers and line styles usually helps. So, let's do that using [Cycles](https://docs.makie.org/stable/documentation/theming/#cycles) for these types. Setting `covary=true` allows to cycle all elements together:

```julia (editor=true, logging=false, output=true)
JDS.multiple_scatters_and_lines()
```
And voilà. A publication quality plot is here. What more can we ask for? Well, what about different default colors or palettes. In our next section, we will see how to use again [Cycles](https://docs.makie.org/stable/documentation/theming/#cycles) and learn a little bit more about them, plus some additional keywords in order to achieve this.

