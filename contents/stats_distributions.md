## Distributions {#sec:stats_dist}

Distributions are the thing that makes most of the statistical machinery tick.
We can show how a distribution can arise via a simple example.
Suppose that a ball falls on top of a few rows of pins.
At every pin, the ball can either fall to the left or to the right.
We count a fall to the right as 1 and a fall to the left as 0.
Now, the question is: how many times will the ball fall to the right?

To simulate this, we can use the `Random` module from Julia's standard library.
We also set a seed to ensure that the outcome of this code is the same for every run:

```
using Random
```

```jl
sc("seed!(0)")
```

```jl
s = """
    n_rows = 100
    x = count(rand(Bool, n_rows))
    """
scob(s)
```

Okay, so over `jl n_rows` rows, the ball fell `jl x` times to the right.
What if we do the same thing a few more times?

```jl
s = """
    n_repeats = 800
    X = [count(rand(Bool, n_rows)) for i in 1:n_repeats]
    X[1:10]
    """
sco(s)
```

Apparently, the ball doesn't always fall `jl x` times to the right.
We can create a scatter plot for these numbers:

```jl
s = """
    CairoMakie.activate!() # hide
    figure = (; size=(600, 400))
    xlabel = "number of times fallen to the right"
    axis = (; xlabel, ylabel="ball")
    scatter(X, 1:n_repeats; figure, axis)
    label = "first_distribution" # hide
    link_attributes = "width=80%" # hide
    caption = "Scatter plot for balls falling on pins." # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

To answer our question about how many times the ball will fall to the right, we can look at it from another angle.
We can't answer the question exactly, but we can make a guess based on how many balls have fallen in each region.
For example, when looking at @fig:first_distribution, we can conclude that it is very unlikely that a ball will fall 0 times to the right or that the ball will fall 100 times to the right.
It is more likely that a ball will fall roughly half of the time to the left and half of the time to the right.
In other words, that the ball will fall 50 times to the right.
But, it also clearly isn't the case that the ball always falls 50 times to the right.
A question that we can answer is: how many times could we expect the ball to fall 40 times to the right? What about 60 times?
To answer that, we can divide the range $[0, 100]$ into bins and count how many balls have fallen in that range.
This is called a **hist**ogram:

```jl
s = """
    figure = (; size=(600, 400))
    axis = (; xlabel, ylabel="balls per bin")
    hist(X; figure, axis)
    label = "first_histogram" # hide
    link_attributes = "width=80%" # hide
    caption = "Histogram for balls falling on pins." # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

And there we have something that is bell-shaped.
Now, the question about how many times a ball will fall to the right can be answered by estimating the distribution for these data points.
Then, the answer will look something like "we expect the falling of the ball to be distributed by a ... distribution with ...."
For example, "we expect the falling of the ball to be distributed by a normal distribution with a mean of 50 and a variance of 5" (see @sec:stats_dist_normal for more information about the normal distribution).

What we have shown here is inspired by Galton's board (see @fig:galton).
This board was used around 1880 by Sir Francis Galton to demonstrate regression to the mean.
On the board, balls are dropped onto onto the pins and drop either to the left or the right at various levels.
At the bottom, the balls are aggregated in bins and here a bell-shape arises too.

![Galton's board (source: Wikimedia Commons).](images/galtons-board.png){#fig:galton width=60%}

There are several distributions defined in textbooks[^stats_book] and scientific articles[^stats_articles].
We'll cover a few of them in this section.
In Julia, there is a package that provides a large collection of distributions and related functions.
The package is called [`Distributions.jl`](https://juliastats.org/Distributions.jl/dev/), which we will use to showcase some distributions:

[^stats_book]: we recommend @bertsekas2000introduction.
[^stats_articles]: one example is the $\operatorname{LKJ}$ distribution [@lewandowskiGeneratingRandomCorrelation2009].

```julia
using Distributions
```

### Normal and Non-Normal Distributions {#sec:stats_dist_normal}

The most commonly arising distribution is the **normal distribution**.
It occurs a lot in nature; for example, the height and weight of humans, and the size of snowflakes.
It has the ubiquitous shape of a bell curve and is also known as the *Gaussian* distribution in honor of the mathematician Carl Friedrich Gauss.

This distribution is generally used in the social and natural sciences to represent variables in which their distributions are not known.
Some phenomena follow a normal distribution, such as human height, human shoe size, or test scores.

However, beware that *not all phenomena are normally distributed*.
For example, income, financial returns, city size, social media followers are examples of important phenomena that, generally, do not follow a normal distribution.
Instead, they follow what we will call a non-normal distribution, or, as some also denote, a long-tailed distribution.

In @fig:plot_normal_lognormal, we can see the comparison between a distribution that follows a normal distribution and a distribution that is long-tailed, i.e. does *not* follow a normal distribution.

```jl
fig = plot_normal_lognormal()
caption = "Normal and Non-Normal Distributed Distributions."
label = "plot_normal_lognormal"
Options(fig; filename=label, caption, label)
```

### Discrete and Continuous {#sec:stats_dist_discrete_continuous}

Regarding distributions, we have mainly two types of distributions: **discrete** and **continuous**.
In figure @fig:plot_discrete_continuous, we have two distributions.
To the left, a discrete distribution represented by bins of values and their probability as the height of the bar.
To the right, a continuous distribution represented by a continuous curve and the probability of values as the area under the curve.

```jl
fig = plot_discrete_continuous()
caption = "Discrete and Continuous Distributions."
label = "plot_discrete_continuous"
Options(fig; filename=label, caption, label)
```

A distribution is called **discrete if the set of values that it can take as inputs is either finite or countably finite**.
Discrete distributions examples are the toss of a coin, the roll of a dice, or the number of earthquakes per year.

How we characterize distributions is through the probability values that its inputs can take and we express it as a probability function.
In the case of the discrete distributions, the inputs have a "mass", that is why their characterization is captured by the **probability mass function** (pmf).

$$ \operatorname{pmf} = P(X = x) $$ {#eq:pmf}

In @fig:plot_pmf we have the pmf of a 6-sided dice where each one of the six outcomes are equally likely, i.e. they have equal probability.

```jl
fig = plot_pmf()
caption = "Probability Mass Function of a 6-sided Dice."
label = "plot_pmf"
Options(fig; filename=label, caption, label)
```

A distribution is called **continuous if the set of value that it can take as inputs is uncountably infinite**.
Examples of continuous distributions are the weight or height or a person, the waiting time for the next bus to arrive or the infection rate of a contagious disease.

Analogously, in the continuous case, the inputs have a "density", thus we characterize continuous distributions with the **probability density function** (pdf).

$$ \operatorname{pdf} = P(a \leq X \leq b) = \int_a^b f(x) dx $$ {#eq:pdf}

Since a continuous distribution takes uncountably infinite this means that the pdf of a specific value is always *zero* and the pdf is only defined on an interval.
That's why we have an integral in @eq:pdf.

For example, in @fig:plot_pdf, we have a normal distribution with mean 0 and standard deviation 1.
Notice that, since this is a valid probability, the gray shaded area that represents all the possible values integrates to 1.
The red shaded area is the probability, under this distribution, of observing values from 1 to 2 and we need to calculate the total area.
So we integrate the distribution from 1 to 2, this is the pdf and evaluates to `jl calculate_pdf(1, 2)`.

```jl
fig = plot_pdf()
caption = "Probability Density Function of a Normal Distribution."
label = "plot_pdf"
Options(fig; filename=label, caption, label)
```

### Cumulative Distribution Function {#sec:stats_dist_cdf}

Finally, there is one more important distribution function.
The **cumulative distribution function (cdf) provides the probability $P(X \leq x)$**.
In other words, **the cdf is an accumulation of the probability we observe values up to a given value $x$**.
It is defined both for discrete and continuous variables:

$$ \operatorname{cdf} = P(X \leq x) =
 \begin{cases}
 \sum_{k \leq x} P(k), & \text{if $X$  is discrete},\\
 \int^x_{- \infty} f(t) dt, & \text{if $X$ is continuous.}
 \end{cases} $$ {#eq:cdf}

In @eq:cdf we sum all values less than or equal to $x$ if the distribution $X$ is discrete or we integrate from minus infinity to $x$ if the distribution $X$ is continuous.
For example, in @fig:plot_cdf_discrete we have the cdf of a 6-sided dice.
Notice that since the values are equally likely, the cdf becomes a step function that scales linearly with the possible outcome values.

```jl
fig = plot_cdf("discrete")
caption = "Cumulative Distribution Function of a Discrete Distribution -- 6-sided Dice."
label = "plot_cdf_discrete"
Options(fig; filename=label, caption, label)
```

To contrast, we present the cdf of a normal distribution with mean 0 and standard deviation 1 in @fig:plot_cdf_continuous.
You can see that since the outcomes are *not* equally likely, our cdf scales differently.

```jl
fig = plot_cdf("continuous")
caption = "Cumulative Distribution Function of a Continuous Distribution -- Normal Distribution."
label = "plot_cdf_continuous"
Options(fig; filename=label, caption, label)
```
