# Why Julia? {#sec:why_julia}

The world of data science is already filled with different programming languages.

Industry has mostly adopted Python and academia have adopted R and MATLAB.
**Why bother learning other language?**
To answer this question, we will address two common backgrounds:

1. **Did not program before** -- see @sec:non-programmers.

2. **Did program before** -- see @sec:programmers.

## For non-programmers {#sec:non-programmers}

In the first background, the common underlying story is the following.
Data science has captivated you, making you interested in learning what is it all about and how can you use it to build your career in academia or industry.
Then, you try to find resources to learn this new craft and you stumble into a world of intricate acronyms: `pandas`, `dplyr`, `data.table`, `numpy`, `matplotlib`, `ggplot2`, `bokeh`, and the list goes on and on...
Out of the blue you hear a name: "Julia".
What is this?
How is it any different from other stuff that I've been told that you ought use to do data science?
Why should I dedicate my precious time into learning a language that is almost never mentioned in any job listing, lab position, postdoc offer or academic job description?
The answer is that **Julia is a fresh approach** both to programming and data science.
Everything that you do in Python or in R, you can do it in Julia, with the advantage of using readable[^readable], fast, and powerful code syntax.
So, **if you don't have any programming background knowledge, we highly encourage you to take up Julia** as a first programming language and data science framework.

## For programmers {#sec:programmers}

In the second background, the common underlying story changes a little bit.
You are someone who knows how to program and probably does this for a living.
You are well-versed (or even fluent) in Python or R.
You've heard about this new flashy thing called "data science" and you wanna jump on the bandwagon.
You begin to learn how to do stuff in `numpy`, how to manipulate `DataFrames` in `pandas` and how to plot things in `matplotlib`.
Or maybe you've learned all that in R by using the tidyverse and `tibbles`, `data.frames`, `%>%` (pipes) and `geom_*`...
Then, from someone or somewhere you become aware about this new language called "Julia".
Why bother?
You are already proficient in Python or R and you can do everything that you need.
Well, let us contemplate some plausible scenarios.
**Have you ever in Python or R:**

1. Done something and had to wait minutes for it to finish?
Well, **in Julia Python or R minutes can be translated to seconds**^[and sometimes milliseconds.].
We reserved @sec:julia_wild for displaying successful Julia usecases in both academia and industry.


2. Tried to do something different than `numpy`/`dplyr` conventions and discovered that your code is slow and you'll probably have to learn dark magic^[`numba`, or even `Rcpp` or `cython`?] to make it faster?
**In Julia you can do your custom different stuff without loss of performance**.

3. Had to debug code and somehow you see yourself reading a Fortran or C/C++ source code and having no idea what you are trying to accomplish?
**In Julia you only read Julia code[^readable], no need to learn another language to make your original language fast**.
This is called the "two-language problem" (see @sec:two_language).
It also covers the usecase for when "you had an interesting idea and wanted to contribute to an opensource package and gave up because almost everything is not in Python or R but in C/C++ or Fortran"^[have a look at some deep learning libraries in GitHub and you'll be surprised that Python is only 25%-33% of the codebase.].

4. Wanted to use a data structure defined in a package in another package and found that doesn't work and you'll probably need to build an interface^[this is most a Python ecosystem problem, while R doesn't suffer heavily from this is not blue skies either.].
**Julia allows users to easily share and reuse code from different packages.**
Most of Julia user-defined types and functions work right out of the bat^[or with little effort necessary.] and some users are even marvelled upon discovering how their packages are being used by other libraries in ways that they could not have imagined.
We have some examples in @sec:multiple_dispatch.

5. needed to have a better project management, with dependecies and version control tightly controlled, manageable and replicable?
**Julia has an amazing project management solution allied to a great package manager**.
Unlike traditional package managers, which install and manage a single global set of packages.
Julia package manager is designed around “environments”: independent sets of packages that can be local to an individual project or shared.
Each project maintains its own independent set of package versions.
We'll talk more about how to manage your projects and packages in the Appendix [-@sec:project_management].

If we got you attention by exposing somewhat familiar or plausible situations, you might be interested to learn more about this new kid in the block called Julia.

Let's proceed then!

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

To explain multiple dispatch, we'll give an illustrative example in **Python**.
Suppose that you want to have different types of researcher that will inherent from a "base" type `Researcher`.
The base type `Researcher` would define the initial common values for every derived type: `name` and `age`:

```python
class Researcher:
    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age
```

Now let us define a `Linguist` type that will inherent from the `Researcher` type.
We will also define a method that returns the citation style that is mostly used in his research field.

```python
class Linguist(Researcher):
    def citation(self):
        return "APA"
```

We do the same for the `ComputerScientist` type, but with different citation style:

```python
class ComputerScientist(Researcher):
   def citation(self):
       return "IEEE"
```

Finally, let's instantiate our two researchers, [Noam Chomsky](https://en.wikipedia.org/wiki/Noam_Chomsky) and [Judea Pearl](https://en.wikipedia.org/wiki/Judea_Pearl):

```python
noam = Linguist("Noam Chomsky", 92)
judea = ComputerScientist("Judea Pearl", 84)
```

Now suppose you want to define a function that will behave *different behaviors* depending on the *argument's types*.
For example, a linguist researcher might approach a computer scientist researcher and ask him to collaborate on a new paper.
The approach would be different if the situation were the opposite: a computer scientist researcher approaching the linguist researcher.
Below, you'll see that we defined two functions that should behave differently in both approaches:

```python
def approaches(li: Linguist, cs: ComputerScientist):
   print(f"Hey {cs.name}, wanna do a paper together? We need to use {cs.citation()} style.")

def approaches(cs:ComputerScientist, li: Linguist):
    print(f"Hey {li.name}, wanna do a paper together? We need to use {li.citation()} style.")
```

Now lets say Noam Chomsky approaches Judea Pearl with a paper idea:

```python
approaches(noam, judea)
```

```plaintext
Hey Judea Pearl, wanna do a paper? We need to use IEEE style.
```

That was not what `judea` as a `Linguist` type would say to `noam`, a `ComputerScientist` type.
This is **single dispatch** and is the default feature available on most object-oriented languages, like Python or C++.
Single dispatch just act on the first argument of a function.
Since both of our researchers `noam` and `judea` are instantiate as types inherited from the same base type `Researcher` we cannot implement what we are trying to do in Python.
You would need to change your approach with a substancial loss of simplicity (you would probably need to create different functions with different names).

**Now let's do this in Julia**. First we'll create the base type `Researcher`:

```jl
sc(
"""
abstract type Researcher end
"""
)
```

We proceed, similar as before, by creating two derived types from the `Researcher` type:

```jl
sc(
"""
struct Linguist <: Researcher
    name::AbstractString
    age::Int64
end
"""
)
```

```jl
sc(
"""
struct ComputerScientist <: Researcher
    name::AbstractString
    age::Int64
end
"""
)
```

The final step is to define two new functions that will behave differently depending on which derived type of `Researcher` are the first or second argument:

```jl
sco(
"""
approaches(li::Linguist, cs::ComputerScientist) = "Hey \$(cs.name), wanna do a paper? We need to use APA style."

approaches(cs::ComputerScientist, li::Linguist) = "Hey \$(li.name), wanna do a paper? We need to use IEE style."
"""
)
```




Finally, let's instantiate our two researchers, `noam` and `judea`:

```jl
sc(
"""
noam = Linguist("Noam Chomsky", 92)
judea = ComputerScientist("Judea Pearl", 84)
"""
)
```

Again, let's see what Noam Chomsky will say when he approaches Judea Pearl with a paper idea:

```jl
sco(
"""
approaches(noam, judea)
"""
)
```


Perfect! It behaves just as we wanted! This is **multiple dispatch** and it is an important feature in Julia. Multiple dispatch acts on all arguments of a function and defines function behavior based on all argument's types.

Example adding `dogs`, `foxes` and `chickens` overloading the `Base.+` function with a footnote of warning.

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
