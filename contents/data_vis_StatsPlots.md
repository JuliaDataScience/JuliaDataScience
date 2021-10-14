## StatsPlots.jl {#sec:statsplots}

1. A brief intro and show that is is really just "syntactic sugar" for Plots.jl.
    Also note that works on all Plots.jl stuff:

- Backends
- Attributes
- Colours
- Layouts
- Themes
2. Works on Types of Distributions and DataFrames, but we will only focus on DataFrames

3. the `@df` macro and the Symbols (:col1, :col2) instead of other input data (vectors, arrays, tuples etc.)

4. Recipes (I would cover almost all of them, except for andrewsplot MDS plot, Dendograms, QQ-Plot etc., since they are specific for modeling or simulation):

- histogram, histogram2d and ea_histogram
- groupedhist and groupedbar
- boxplot
- dotplot
- violin
- marginalhist, marginalkde and marginalscatter
- corrplot and cornerplot
