# Why Julia? {#sec:why_julia}

The world of data science is filled with different open source programming languages.

Industry has, mostly, adopted Python and academia R.
**Why bother learning another language?**
To answer this question, we will address two common backgrounds:

1. **Did not program before** -- see @sec:non-programmers.

2. **Did program before** -- see @sec:programmers.

## For Non-Programmers {#sec:non-programmers}

In the first background, we expect the common underlying story to be the following.

Data science has captivated you, making you interested in learning what is it all about and how can you use it to build your career in academia or industry.
Then, you try to find resources to learn this new craft and you stumble into a world of intricate acronyms:
`pandas`, `dplyr`, `data.table`, `numpy`, `matplotlib`, `ggplot2`, `bokeh`, and the list goes on and on.

Out of the blue you hear a name: "Julia".
What is this?
How is it any different from other tools that people tell you to use for data science?

Why should you dedicate your precious time into learning a language that is almost never mentioned in any job listing, lab position, postdoc offer, or academic job description?
The answer is that **Julia is a fresh approach** to both programming and data science.
Everything that you do in Python or in R, you can do it in Julia with the advantage of being able to write readable[^readable], fast, and powerful code.
Therefore, the Julia language is gaining traction, and for good reasons.

So, **if you don't have any programming background knowledge, we highly encourage you to take up Julia** as a first programming language and data science framework.

## For Programmers {#sec:programmers}

In the second background, the common underlying story changes a little bit.
You are someone who knows how to program and probably does this for a living.
You are familiar with one or more languages and can easily switch between them.
You've heard about this new flashy thing called "data science" and you want to jump on the bandwagon.
You begin to learn how to do stuff in `numpy`, how to manipulate `DataFrames` in `pandas` and how to plot things in `matplotlib`.
Or maybe you've learned all that in R by using the tidyverse and `tibbles`, `data.frames`, `%>%` (pipes) and `geom_*`...

Then, from someone or somewhere you become aware of this new language called "Julia".
Why bother?
You are already proficient in Python or R and you can do everything that you need.
Well, let us contemplate some plausible scenarios.

**Have you ever in Python or R:**

1. Done something and were unable to achieve the performance that you needed?
Well, **in Julia, Python or R minutes can be translated to seconds**^[and sometimes milliseconds.].
We reserved @sec:julia_wild for displaying successful Julia use cases in both academia and industry.

2. Tried to do something different from `numpy`/`dplyr` conventions and discovered that your code is slow and you'll probably have to learn dark magic^[`numba`, or even `Rcpp` or `cython`?] to make it faster?
**In Julia you can do your custom different stuff without loss of performance**.

3. Had to debug code and somehow you see yourself reading Fortran or C/C++ source code and having no idea what you are trying to accomplish?
**In Julia you only read Julia code, no need to learn another language to make your original language fast**.
This is called the "two-language problem" (see @sec:two_language).
It also covers the use case for when "you had an interesting idea and wanted to contribute to an open source package and gave up because almost everything is not in Python or R but in C/C++ or Fortran"^[have a look at some deep learning libraries in GitHub and you'll be surprised that Python is only 25%-33% of the codebase.].

4. Wanted to use a data structure defined in another package and found that doesn't work and that you'll probably need to build an interface^[this is mostly a Python ecosystem problem, and while R doesn't suffer heavily from this, it's not blue skies either.].
**Julia allows users to easily share and reuse code from different packages.**
Most of Julia user-defined types and functions work right out of the box^[or with little effort necessary.] and some users marvelled upon discovering how their packages are being used by other libraries in ways that they could not have imagined.
We have some examples in @sec:multiple_dispatch.

5. Needed to have a better project management, with dependencies and version control tightly controlled, manageable, and replicable?
**Julia has an amazing project management solution and a great package manager**.
Unlike traditional package managers, which install and manage a single global set of packages, Julia's package manager is designed around "environments":
independent sets of packages that can be local to an individual project or shared between projects.
Each project maintains its own independent set of package versions.

If we got your attention by exposing somewhat familiar or plausible situations, you might be interested to learn more about this newcomer called Julia.

Let's proceed then!

## What Julia Aims to Accomplish? {#sec:julia_accomplish}

> **_NOTE:_**
> In this section we will explain the details of what makes Julia shine as a programming language.
> If it becomes too technical for you, you can skip and go straight to @sec:dataframes to learn about tabular data with `DataFrames.jl`.

The Julia programming language [@bezanson2017julia] is a relatively new language, first released in 2012, and aims to be **both easy and fast**.
It "runs like C^[sometimes even faster than C.] but reads like Python" [@perkelJuliaComeSyntax2019].
It was made for scientific computing, capable of handling **large amounts of data and computation** while still being fairly **easy to manipulate, create, and prototype code**.

The creators of Julia explained why they created Julia in a [2012 blogpost](https://julialang.org/blog/2012/02/why-we-created-julia/).
They said:

> We are greedy: we want more.
> We want a language that’s open source, with a liberal license.
> We want the speed of C with the dynamism of Ruby.
> We want a language that’s homoiconic, with true macros like Lisp, but with obvious, familiar mathematical notation like Matlab.
> We want something as usable for general programming as Python, as easy for statistics as R, as natural for string processing as Perl, as powerful for linear algebra as Matlab, as good at gluing programs together as the shell.
> Something that is dirt simple to learn, yet keeps the most serious hackers happy.
> We want it interactive and we want it compiled.

Most users are attracted to Julia because of the **superior speed**.
After all, Julia is a member of a prestigious and exclusive club.
The [**petaflop club**](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/) is comprised of languages who can exceed speeds of **one petaflop^[a petaflop is one thousand trillion, or one quadrillion, operations per second.] per second at peak performance**.
Currently only C, C++, Fortran, and Julia belong to the [petaflop club](https://www.nextplatform.com/2017/11/28/julia-language-delivers-petascale-hpc-performance/).

But, speed is not all that Julia can deliver.
The **ease of use**, **Unicode support**, and a language that makes **code sharing effortless** are some of Julia's features.
We'll address all those features in this section, but we want to focus on the Julia code sharing feature for now.

The Julia ecosystem of packages is something unique.
It enables not only code sharing but also allows sharing of user-created types.
For example, Python's `pandas` uses its own `Datetime` type to handle dates.
The same with R tidyverse's `lubridate` package, which also defines its own `datetime` type to handle dates.
Julia doesn't need any of this, it has all the date stuff already baked into its standard library.
This means that other packages don't have to worry about dates.
They just have to extend Julia's `DateTime` type to new functionalities by defining new functions and do not need to define new types.
Julia's `Dates` module can do amazing stuff, but we are getting ahead of ourselves now.
Let's talk about some other features of Julia.

### Julia Versus Other Programming Languages

In [@fig:language_comparison], a highly opinionated representation is shown that divides the main open source and scientific computing languages in a 2x2 diagram with two axes:
**Slow-Fast** and **Easy-Hard**.
We've omitted closed source languages because there are many benefits to allowing other people to run your code for free as well as being able to inspect the source code in case of issues.

We've put C++ and FORTRAN in the hard and fast quadrant.
Being static languages that need compilation, type checking, and other professional care and attention, they are really hard to learn and slow to prototype.
The advantage is that they are **really fast** languages.

R and Python go into the easy and slow quadrant.
They are dynamic languages that are not compiled and they execute in runtime.
Because of this, they are really easy to learn and fast to prototype.
Of course, this comes with a disadvantage:
they are **really slow** languages.

Julia is the only language in the easy and fast quadrant.
We don't know any other serious language that would want to be hard and slow, so this quadrant is left empty.

![Scientific Computing Language Comparisons: logos for FORTRAN, C++, Python, R and Julia.](images/language_comparisons.png){#fig:language_comparison}

**Julia is fast!
Very fast!**
It was designed for speed from the beginning.
It accomplishes this by multiple dispatch.
Basically, the idea is to generate very efficient LLVM[^LLVM] code.
LLVM code, also known as LLVM instructions, are very low-level, that is, very close to the actual operations that your computer is executing.
So, in essence, Julia converts your hand written and easy to read code to LLVM machine code which is very hard for humans to read, but easy for computers to read.
For example, if you define a function taking one argument and pass an integer into the function, then Julia will create a _specialized_ `MethodInstance`.
The next time that you pass an integer to the function, Julia will look up the `MethodInstance` that was created earlier and refer execution to that.
Now, the **great** trick is that you can also do this inside a function that calls a function.
For example, if some data type is passed into function `f` and `f` calls function `g` and the data types passed to `g` are known and always the same, then the generated function `g` can be hardcoded into function `f`!
This means that Julia doesn't even have to lookup `MethodInstances` any more, and the code can run very efficiently.
The trade-off, here, is that there are cases where earlier assumptions about the hardcoded `MethodInstances` are invalidated.
Then, the `MethodInstance` has to be recreated which takes time.
Also, the trade-off is that it takes time to infer what can be hardcoded and what not.
This explains why it can often take very long before Julia does the first thing:
in the background, it is optimizing your code.

The compiler in turns does what it does best: it optimizes machine code^[if you like to learn more about how Julia is designed you should definitely check @bezanson2017julia.].
You can find [benchmarks](https://julialang.org/benchmarks/) for Julia and several other languages here.
@fig:benchmarks was taken from [Julia's website benchmarks section^[please note that the Julia results depicted above do not include compile time.]](https://julialang.org/benchmarks/).
As you can see Julia is **indeed** fast.

![Julia versus other programming languages.](images/benchmarks.png){#fig:benchmarks}

We really believe in Julia.
Otherwise, we wouldn't be writing this book.
We think that Julia is the **future of scientific computing and scientific data analysis**.
It enables the user to develop rapid and powerful code with a simple syntax.
Usually, researchers develop code by prototyping using a very easy, but slow, language.
Once the code is assured to run correctly and fulfill its goal, then begins the process of converting the code to a fast, but hard, language.
This is known as the "Two-Language Problem" and we discuss next.

### The Two-Language Problem {#sec:two_language}

The "Two-Language Problem" is a very typical situation in scientific computing where a researcher devises an algorithm or a solution to tackle a desired problem or analysis at hand.
Then, the solution is prototyped in an easy to code language (like Python or R).
If the prototype works, the researcher would code in a fast language that would not be easy to prototype (C++ or FORTRAN).
Thus, we have two languages involved in the process of developing a new solution.
One which is easy to prototype but is not suited for implementation (mostly due to being slow).
And another which is not so easy to code, and consequently not easy to prototype, but suited for implementation because it is fast.
Julia avoids such situations by being the **same language that you prototype (ease of use) and implement the solution (speed)**.

Also, Julia lets you use **Unicode characters as variables or parameters**.
This means no more using `sigma` or `sigma_i`, and instead just use $σ$ or $σᵢ$ as you would in mathematical notation.
When you see code for an algorithm or for a mathematical equation, you see almost the same notation and idioms.
We call this feature **"One-To-One Code and Math Relation"** which is a powerful feature.

We think that the "Two-Language problem" and the "One-To-One Code and Math Relation" are best described by one of the creators of Julia, Alan Edelman, in a [TEDx Talk](https://youtu.be/qGW0GT1rCvs) [@tedxtalksProgrammingLanguageHeal2020].

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/qGW0GT1rCvs' frameborder='0' allowfullscreen></iframe></div>

### Multiple Dispatch {#sec:multiple_dispatch}

Multiple dispatch is a powerful feature that also allows us to extend existing functions or to define custom and complex behavior for new types.
To show how this works, we'll use an illustrative example.
Suppose that you want to define two new `struct`s for two different animals.
For simplicity, we won't be adding fields for the `struct`s:

```jl
s = """
    struct fox end
    struct chicken end
    """
sc(s)
```

Next, we want to define addition for both the `fox` and `chicken` types.
We proceed by defining a new function signature of the `+` operator from the `Base` module of Julia[^invs]:

[^invs]: this is an example for teaching purposes. Doing something similar to this example will result in many method invalidations (see <https://julialang.org/blog/2020/08/invalidations/> for details) and is, therefore, not a good idea.

```jl
s = """
    import Base: +
    +(F::fox, C::chicken) = "trouble"
    +(C::chicken, F::fox) = "trouble"
    +(C1::chicken, C2::chicken) = "safe"
    """
sco(s)
```

Now, let's call addition with the `+` sign on instantiated `fox` and `chicken` objects:

```jl
scob(
"""
my_fox = fox()
my_chicken = chicken()
my_fox + my_chicken
"""
)
```

And, as expected, adding two `chicken` objects together signals that they are safe:

```jl
s = """
    chicken_1 = chicken()
    chicken_2 = chicken()
    chicken_1 + chicken_2
    """
scob(s)
```

---

This is the power of multiple dispatch:
**we don't need everything from scratch for our custom-defined user types**.
If you are excited as much as we are by multiple dispatch, here are two more in-depth examples.
The first is a [fast and elegant implementation of a one-hot vector](https://storopoli.io/Bayesian-Julia/pages/1_why_Julia/#example_one-hot_vector) by @storopoli2021bayesianjulia.
The second is an interview with [Christopher Rackauckas](https://www.chrisrackauckas.com/) at [Tanmay Bakshi YouTube's Channel](https://youtu.be/moyPIhvw4Nk?t=2107) (see from time 35:07 onwards) [@tanmaybakshiBakingKnowledgeMachine2021].
Chris mentions that, while using [`DifferentialEquations.jl`](https://diffeq.sciml.ai/dev/), a package that he developed and currently maintains, a user filed an issue that his GPU-based quaternion ODE solver didn't work.
Chris was quite surprised by this request since he would never have expected that someone would combine GPU computations with quaternions and solving ODEs.
He was even more surprised to discover that the user made a small mistake and that it all worked.
Most of the merit is due to multiple dispatch and high user code/type sharing.

To conclude, we think that multiple dispatch is best explained by one of the creators of Julia:
[Stefan Karpinski at JuliaCon 2019](https://youtu.be/kc9HwsxE1OY).

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/kc9HwsxE1OY' frameborder='0' allowfullscreen></iframe></div>


## Julia in the Wild {#sec:julia_wild}

In @sec:julia_accomplish, we explained why we think Julia is such a unique programming language.
We showed simple examples about the main features of Julia.
If you would like to have a deep dive on how Julia is being used, we have some **interesting use cases**:

1. NASA uses Julia in a supercomputer to analyze the ["Largest Batch of Earth-Sized Planets Ever Found"](https://exoplanets.nasa.gov/news/1669/seven-rocky-trappist-1-planets-may-be-made-of-similar-stuff/) and achieve a whopping **1,000x speedup** to catalog 188 million astronomical objects in 15 minutes.
2. [The Climate Modeling Alliance (CliMa)](https://clima.caltech.edu/) is using mostly Julia to **model climate in the GPU and CPU**.
Launched in 2018 in collaboration with researchers at Caltech, the NASA Jet Propulsion Laboratory, and the Naval Postgraduate School, CliMA is utilizing recent progress in computational science to develop an Earth system model that can predict droughts, heat waves, and rainfall with unprecedented precision and speed.
3. [US Federal Aviation Administration (FAA) is developing an **Airborne Collision Avoidance System (ACAS-X)** using Julia](https://youtu.be/19zm1Fn0S9M).
This is a nice example of the "Two-Language Problem" (see @sec:julia_accomplish).
Previous solutions used Matlab to develop the algorithms and C++ for a fast implementation.
Now, FAA is using one language to do all this: Julia.
4. [**175x speedup** for Pfizer's pharmacology models using GPUs in Julia](https://juliacomputing.com/case-studies/pfizer/).
It was presented as a [poster](https://chrisrackauckas.com/assets/Posters/ACoP11_Poster_Abstracts_2020.pdf) in the 11th American Conference of Pharmacometrics (ACoP11) and [won a quality award](https://web.archive.org/web/20210121164011/https://www.go-acop.org/abstract-awards).
5. [The Attitude and Orbit Control Subsystem (AOCS) of the Brazilian satellite Amazonia-1 is **written 100% in Julia**](https://discourse.julialang.org/t/julia-and-the-satellite-amazonia-1/57541) by [Ronan Arraes Jardim Chagas](https://ronanarraes.com/)
6. [Brazil's national development bank (BNDES) ditched a paid solution and opted for open-source Julia modeling and gained a **10x speedup**.](https://youtu.be/NY0HcGqHj3g)

If this is not enough, there are more case studies in [Julia Computing website](https://juliacomputing.com/case-studies/).

[^readable]: no C++ or FORTRAN API calls.
[^LLVM]: LLVM stands for **L**ow **L**evel **V**irtual **M**achine, you can find more in [llvm.org](http://llvm.org).
