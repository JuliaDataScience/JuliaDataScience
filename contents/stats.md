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

```jl
s = """
    fig = statistics_graph()
    caption = "Statistics vs Probability"
    label = "stats_vs_prob"
    Options(fig; filename=label, caption, label)
    """
sco(s)
```

In this chapter, we will cover only descriptive statistics.
Inferential statistics is an important and fundamental component of applied sciences, but its scope is too broad. Let's begin on simple ways to summarize our data with central tendencies.

## Central Tendencies Measures {#sec:stats_central}

The most basic way of using descriptive statistics is to summarize data by a measure of **central tendency**.

### Mean {#sec:stats_central_mean}

We have several ways to summarize data but the most common is to use the mean.
**The mean, also known as average, is the sum of all measurements divided by the number of observations** and we generally denote it as "x bar":

$$ \bar{x} = \frac{1}{n} \sum^n_{i=1} x_i = \frac{x_1 + x_2 + \cdots + x_n}{n}, $$ {#eq:mean}

where $\bar{x}$ is the sample mean of the variable $\mathbf{x} = x_1, \cdots, x_n$.
Often, we see the mean denoted with the **Greek letter $\mu$**, for example $\bar{x} = \mu_x$.
Additionally, the mean is also known as the **expectation** which is represented by the operator $\operatorname{E}$, thus the mean of a variable $x$ becomes a $\operatorname{E}(x)$.
So, bear in mind that you might find different notations for the mean.

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

In order to have a better intuition behind the difference between mean, median and mode, it is always useful to make some visualizations.
We will cover statistical visualizations in depth in @sec:stats_vis.
Below, in @fig:plot_central, we have two data distributions:

- **Upper row**: **normal** distributed data
- **Lower row**: **non-normal** distributed data

```jl
s = """
    fig = plot_central()
    caption = "Normal and Non-Normal Distributed Data -- Difference Between Central Tendencies."
    label = "plot_central"
    Options(fig; filename=label, caption, label)
    """
sco(s)
```

You can see that the mean, median and mode are almost the same in the normal distributed data, but they differ a lot in the non-normal distributed data.
In the non-normal distributed data the mean is highly skewed towards to the right, *biasing* our central tendency.
This is an example of an outlier scenario where the mean can be highly sensitive to influential observations.
Nevertheless, the median is unaffected by the outliers and can be used as a *reliable* central tendency.
This demonstrates that the **median is robust to outliers**.
In both cases, the mode is used only for comparison, since it is not advised for use with numerical data.

### Advice on Central Tendencies {#sec:stats_central_advice}

You might be wondering: "which central tendency shall I use? Mean? Median? Mode?".
Here is our advice:

- For data that do *not* have outliers, use the **mean**
- For data that *do* have outliers, use the **median**
- For categorical/nominal data, use the **mode**

## Dispersion Measures {#sec:stats_dispersion}

In statistics, **dispersion is a measure of how much spread certain observations are from a central tendency**.
It is also called variability or spread.
One interesting property is that, contrary to central tendencies, dispersion measures can *only* be **positive**.
In other words, we do not have negative measures of dispersion.

### Variance and Standard Deviation {#sec:stats_dispersion_varstd}

The first dispersion measure that we will cover are variance and standard deviation.
We will be covering both measures together because they have a profound relationship.
**The variance is the square of the standard deviation and the standard deviation is the square root of the variance.**

Let's start with the variance. **Variance is mean of the squared difference between measurements and their average value**:

$$ \operatorname{Var}(x) = \frac{1}{n-1} \sum^n_{i=1} (x_i - \bar{x})^2. $$ {#eq:variance}

We use the operator $\operatorname{Var}$ to denote variance, but you also might find variance being denoted as the squared Greek letter $\sigma^2$.
Note that we are using $n-1$ in @eq:variance.
This is because we need a bias correction since we are using one *degree of freedom* from our estimate mean $\bar{x}$.
Degrees of freedom are not in the scope of our book, so we won't cover in details, but feel free to check the [Wikipedia](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)) for a in depth explanation.

Since we are squaring the differences in @eq:variance, the variance has a property that all dispersion measures have: the variance *cannot* be negative.

The **var**iance can be used from the `var` function from Julia's standard library `Statistics` module:

```julia
using Statistics: var
```

Like before, we can apply the variance to different groups in our `more_grades` `DataFrame`:

```jl
# variance
s = """
    gdf = groupby(more_grades(), :name)
    combine(gdf, :grade => var)
    """
sco(s; process=without_caption_label)
```

We can see that Sally has the highest dispersion in her grades measured by its variance.

**The squared deviation is the square root of the mean of the squared difference between measurements and their average value**.
Or in more simple words: it is the **square root of the variance**:

$$ \sigma(x) = \sqrt{\frac{1}{n-1} \sum^n_{i=1} (x_i - \bar{x})^2}. $$ {#eq:std}

For the standard deviation, since it is the square root of the variance, and variance is denoted as $\sigma^2$, we use the Greek letter $\sigma$ to denote standard deviation.

In a similar fashion, for the **st**andard **d**eviation, we can use the `std` function from Julia's standard library `Statistics` module:

```julia
using Statistics: std
```

```jl
# std
s = """
    gdf = groupby(more_grades(), :name)
    combine(gdf, :grade => std)
    """
sco(s; process=without_caption_label)
```

Since the standard deviation is the square root of the variance, our measures of dispersion have only been rescaled.
Sally still has the highest dispersion in her grades measured either by variance or standard deviation.

### Mean Absolute Deviation {#sec:stats_dispersion_mad}

Since variance and standard deviation uses the mean in their mathematical formulation, they are also **sensitive to outliers**.
This is where a **dispersion measure that uses the median instead of the mean** would be useful.
This is exactly the case of the **median absolute deviation which is defined as the median of the absolute difference between measurements and their median value**.
Also known as its acronym MAD, it is an extreme robust dispersion measure since it uses twice the median to calculate first the central tendency followed by the difference between observations and their central distance:

$$ \operatorname{MAD}(x) = \operatorname{median}(|x_i - \operatorname{median}(x)|), $$ {#eq:mad}

where $|.|$ is the notation for absolute value.

The **m**ean **a**bsolute **d**eviation is available as the function `mad` in the `StatsBase.jl`:

```julia
using StatsBase: mad
```

Let's see how our `more_grades` `DataFrame`'s dispersion measures are using `mad`:

```jl
# mad
s = """
    gdf = groupby(more_grades(), :name)
    combine(gdf, :grade => mad)
    """
sco(s; process=without_caption_label)
```

We can see that still Sally has the highest grades dispersion, but now Bob's and Alice's dispersion are the same.
Also note that, by using $\operatorname{MAD}$, Hank's dispersion is zero.
This happens because two of the three Hank's grade are the same value:

```jl
s = """
    df = more_grades()
    filter!(row -> row.name == "Hank", df)
    df
    """
sco(s; process=without_caption_label)
```

If we plug Hank's grades into @eq:mad we have to calculate $\operatorname{median}([2, 0, 0])$, so we end up with the middle value in an ordered list which is $0$.

### Quantile and Percentiles {#sec:stats_dispersion_quantiles}

Percentiles, Quantile, and IQR.

## Dependence Measures {#sec:stats_dependence}

Covariance and Correlation.
