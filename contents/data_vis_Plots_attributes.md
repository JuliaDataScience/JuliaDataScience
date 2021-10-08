## Attributes {#sec:plots_attributes}

Almost everything can be done with attributes, namely by passing extra arguments to `plot`.
But, before diving into that let's input different types of data and see what happens, without any extra arguments. This is related to the earlier warning about being careful with your plots.

```
using Plots, LaTeXStrings, Random
```

```jl
@sco JDS.guess_my_plot()
```

So, be aware of this. And please check out the complete list of [useful tips](https://docs.juliaplots.org/latest/basics/#Useful-Tips) in the official documentation.

Now, let's see how passing extra arguments work in the next example.

```jl
@sco JDS.test_plots_attributes()
```

As you can see there are some special arguments which magically set many related things at once.
