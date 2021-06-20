# Why Julia? {#sec:why_julia}

The world of data science is already filled with different programming languages.
Industry has adopted Python and academia has adopted R.
**Why bother learning other language?**
To answer this question we will address two common backgrounds that someone has when beginning their data science journey:

1. **No programming background**, will have to learn programming while also learning data science.

2. **Knows how to program**, will have to learn data science and also translate it to the programming language of choice.

In the first background, the common underlying story is the following.
Data science has captivated you, making you interested in learning what is it all about and how can you use it to build/improve your career in academia or industry.
You then try to find resources to learn this new craft and you stumble into a world of intricate acronyms: `pandas`, `dplyr`, `data.table`, `numpy`, `matplotlib`, `ggplot2`, `bokeh`, and the list goes on and on... Out of the blue you hear a name: "Julia".
What is this?
How is it any different from other stuff that I've been told that you ought use to do data science?
Why should I dedicate my precious time into learning a language that is almost never mentioned in any job listing, lab position, postdoc offer or academic job description?
The answer is that **Julia is a fresh approach** both to programming and data science.
Everything that you do in Python or in R you can do it in Julia, with the advantage of using readable[^readable], faster and powerful code syntax.
So, **if you don't have any programming background knowledge, we highly motivate you to take up Julia** as a first programming language and data science framework.

In the second background, the common underlying story changes a little bit.
You are someone who knows how to program and probably does (or has thought about doing) this for a living.
You are well-versed (or even fluent) in Python or R.
You've heard about this new flashy thing called "data science" and you wanna jump on the bandwagon.
You begin to learn how to do stuff in `numpy`, how to manipulate `DataFrames` in `pandas` and how to plot things in `matplotlib`.
Or maybe you've learned all that in R by using the tidyverse and `tibbles`, `data.frames`, `%>%` (pipes) and `geom_*`...
Then, from someone or somewhere you become aware about this new language called "Julia".
Why bother?
You are already proficient in Python or R and you can do everything that you need.
Well, let us contemplate some plausible scenarios.
**Have you ever in Python or R:**

1. done something and had to wait minutes for it to finish?
Well, **in Julia Python or R minutes can be translated to seconds**^[and sometimes milliseconds.].
We reserved @sec:julia_wild for displaying successful Julia usecases in both academia and industry.

1. tried to do something different than `numpy`/`dplyr` conventions and discovered that your code is slow and you'll probably have to learn black magic^[`numba`, or even `Rcpp` or `cython`?] to make it faster?
**In Julia you can do your custom different stuff without loss of performance**.

2. had to debug code and somehow you see yourself reading a Fortran or C/C++ source code and having no idea what you are trying to accomplish?
**In Julia you only read Julia code[^readable], no need to learn another language to make your original language fast**.
This is called the "two-language problem" (see @sec:two_language).
It also covers the usecase for when "you had an interesting idea and wanted to contribute to an opensource package and gave up because almost everything is not in Python or R but in C/C++ or Fortran"^[have a look at some deep learning libraries in GitHub and you'll be surprised that Python is only 25%-33% of the codebase.].

3. wanted to use a data structure defined in a package in another package and found that doesn't work and you'll probably need to build an interface^[this is most a Python ecosystem problem, while R doesn't suffer heavily from this is not blue skies either.].
**Julia allows users to easily share an reuse code from different packages.**
Most of Julia user-defined types and functions work right out of the bat^[or with little effort necessary.] and some users are even marvelled upon discovering how their packages are being used by other libraries in ways that they could not have imagined.
We have some examples in @sec:multiple_dispatch.

If we got you attention by exposing somewhat familiar or plausible situations, you might be interesting to learn more about this new kid in the block called Julia.
Let's proceed them!

## What Julia tries to accomplish? {#sec:julia_accomplish}

Julia [@bezanson2017julia].

```{=comment}
My figure from [https://storopoli.io/Bayesian-Julia/pages/images/language_comparisons.svg] (I have it in .drawio and .svg)
```

### The Two-Language Problem {#sec:two_language}

```{=comment}
Alan Edelman TEDX talk @tedxtalksProgrammingLanguageHeal2020
```

### Multiple Dispatch {#sec:multiple_dispatch}

```{=comment}
This section should also include how Julian allows for code sharing and code reuse.

Also include youtubevideo from Karpinski [https://youtu.be/kc9HwsxE1OY]

There is also the YouTube video from Rackaukas saying that someone said that Julia has the best GPU-based quaternion ODE Solver and he said that he had no idea because he didn't even implemented it (https://youtu.be/moyPIhvw4Nk?list=PLpTXaEnTpmwNHVg-yWEBkzx-pTxykFMMx&t=2107) !
```

## Julia in the Wild {#sec:julia_wild}

```{=comment}
Nice Examples of Julia. We have some NASA stuff, the FAA Julia system. SciML's Pfizer drug development speedup.
```

[^readable]: no C++ or FORTRAN API calls.
