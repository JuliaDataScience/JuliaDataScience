## Distributions {#sec:stats_dist}

Before defining distributions, we must talk about **probability**.

In the classical definition of probability, **the probability of an event is a real number between 0 and 1, where 0 indicates the impossibility of the event and 1 indicates the certainty of the event**.
The greater the likelihood of an event, the more likely it is that the event will occur.
A simple example is the tossing of a fair (impartial) coin.
Since the coin is fair, both results ("heads" and "tails") are equally likely; the probability of "heads" is equal to the probability of "tails"; and since no other result is possible, the probability of "heads" or "tails" is $\frac{1}{2}$ (which can also be written as 0.5 or 50%).

Regarding notation, **we define $A$ as an event and $P(A)$ as the probability of event $A$**.
In addition, we have three axioms, originating from @kolmogorovFoundationsTheoryProbability1933:

1. **Non-negativity**: For all $A$, $P(A) \geq 0$. Every probability is positive (greater than or equal to zero), regardless of the event.
2. **Additivity**: For two mutually exclusive events $A$ and $B$ (cannot occur at the same time): $P(A) = 1 - P(B)$ and $P(B) = 1 - P(A)$.
3. **Normalization**: The probability of all possible events $A_1, A_2, \dots$ must add up to 1: $\sum_{n \in \mathbb{N}} P(A_n) = 1$; or, in the case of a continuous variable, integrate to 1: $\int^\infty_{-\infty} f(x) dx = 1$.

Now we are ready to talk about distributions.
Simply put: a **distribution is just a collection of scores (counts) in a variable (observations)**.
A **probability distribution is defined by a function which maps real numbers to a probability**:

$$ f(X): X \to \mathbb{R} \in [0, 1], $$ {#eq:distribution}

where $\mathbb{R}$ is the set of real numbers and $[0, 1] \in \mathbb{R}$ is the closed interval of real numbers between 0 and 1.
In other words, distributions are a mapping between values and their respective probabilities.
We generally denote that a random variable $X$ follows a specific distribution by the following notation:

$$ X \sim \operatorname{dist}(\theta_1, \theta_2, \dots), $$ {#eq:distribution_notation}

where $\operatorname{dist}$ is the name of the distribution and $\theta_1, \theta_2, \dots$ are the parameters that control how the distribution behaves.
Every distribution can be "parameterized" by specifying parameters that allow us to tailor some aspects of the distribution for some specific purpose.

Also, notice that we are using upper case $X$ instead of lower case $x$.
This is a widely used convention in probability and statistics, that **upper case characters denote random variables, and lower case characters denote numerical values of a random variable**.
More broadly, $X$ is a theoretical distribution, whereas $x$ are the observed values from $X$.

There are several distributions defined in textbooks[^stats_book] and scientific articles[^stats_articles].
We'll cover just a few of them in this section.
In Julia, we have a package that provides a large collection of distributions and related function called [`Distributions.jl`](https://juliastats.org/Distributions.jl/dev/), which we will use to showcase some distributions:

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
Notice that since the values are equally likely, the cdf scales *linearly* with the possible outcome values.

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
