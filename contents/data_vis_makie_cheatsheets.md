## Cheat Sheets {#sec:makie_cheat_sheets}

What are all the possible plotting functions available in `Makie.jl`?
To answer this question, a _CHEAT SHEET_ is shown in @fig:cheat_sheet_cairo.
These work especially well with `CairoMakie.jl` backend.

```jl
JDS.cheatsheet_cairomakie()
```

For completeness, in @fig:cheat_sheet_glmakie, we show the corresponding functions _CHEAT SHEET_ for `GLMakie.jl`, which supports mostly 3D plots.
Those will be explained in detail in @sec:glmakie.

```jl
JDS.cheatsheet_glmakie()
```

Now, that we have an idea of all the things we can do, let's go back and continue with the basics.
It's time to learn how to change the general appearance of our plots.