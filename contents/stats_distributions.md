## Distributions {#sec:stats_dist}

Before defining distributions, we must talk about **probability**.

**The probability of an event is a real number ($\in \mathbb{R}$) between 0 and 1, where, roughly, 0 indicates the impossibility of the event and 1 indicates the certainty of the event**.
The greater the likelihood of an event, the more likely it is that the event will occur.
A simple example is the tossing of a fair (impartial) coin.
Since the coin is fair, both results ("heads" and "tails") are equally likely; the probability of "heads" is equal to the probability of "tails"; and since no other result is possible, the probability of "heads" or "tails" is $\frac{1}{2}$ (which can also be written as 0.5 or 50%).

Regarding notation, **we define $A$ as an event and $P(A)$ as the probability of event $A$**, thus:

$$ \{P(A) \in \mathbb{R} : 0 \leq P(A) \leq 1 \}. $$ {#eq:probability}

This means the "probability of the event to occur is the set of all real numbers between 0 and 1; including 0 and 1".
In addition, we have three axioms, originated from @kolmogorovFoundationsTheoryProbability1933:

1. **Non-negativity**: For all $A$, $P(A) \geq 0$. Every probability is positive (greater than or equal to zero), regardless of the event.
2. **Additivity**: For two mutually exclusive events $A$ and $B$ (cannot occur at the same time): $P(A) = 1 - P(B)$ and $P(B) = 1 - P(A)$.
3. **Normalization**: The probability of all possible events $A_1, A_2, \dots$ must add up to 1: $\sum_{n \in \mathbb{N}} P(A_n) = 1$; or, in the case of a continuous variable, integrate to 1: $\int^\infty_{-\infty} f(x) dx = 1$.

What is a distribution.

```julia
using Distributions
```

$$ P(X): X \to \mathbb{R} \in [0, 1]. $$ {#eq:distributions}


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
