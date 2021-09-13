# Statistics {#sec:stats}

This content was created in order to awaken the reader to the importance of statistics for science and knowledge generation.
Our idea is to present the concepts in the way we would like to have been provided when students about to be initiated into science.
Our approach is to simplify the concepts as much as possible without losing their essence.
We will cover:

* what is statistics
* the difference between descriptive statistics and inferential statistics
* measures of central tendencies
* measures of dispersion
* measures of dependence
* probability distributions
* statistical visualization

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
