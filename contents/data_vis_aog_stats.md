## Statistical Visualizations {#sec:aog_stats}

`AlgebraOfGraphics.jl` can perform **statistical transformations** as layers with five functions:

  * **`expectation`**: calculates the mean (*expectation*) of the underlying Y-axis column
  * **`frequency`**: computes the frequency (*raw count*) of the underlying X-axis column
  * **`density`**: computes the density (*distribution*) of the underlying X-axis column
  * **`linear`**: computes a linear trend relationship between the underlying X- and Y-axis columns
  * **`smooth`**: computes a smooth relationship between the underlying X- and Y-axis columns

Let's first cover `expectation`:

```julia (editor=true, logging=false, output=true)
# aog_expectation # hide

plt = data(df) *
    mapping(:name, :grade) *
    expectation()
f = draw(plt) # hide
draw(plt)
label = "aog_expectation" # hide
caption = "AlgebraOfGraphics bar plot with expectation." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
Here, `expectation` adds a statistical transformation layer that tells `AlgebraOfGraphics.jl` to compute the mean of the Y-axis values for every unique X-axis values. In our case, it computed the mean of grades for every student. Note that we could safely remove the visual transformation layer (`visual(BarPlot)`) since it is the default visual transformation for `expectation`.

Next, we'll show an example with `frequency`:

```julia (editor=true, logging=false, output=true)
# aog_frequency # hide

plt = data(df) *
    mapping(:name) *
    frequency()
f = draw(plt) # hide
draw(plt)
label = "aog_frequency" # hide
caption = "AlgebraOfGraphics bar plot with frequency." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
Here we are passing just a single positional argument to `mapping` since this is the underlying column that `frequency` will use to calculate the raw count. Note that, as previously, we could also safely remove the visual transformation layer (`visual(BarPlot)`) since it is the default visual transformation for `frequency`.

Now, an example with `density`:

```julia (editor=true, logging=false, output=true)
# aog_density # hide

plt = data(df) *
    mapping(:grade) *
    density()
f = draw(plt) # hide
draw(plt)
label = "aog_density" # hide
caption = "AlgebraOfGraphics bar plot with density estimation." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
Analogous to the previous examples, `density` does not need a visual transformation layer. Additionally, we only need to pass a single continuous variable as the only positional argument inside `mapping`. `density` will compute the distribution density of this variable which we can fuse all the layers together and visualize the plot with `draw`.

For the last two statistical transformations, `linear` and `smooth`, they cannot be used with the `*` operator. This is because `*` fuses two or more layers into a *single* layer. `AlgebraOfGraphics.jl` cannot represent these transformations with a *single* layer. Hence, we need to **superimpose layers with the `+` operator**. First, let's generate some data:

```julia (editor=true, logging=false, output=true)
"""
# aog synthetic data # hide
x = rand(1:5, 100)
y = x + rand(100) .* 2
synthetic_df = DataFrame(; x, y)
first(synthetic_df, 5)
"""; process=without_caption_label
)
```
Let's begin with `linear`:

```julia (editor=true, logging=false, output=true)
# aog_linear # hide

plt = data(synthetic_df) *
    mapping(:x, :y) *
    (visual(Scatter) + linear())
f = draw(plt) # hide
draw(plt)
label = "aog_linear" # hide
caption = "AlgebraOfGraphics scatter plot with linear trend estimation." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
We are using the **distribute property** (@sec:aog) for more efficient code inside our `mapping`, `a  * (b + c) = (a * b) + (a + b)`, where:

  * `a`: the `data` and `mapping` layers fused into a single layer
  * `b`: the `visual` transformation layer
  * `c`: the statistical `linear` transformation layer

`linear` adds a linear trend between the X- and Y-axis mappings with a 95% confidence interval shaded region.

Finally, the same example as before but now replacing `linear` with `smooth`:

```julia (editor=true, logging=false, output=true)
# aog_smooth # hide

plt = data(synthetic_df) *
    mapping(:x, :y) *
    (visual(Scatter) + smooth())
f = draw(plt) # hide
draw(plt)
label = "aog_smooth" # hide
caption = "AlgebraOfGraphics scatter plot with smooth trend estimation." # hide
link_attributes = "width=60%" # hide
Options(f.figure; filename=label, caption, label, link_attributes) # hide
```
`smooth` adds a smooth trend between the X- and Y-axis mappings.

