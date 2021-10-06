# Statistics {#sec:stats}

Statistics is an essential part of data science.
In this chapter, we aim to present the concepts in a way that we would have liked to learn it.
Our approach is to simplify the concepts as much as possible where possible.
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
Statistics offers a way to comprehend, summarize, and infer information from data.
We believe that every data scientist needs to have a basic understanding of statistics and how to perform simple statistical operations.

We can divide statistics into two broad categories: **descriptive** and **inferential**.
**Descriptive statistics summarizes and quantifies the characteristics of given observed data**.
Common metrics are: mean, median, mode, standard deviation, variance, correlation, percentiles.

**Inferential statistics allows generating inferences** (statements) **from observed data about the data generation process**.
In @fig:stats_vs_prob we summarize the relationship between the data generating process and observed data.
All phenomena have an underlying data generating process that describes how the data is being generated.
For example, in a soccer game, a scored goal can be explained by an underlying process: a tactic, error, stroke of luck; or a mix of those.
If we know a phenomenon's data generating process, we can use probability to simulate possible scenarios given certain aspects.
Most of the time, especially in applied sciences, we do not have full knowledge of the data generating process.
Given the observed data, we can retrace our way back to the data generating process.
This process is known as **statistical inference**.
Given some data, we can *infer* what are the aspects of the underlying data generating process.
This is the realm of inferential statistics.

With knowledge of the data generating process we can apply probability to generate and simulate plausible data.
And by using the observed data we can use inference to gain knowledge about the underlying data generating process.

```jl
fig = statistics_graph()
caption = "Statistics vs Probability"
label = "stats_vs_prob"
link_attributes = "width=60%"
Options(fig; filename=label, caption, label, link_attributes)
```

In this chapter, we will cover only descriptive statistics.
Inferential statistics is an important and fundamental component of applied sciences, but its scope is too broad. So, let's begin with some simple ways to summarize our data by using central tendencies.

## Central Tendencies Measures {#sec:stats_central}

The most basic way of using descriptive statistics is to summarize data by a measure of **central tendency**.

### Mean {#sec:stats_central_mean}

The most common central tendency measure is the mean.
**The mean, also known as average, is the sum of all measurements divided by the number of observations** and we generally denote it as "x bar":

$$ \bar{x} = \frac{1}{n} \sum^n_{i=1} x_i = \frac{x_1 + x_2 + \cdots + x_n}{n}, $$ {#eq:mean}

where $\bar{x}$ is the sample mean of the variable $\mathbf{x} = x_1, \cdots, x_n$.
Often, we see the mean denoted with the **Greek letter $\mu$**, for example $\bar{x} = \mu_x$.
Additionally, the mean is also known as the **expectation** which is represented by the operator $\operatorname{E}$, thus the mean of a variable $x$ becomes $\operatorname{E}(x)$[^expectation].
So, bear in mind that you might find different notations for the mean.

[^expectation]: technically speaking, the expectation is defined as either a sum for discrete variables or an integral for continuous variables weighted by a probability distribution. In contrast, the mean is simply the arithmetic sum of the variables' values divided by the number of values.

The mean can be found using the `mean` function from the `Statistics` module, part of Julia's standard library:

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

We will see that the mean is highly sensitive to outliers and can sometimes misguide us, especially when we are dealing with long-tailed (non-normal distributions) (more in @sec:stats_dist_normal).
That is why we are sometimes interested in the **median** which is the **middle value that separates the higher half from the lower half of the data**.
Intuitively, the median tells us the value of the data's 50\% percentile.
One example is when we are analyzing income.
The median is the upper limit that we expect that half of the observations earn.
So, if the median income is \$80,000, we expect that half of our observations earn between the minimum value and \$80,000.
The mathematical formula for the median is:

$$ \operatorname{median}(\mathbf{x}) = \frac{x_{\lfloor (\# x+1) \div 2 \rfloor} + x_{\lceil (\# x+1) \div 2 \rceil}}{2}, $$ {#eq:median}

where:

- $\mathbf{x} = x_1, \cdots, x_n$ is an ordered vector of numbers
- $\mathbf{x}_i$ is the element in vector $\mathbf{x}$ at position $i$
- $\# x$ is the list length
- $\lfloor . \rfloor$ a rounded-down value to the nearest integer
- $\lceil . \rceil$ a rounded-up value to the nearest integer

Similarly, we can use the `median` from the `Statistics` module to apply the median to our data:

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
However, they are ineffective for nominal data, in which our data consists of qualitative data (also known as categorical data).
This is where we use the **mode**, defined as **the most frequent value in our data**.

For the mode, we *do not* have a `mode` function inside Julia's standard library `Statistics` module.
Instead, we need to use the `StatsBase.jl` package for less common statistical functions:

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

In order to have a better intuition behind the difference between mean, median, and mode, it is always useful to make some visualizations.
We will cover statistical visualizations in depth in @sec:stats_vis.
Below, in @fig:plot_central, we have two data distributions:

- **Upper row**: **normal** distributed data
- **Lower row**: **non-normal** distributed data

```jl
fig = plot_central()
caption = "Normal and Non-Normal Distributed Data -- Differences Between Central Tendencies."
label = "plot_central"
Options(fig; filename=label, caption, label)
```

You can see that the mean, median, and mode are almost the same in the normal distributed data, but they differ a lot in the non-normal distributed data.
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

In statistics, **dispersion is a measure of how much spread certain observations have from a central tendency**.
It is also called variability or spread.
One interesting property is that, contrary to central tendencies, dispersion measures can *only* be **positive**.
In other words, we do not have negative measures of dispersion.

### Variance and Standard Deviation {#sec:stats_dispersion_varstd}

The first dispersion measure that we will cover are variance and standard deviation.
We will be covering both measures together because they have a profound relationship.
**The variance is the square of the standard deviation and the standard deviation is the square root of the variance.**

Let's start with the variance. **Variance is the mean of the squared difference between measurements and their average value**:

$$ \sigma^2(x) = \frac{1}{n-1} \sum^n_{i=1} (x_i - \bar{x})^2. $$ {#eq:variance}

We use the squared Greek letter $\sigma^2$ to denote variance, but you also might find variance being denoted as operator $\operatorname{var}$.
Note that we are using $n-1$ in @eq:variance.
This is because we need a bias correction since we are using one *degree of freedom* from our estimate mean $\bar{x}$.
Degrees of freedom are not in the scope of our book, so we won't cover in details, but feel free to check the [Wikipedia](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)) for a in-depth explanation.

Since we are squaring the differences in @eq:variance, the variance has a property that all dispersion measures have: the variance *cannot* be negative.

The **var**iance can be found with the `var` function from Julia's standard library `Statistics` module:

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

**The standard deviation is the square root of the mean of the squared difference between measurements and their average value**.
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

As we did before, in @fig:plot_dispersion_std, we have two data distributions:

- **Upper row**: **normal** distributed data
- **Lower row**: **non-normal** distributed data

```jl
fig = plot_dispersion_std()
caption = "Normal and Non-Normal Distributed Data -- Differences Between Standard Deviations."
label = "plot_dispersion_std"
Options(fig; filename=label, caption, label)
```

We can see that the mean $\mu$ is slightly shifted towards to the right by the few influential observations and that the dispersion measured by the $\pm 1\sigma$ (one standard deviation) away from the mean inherits the bias from the mean.

### Mean Absolute Deviation {#sec:stats_dispersion_mad}

Since variance and standard deviation use the mean in their mathematical formulation, they are also **sensitive to outliers**.
This is where a **dispersion measure that uses the median instead of the mean** would be useful.
This is exactly the case of the **median absolute deviation (mad) which is defined as the median of the absolute difference between measurements and their median value**.
`mad` is an extremely robust dispersion measure since it uses twice the median to calculate first the central tendency followed by the difference between observations and their central distance:

$$ \operatorname{mad}(x) = \operatorname{median}(|x_i - \operatorname{median}(x)|), $$ {#eq:mad}

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
Also note that, by using $\operatorname{mad}$, Hank's dispersion is zero.
This happens because two of Hank's three grades are the same value:

```jl
s = """
    df = more_grades()
    filter!(row -> row.name == "Hank", df)
    df
    """
sco(s; process=without_caption_label)
```

If we plug Hank's grades into @eq:mad we have to calculate $\operatorname{median}([2, 0, 0])$, so we end up with the middle value in an ordered list which is $0$.

Once more, in @fig:plot_dispersion_mad, we have two data distributions:

- **Upper row**: **normal** distributed data
- **Lower row**: **non-normal** distributed data

```jl
fig = plot_dispersion_mad()
caption = "Normal and Non-Normal Distributed Data -- Differences Between Mean Absolute Deviations."
label = "plot_dispersion_mad"
Options(fig; filename=label, caption, label)
```

Note that the `mad` is extremely robust against influential observations and, contrary to the standard deviation, does not inherit any bias from the underlying central tendency measure (median).
`mad` can be an effective dispersion measure to non-normal data which few influential observations shift a non-robust central tendency (such as the mean).

### Percentiles and Quantiles {#sec:stats_dispersion_quantiles}

In statistics, we have the notion of a **percentile that is a score _below which_ a given percentage of scores from observations falls**.
For example, the median is the 0.5 percentile (50\%).
Or, if we want the top-5% highest values of our observations, we would select observations from the 0.95 percentile onwards.

Some percentiles have special names:

- 0.33 and 0.666 are called **terciles**
- 0.25, 0.50, 0.75 are called **quartiles**
- 0.2, 0.4, 0.6, 0.8 are called **quintiles**
- 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9 are called **deciles**

These, including percentiles, are in a broad manner called quantiles.
**Quantiles are cut points that divide equally the range of observations values' into equal spaced intervals**.

The most important and commonly used quantile is the 4-quantile, also known as **quartile**, which we denote with the letter Q followed by a number to identify which one of the quantiles we are referring to.
Since we have only three quantiles, we have Q1, Q2, and Q3 corresponding to the first, second, and third quantile, respectively.
The Q2 (the 0.5 percentile) is also the median and the Q1 and Q3 are the 0.25 and 0.75 percentile.
The quartiles are important because we often use them to denote a measure of dispersion.
This measure is known as **interquartile range** (IQR) and is the **difference between the third and first quartile**:

$$ \operatorname{IQR}(x) = \operatorname{Q3}(x) - \operatorname{Q1}(x), $$ {#eq:iqr}

Like the mean absolute deviation, **IQR**, since it uses the median and percentiles, it is also **robust to outliers**.

As usual, in @fig:plot_dispersion_iqr, we have two data distributions:

- **Upper row**: **normal** distributed data
- **Lower row**: **non-normal** distributed data

```jl
fig = plot_dispersion_iqr()
caption = "Normal and Non-Normal Distributed Data -- Differences Between IQR Measures."
label = "plot_dispersion_iqr"
Options(fig; filename=label, caption, label)
```

Here we can see that the median is *not* influenced by the few influential observations and that the IQR measured by the 1st and 3rd quantiles represents the 50% most probable values of our observations.

### Advice on Dispersion Measures {#sec:stats_dispersion_advice}

You might be wondering: "which dispersion measure shall I use? Variance? Standard Deviation? Mean Absolute Deviation? IQR?".
Like before, we provide the following advice:

- _Avoid_ **variance**, since it is not an intuitive measure.
- For data that do *not* have outliers, use the **standard deviation**.
- For data that *do* have outliers, use either the **mean absolute deviation** or **IQR**.
- For categorical/nominal data, use some sort of **frequency counter**[^frequency_counter].

[^frequency_counter]: we would suggest using the `StatsBase.countmap` function which returns a dictionary that maps each unique value in a given vector to its number of occurrences.

## Dependence Measures {#sec:stats_dependence}

Now that we've covered univariate measures of central tendency and dispersion, we need to talk about bivariate measures.
**Univariate measures are measures with respect to a single variable**.
**Bivariate measures are measures with respect to the _relationship_ between two variables**.
To quantify such relationships, we use **dependence measures, which measure the degree of how one variable value depends (or is related) to another variable value**.

There is a distinction between a dependence *measure* and a dependence *relationship*.
The first is simply a bivariate measure of how one variable is related to the other.
On the other hand, a dependence relationship implies a deeper connection, where not only are they related but information regarding one variable gives us information about the other one.

There are two main measures of dependence, and they are practically the same since one is the other constrained to the unit range between -1 and 1.
**Covariance is a measure of the joint variability of two variables**.
It is the expectation of one variable minus its expectation times another variable minus its expectation:

$$ \operatorname{cov}(x, y) = \operatorname{E} \left[ \left( x - \operatorname{E}(x) \right) \cdot \left( y - \operatorname{E}(y) \right) \right]. $$ {#eq:covariance}

High positive or negative covariance indicates either a strong positive or negative joint variability, respectively.
It measures how much one unit increase/decrease in one variable is related to one unit increase/decrease in another variable.

The interpretation of a given covariance demands knowledge about units of measurement from both underlying variables.
So, if we want to analyze covariance between two variables, we must have some understanding of how the variables' units are measured.
That is why most of the time we use the **correlation, which is _normalized_ covariance**.
The correlation is _dimensionless_ since it is constrained to the unit range between -1 and 1.
Mathematically speaking, the correlation is the covariance divided by the product of the variables' standard deviations, and is denoted by the Greek letter $\rho$:

$$ \rho(x, y) = \frac{\operatorname{cov}(x, y)}{\sigma_x \cdot \sigma_y}, $$ {#eq:correlation}

where $\sigma_x$ and $\sigma_y$ are the standard deviations of $x$ and $y$, respectively.

In @fig:plot_corr, we can see some correlations and their underlying scatter plot for 50 random generated observations.

```jl
fig = plot_corr()
caption = "Correlation for 50 Random Bivariate Observations."
label = "plot_corr"
Options(fig; filename=label, caption, label)
```

As we can see, the correlation depicts the **linear association** between variables.
The slope of the dashed line shows the correlation between variables.
The further from zero and closer to $\pm$ 1, the stronger is the association between variables.
Finally, the sign of the correlation denotes the type of relationship between variables.
**Positive correlations** implies **positive relationship**, increase in one variable results in an _increase_ in the other one.
**Negative correlations** implies **negative/inverse relationship**, increase in one variable results in a _decrease_ in the other one.
