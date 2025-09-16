## Cheat Sheets {#sec:makie*cheat*sheets}

What are all the possible plotting functions available in `Makie.jl`? To answer this question, a *CHEAT SHEET* is shown in @fig:cheat*sheet*cairo. These work especially well with the `CairoMakie.jl` backend:

```julia (editor=true, logging=false, output=true)
JDS.cheatsheet_cairomakie()
```
For completeness, in @fig:cheat*sheet*glmakie, we show the corresponding functions *CHEAT SHEET* for `GLMakie.jl`, which supports mostly 3D plots. Those will be explained in detail in @sec:glmakie.

```julia (editor=true, logging=false, output=true)
JDS.cheatsheet_glmakie()
```
Now, that we have an idea of all the things we can do, let's go back and continue with the basics. It's time to learn how to change the general appearance of our plots.

