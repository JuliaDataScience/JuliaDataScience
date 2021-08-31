# Data Vis with Plots {#sec:datavisPlots}

Data visualization is a vital part of almost any data analysis process.
Here, in this chapter, we will consider several packages that can be used in Julia, namely `Plots.jl`, `StatsPlots.jl`, and `Makie.jl`

- Overview of the JuliaPlots ecosystem

Plots is ....

The default backend is GR.

```
using Plots, LaTeXStrings
```

```jl
@sco JDS.test_plots_layout()
```

## Layouts {#sec:layouts}

- Overview on several ways to do layouts
- the layout argument, also cover the grid
- the `@layout` macro
- specific measures with the Plots.PlotMeasures submodule (additionally a footnote to say that we have it in StatsPlots.PlotMeasures also)
- adding subplots incremententally. Define p1, p2, p3; then do a plot(p1, p2, p3; layout=l)

## Animations {#sec:plots-animations}

Doing an animation with Plots is quite easy.

## Other backends {#sec:backends}

Plotly, PGFPlotsX, PyPlot?
