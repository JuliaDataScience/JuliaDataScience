## Linear regression {#sec:ml_linear_regression}

We do linear regression when we look for associations between different quantities.
Usually split into the target variable, i.e. the variable to be predicted(output) and the input features (aka predictor variables). Hence, we need data!

The Palmer penguins dataset is a nice example for data exploration and visualization
which was published as an R package recently (Horst, Hill, & Gorman (2020)). It consists of measurements of penguins from three islands in the Palmer Archipelago, Antarctica.
The data was collected by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER (Gorman, Williams, & Fraser (2014)).

```
using PalmerPenguins
using DataFrames: DataFrame, dropmissing
```

```jl
@sc JDS.getPenguins()
```

```jl
s = """
    penguins = getPenguins()
    names(penguins)
    """
sco(s)
```

the dataset contains at most seven measurements for each penguin, namely the species (`Adelie`, `Chinstrap`, and `Gentoo`), the island (`Torgersen`, `Biscoe`, and `Dream`), the bill length (measured in `mm`), the bill depth (measured in `mm`), the flipper length (measured in `mm`), the body mass (measured in `g`), and the sex (`male` and `female`).

Notation: Input variables are typically denoted with the symbol $X$.
Such that if there is more than one they will be written with subscripts as follows $X_{1},X_{2},\dots, X_{p}$.

An easy to use package for Linear and generalized linear models in Julia is `GLM.jl`.
Hence, we will do our linear models with this package.

```
using GLM: lm, predict, @formula
```

```
specie = filter(:species => ==("Adelie"), penguins)
X = specie[!,:flipper_length_mm]
Y = specie[!,:bill_length_mm]
```

```jl
@sc JDS.simple_lm()
```

```jl
@sco JDS.plot_lm()
```
