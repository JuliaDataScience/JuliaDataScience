# Statistics {#sec:stats}

Importance of statistics.
Overall introduction.

@fig:stats_vs_prob ...

![Statistics vs Probability](images/statistics.png){#fig:stats_vs_prob}

```{=comment}
The graph above is here:

digraph estatistica_inferencial {
  forcelabels = true;
  graph [overlap = false,
  	 dpi = 300,
  	 bgcolor="transparent",
         fontsize = 12,
         rankdir = TD]
  node [shape = oval,
        fontname = Helvetica]
  A [label = "Data\nGenerating\nProcess"]
  B [label = "Observed\nData"]
  A -> B [dir = forward,
          xlabel = "  Probability  ",
          tailport = "e",
          headport = "e"]
  B -> A [dir = backward,
          label = "  Inference  ",
          tailport = "w",
          headport = "w"]
}
```

## Central Tendencies Measures {#sec:stats_central}

Mean.
Median.
Mode.

## Dispersion Measures {#sec:stats_dispersion}

Variance and Standard Deviation.
Mean Absolute Deviation.
Percentiles, Quartile, Quintiles and IQR.

## Dependence Measures {#sec:stats_dependence}

Covariance [and](and) Correlation.
