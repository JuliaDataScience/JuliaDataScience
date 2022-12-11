# AlgebraOfGraphics.jl {#sec:aog}

```jl
s = """
    CairoMakie.activate!() # hide
    plt = data(grades_2020()) * mapping(:name, :grade_2020)
    f = draw(plt) # hide
    draw(plt)
    label = "aog1" # hide
    caption = "AlgebraOfGraphics scatter plot." # hide
    link_attributes = "width=60%" # hide
    Options(f.figure; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```
