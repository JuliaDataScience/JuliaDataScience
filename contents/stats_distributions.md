## Distributions {#sec:stats_dist}

What is a distribution.
3 axioms of Kolmogorov.

```julia
using Distributions
```

$$ P(X): X \to \mathbb{R} \in [0, 1] $$ {#eq:probability}


### Discrete and Continuous {#sec:stats_dist_discrete_continuous}

Placeholder for a nice discrete versus continuous distribution figure.

### Normal and Non-Normal Distributions {#sec:stats_dist_normal}

$$ X \sim \operatorname{Dist}(\theta_1, \theta_2, \dots) $$ {#eq:distribution}

Placeholder for a nice Normal vs Non-normal distribution figure.

### Probability Mass/Density Function {#sec:stats_dist_pdf}

$$ \operatorname{PMF} = P(X = x) $$ {#eq:pmf}

Placeholder for a nice PMF figure.

$$ \operatorname{PDF} = P(a \leq X \leq b) = \int_a^b f(x) dx $$ {#eq:pdf}

Say something about continuous probability for a specific value being zero and that PDFs are only defined for an interval.

Placeholder for a nice PDF figure.

### Cumulative Distribution Function {#sec:stats_dist_cdf}

$$ \operatorname{CDF} = P(X \leq x) =
 \begin{cases} 
 \sum_{k \leq x} P(k), & \text{if $X$  is discrete},\\
 \int^x_{- \infty} f(t) dt, & \text{if $X$ is continuous.}
 \end{cases} $$ {#eq:cdf}
 
In @eq:cdf we sum all values less or equal than $x$ if the distribution $X$ is discrete or we integrate from minus infinity to $x$ if the distribution $X$ is continuous.

Placeholder for a nice CDF figure.
