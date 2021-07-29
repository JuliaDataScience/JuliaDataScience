# Data Visualisation {#sec:dataVis}

Data visualisation it is a vital part of almost any data analysis process. Here, in this chapter we will consider several libraries that can be used in Julia, namely Plots, Makie and AlbegraOfGraphics specially usefull for tabular data. 

- Overview of the JuliaPlots ecosystem

## Plots.jl {#sec:plots}
Plots is .... 

The default backend is GR. 

```
using Plots

```
### Plots attributes {#sec:attributes}

### Colors and Palettes {#sec:colors}
Sequential, diverging, categorical. 

### Layouts {#sec:layouts}
- Overview on several ways to do layouts
- the layout argument, also cover the grid
- the @layout macro
- specific measures with the Plots.PlotMeasures submodule (additionally a footnote to say that we have it in StatsPlots.PlotMeasures also)
- adding subplots incremententally. Define p1, p2, p3; then do a plot(p1, p2, p3; layout=l)

### Animations {#sec:animations}
Doing an animation with Plots is quite easy. 

### Themes {#sec:themes}

### Other backends {#sec:backends}
Plotly, PGFPlotsX, PyPlot? 

## StatsPlots.jl {#sec:statsplots}
1. A brief intro and show that is is really just "syntactic sugar" for Plots.jl. Also note that works on all plots.jl stuff:

- Backends
- Attributes
- Colours
- Layouts
- Animations
- Themes
2. Works on Types of Distributions and DataFrames, but we will only focus on DataFrames

3. the @df macro and the Symbols (:col1, :col2) instead of other input data (vectors, arrays, tuples etc.)

4. Recipes (I would cover almost all of them, except for andrewsplot MDS plot, Dendograms, QQ-Plot etc., since they are specific for modeling or simulation):

- histogram, histogram2d and ea_histogram
- groupedhist and groupedbar
- boxplot
- dotplot
- violin
- marginalhist, marginalkde and marginalscatter
- corrplot and cornerplot

## Makie.jl {#sec:makie}

[Makie](http://makie.juliaplots.org/stable/index.html#Welcome-to-Makie!) is a high-performance, extendable, and multi-platform plotting ecosystem for the Julia programming language.

Makie is Makie's frontend package that defines all plotting functions. It is reexported by every backend, so you don't have to specifically install or import it. There are three main backends which concretely implement all abstract rendering capabilities defined in Makie. One for non-interactive 2D publication-quality vector graphics, `CairoMakie.jl`. Another for 
interactive 2D and 3D plotting in standalone GLFW.jl windows (also GPU-powered), `GLMakie.jl`. And the third one, a WebGL-based interactive 2D and 3D plotting that runs within browsers, `WGLMakie.jl`. [See Makie's documentation for more](http://makie.juliaplots.org/stable/backends_and_output.html#Backends-and-Output).

In this book we will only show examples for `CairoMakie` and `GLMakie`. 

You can activate any backend by using the appropriate package and calling its `activate!` function, i.e. 

```
using GLMakie
GLMakie.activate!()
```

### CairoMakie.jl {#sec:cairomakie}


```
using CairoMakie
CairoMakie.activate!()
```

```jl
s = """plt = lines(1:10,1:10, figure = (; resolution = (600,400)), 
    axis = (; xlabel = L"x"))
    Options(plt; filename ="Firstplot", caption="First plot", label="firstplot") # hide 
"""
sco(s)
```

A more detail plot can be done passing extra arguments. Also, for plots with more 
than one line is recomended to wrapped things into a function call as follows. 

```jl
@sco JDS.costumPlot()
```

```jl
@sco JDS.costumPlot2()
```

```jl
@sco JDS.areaUnder()
```



```jl
s = """
    p = CairoMakie.scatter(1:10, 1:10, figure = (; resolution = (600,400)))
    Options(p; filename ="test", caption="cap", label="lab")
    """
sco(s)
```

```jl
@sco JDS.makiejl()
```


### Colors and Palettes {#sec:colors}
Sequential, diverging, categorical. 

### Layouts {#sec:layouts}
- Overview on several ways to do layouts and related attributes. 

### Animations {#sec:animations}
Recording an animation with CairoMakie (GLMakie). 

### Themes {#sec:themes}
### GLMakie.jl {#sec:glmakie}


## AlgebraOfGraphics.jl {#sec:algebraofgraphics}


