# Statistics {#sec:stats}

This content was created in order to awaken the reader to the importance of statistics for science and knowledge generation.
Our idea is to present the concepts in the way we would like to have been provided when students about to be initiated into science.
Our approach is to simplify the concepts as much as possible without losing their essence.
**In this chapter, we will cover**:

* what is **statistics**
* the difference between **descriptive statistics** and **inferential statistics**
* measures of **central tendencies**
* measures of **dispersion**
* measures of **dependence**
* **probability distributions**
* statistical **visualization**

Statistics is important because it is a **tool to make sense of data**.
With the abundant availability of data, we are often overwhelmed by numbers.
Statistics offers a way to comprehend, summarize and infer information from data.
We believe that every data scientist should have a basic understanding of statistics and how to perform simple statistical operations.

We can divide statistics into two broad categories: **descriptive** and **inferential**.
**Descriptive statistics summarizes and quantifies the characteristics of a given observed data**.
Common metrics are: mean, median, mode, standard deviation, variance, correlation, percentiles.

**Inferential statistics allows generating inferences** (statements) **from observed data about the data generation process**.
All phenomena have an underlying data generating process that describes how the data is being generated.
For example, in a soccer game, a scored goal can be explained by an underlying process: a tactic, error, struck of luck; or a mix of those.
If we know a phenomenon's data generating process, we can use probability to simulate possible scenarios given certain aspects.
Most of the time, specially in applied sciences, we do not have full knowledge of the data generating process.
Given the observed data, we can retrace our way back to the data generating process.
This process is known as **statistical inference**.
Given some data, we can *infer* what are the aspects of the underlying data generating process.
This is the realm of inferential statistics.

In @fig:stats_vs_prob we summarize the relationship between data generating process and observed data.
With knowledge of the data generating process we can apply probability to generate and simulate plausible data.
And by using the observed data we can use inference to gain knowledge about the underlying data generating process.

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

In this chapter, we will cover only descriptive statistics.
Inferential statistics is an important and fundamental component of applied sciences, but its scope is too broad. Let's begin on simple ways to summarize our data with central tendencies.

## Central Tendencies Measures {#sec:stats_central}

The most basic way of using descriptive statistics is to summarize data by a measure of **central tendency**.

### Mean {#sec:stats_central_mean}

We have several ways to summarize data but the most common is to use the **mean**.
The mean is the **sum of all measurements divided by the number of observations** and we generally denote it as "x bar":

$$ \bar{x} = \frac{1}{n} \sum^n_{i=1} x_i = \frac{x_1 + x_2 + \cdots + x_n}{n}, $$ {#eq:mean}

where $\bar{x}$ is the sample mean of the variable $\mathbf{x} = x_1, \cdots, x_n$.

The mean can be used from the `mean` function from Julia's standard library `Statistics` module:

```julia
using Statistics: mean
```

And we can apply the mean to different groups in our data like we did in @sec:groupby_combine.
For example, we have the `all_grades` `DataFrame`:

```jl
# inside stats content # hide
sco("all_grades()"; process=without_caption_label)
```

Let us add more grades to our students so that we have more numbers to calculate central tendencies:

```jl
sco("more_grades()"; process=without_caption_label)
```

```jl
# inside stats content # hide
s = """
    gdf = groupby(more_grades(), :name)
    combine(gdf, :grade => mean)
    """
sco(s; process=without_caption_label)
```

### Median {#sec:stats_central_median}

We will see that the mean is highly sensitive to outliers and can sometimes misguide us, specially when we are dealing with long-tailed (non-normal distributions) (more in @sec:stats_dist_normal).
That is why sometimes we are interested in also the **median** which is the **middle value that separates the higher half from the lower half of the data**.
Intuitively, the median tells us the value of the data's 50\% percentile.
One example is when we are analyzing income.
The median is the upper limit that we expect that half of the observations earn.
So, if the median income is U$ 80,000, we expect that half of our observations earn between the minimum value and U$ 80,000.
The mathematical formula for the median is:

$$ \operatorname{median}(\mathbf{x}) = \frac{x_{\lfloor (\# x+1) \div 2 \rfloor} + x_{\lceil (\# x+1) \div 2 \rceil}}{2}, $$ {#eq:median}

where:

- $\mathbf{x} = x_1, \cdots, x_n$ is an ordered list of numbers
- $\# x$ is the list length
- $\lfloor . \rfloor$ a rounded-down value to the nearest integer
- $\lceil . \rceil$ a rounded-up value to the nearest integer

Similarly, we can use the `median` from `Statistics` module to apply the median to our data:

```julia
using Statistics: median
```

```jl
# median # hide
s = """
    gdf = groupby(more_grades(), :name)
    combine(gdf, :grade => median)
    """
sco(s; process=without_caption_label)
```

As we can see, the median differs substantially from the mean.

### Mode {#sec:stats_central_mode}

The mean and median can be useful for numerical and ordinal data.
But they are ineffective for nominal data, in which our data is comprised of qualitative data (also known as categorical data).
This is where we use the **mode**, defined as **the most frequent value in our data**.

For the mode, we *do not* have a `mode` function inside Julia's standard library `Statistics` module.
Instead, we need to use the `StatsBase.jl` for less common statistical functions:

```julia
using StatsBase: mode
```

In @sec:missing_data, we have the `correct_types` `DataFrame`, which is mainly categorical with `Date`s and `String`s:

```jl
# inside stats content # hide
sco("correct_types()"; process=without_caption_label)
```

We can compute the mode with the `combine` function from `DataFrames.jl`.
Notice that, unlike previously with mean and median, we will not group our data:

```jl
# mode # hide
s = """
    combine(correct_types(), :age => mode)
    """
sco(s; process=without_caption_label)
```

### Visualization of Central Tendencies {#sec:stats_central_vis}

**Placeholder for a picture that shows mean, median and mode for a normal-like distribution**


**Placeholder for a picture that shows mean, median and mode for a long-tailed distribution**

### Advice on Central Tendencies {#sec:stats_central_advice}

You might be wondering: "which central tendency shall I use? Mean? Median? Mode?".
Here is our advice:

- For data that do *not* have outliers, use the **mean**
- For data that *do* have outliers, use the **median**
- For categorical/nominal data, use the **mode**

## Dispersion Measures {#sec:stats_dispersion}

Variance and Standard Deviation.
Mean Absolute Deviation.
Percentiles, Quartile, Quintiles and IQR.

## Dependence Measures {#sec:stats_dependence}

Covariance [and](and) Correlation.
