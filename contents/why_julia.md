# Why Julia? {#sec:why_julia}

数据科学的世界里有各种各样的开源编程软件。

在工业界大多数采用 Python ，在学术界大多数采用 R。

**那么为什么要花心思去学习另外一种语言呢？**

为了回答这个问题，我们将讨论以下两个常见的背景：

1. 在之前从来没有接触过编程 -- 详见 @sec:non-programmers.
2. 之前有过编程经验 -- 详见 @sec:programmers.

## 对没有编程经历的人 {#sec:non-programmers}

在第一个背景的讨论中，我们将叙述的内容大致如下。

或许您着迷于数据科学，渴望了解它的全部内容以及想利用数据科学在学术界或工业界建立自己的职业生涯。

然后您会尝试着寻找资源来学习这种新的工具，却会发现数据科学是一个到处都是复杂的首字母缩略词的世界：
`pandas`, `dplyr`, `data.table`, `numpy`, `matplotlib`, `ggplot2`, `bokeh`, 这样的例子有很多很多。

偶然的机会，你会听到“Julia”的名字。

这是什么？

它与其他人告诉您用于数据科学的其他工具有何不同？

为什么要花费宝贵的时间学习一门从来没有出现在任何工作岗位、实验室职位、博士后offer或者是学术岗位要求中提到的编程语言？

答案是**Julia是一种全新方法**，可以把数据科学和编程结合在一起。

您在 Python 或者 R 中所做的一切，同样可以在 Julia 中完成，并且能够编写可读性强[^readable]、编译速度快并且强大的代码。

因此，Julia 语言有充分的理由越来越受到人们的关注。

那么，**如果您没有任何编程语言背景的话，**我们强烈建议您将Julia作为您的第一个编程语言工具，搭建您自己的数据科学框架 。

## 对有编程经历的人 {#sec:programmers}

在第二个背景的讨论中，我们将叙述的内容会稍有不同。

您是一个知道如何编程并且可能利用编程工具谋生的人。您熟悉一种或多种语言，可以轻松地在这些语言中切换。

您听说过有个叫做“数据科学”的新名词，您也想融入到它的世界里。

您开始学习如何在`numpy`中处理问题，如何在`pandas`里操作`DataFrame`，以及如何利用`matplotlib`进行画图。

或者，您可能已经在 R 中通过使用 tidyverse 和 `tibbles`, `data.frames`, `%>%` (管道) 以及`geom_*`学习到这些所有知识。

然后，您会从某人或某一个地方了解到一种名叫“Julia”的新语言。

那么，为什么需要去了解它呢？

您已经精通了 Python 或者 R，您可以利用它们完成您需要的工作。

现在，让我们考虑一些可能出现的情况。

**您有没有用 Python 或 R：**

1. 做过一些事情，但是无法达到您所需要的性能？

   如果有的话，在 Julia 中，Python 或者 R 语言运行时间可以从分钟转换成秒的量级。

   我们保留了 @sec:julia_wild 用于展示在学术界和工业界中成功编写Julia的案例。

2. 尝试做一些与`numpy`/`dplyr`约定不同的事情，这样会发现您的代码运行很慢，因此您可能需要学习一些魔法语言^[`numba`, 甚至 `Rcpp` 或 `cython`?] 来使得代码变快?

   **在Julia中，您可以在不损失性能的情况下执行自定义的不同代码内容。**

3. 当您不得不调试代码，并阅读 Fortran 或者 C/C++ 源代码的时候，不清楚自己需要完成什么？

   **在 Julia 中仅仅需要阅读 Julia 代码，不需要去学习另外的语言即可快速使用您的原始编程语言。**
   这被称作是“两语言问题”（详见 @sec:two_language）。

   它还涵盖了”当您有一个有趣的想法并希望为开源库做出一些贡献，但是几乎所有的内容都不是通过 Python 或者 R 语言编写的，而是通过 C/C++ 或者 Fortran，使得您不得不放弃“^[可以在 Github 中发现一些深度学习的开源库，其中利用 Python 编写的仅占代码的 25%-33% 。]。

4. 想要使用另外一种编程语言定义的数据结构，但是发现在目前的编程语言里不起作用，这意味着您可能需要建立一套新的接口^[这是在Python中最常见的问题，虽然R语言不怎么受影响，但是R语言也不完全没有问题。]。

   **Julia允许用户轻易的分享和重复使用其他不同库的代码。**

   大部分的Julia用户-定义的类型和函数都是开箱即用的

   ^[不需要费很多劲。]，而一些用户会惊讶地发现其他的库是如何以他们无法想象的方式来使用他们的包。
   具体的例子可以查阅 @sec:multiple_dispatch.

1. 需要有较好的项目管理，例如依赖性和版本紧密结合，可管理，以及可复制？

  Julia拥有令人惊叹的项目管理方案和极棒的库管理。

  与安装和管理单个全局库的传统库管理不同，Julia的库管理是围绕“环境”设计的：独立的库集，可以是单个项目的本地库，也可以是在项目之间贡献的库。每个项目都维护独属于自己的一组版本库。

如果我们通过描述一些您熟悉或者是类似的情形而引起了您的注意，那么您可能会有兴趣了解更多关于这位名叫Julia的新人的信息。

那么，让我们继续吧！

## Julia的目的是为了完成什么？{#sec:julia_accomplish}

> **_NOTE:_**
>
> 在本节中，我们将详细解释让 Julia 大放异彩的原因。
> 如果它对您来说太技术化了，您可以跳过并直接转到 @sec:dataframes 以了解使用 `DataFrames.jl`的表格数据。

Julia编程语言 [@bezanson2017julia] 是一个相对比较新的语言, 第一次公开是在2012年，为了要同时达到**容易使用和运行速度快**的目的。

它“运行起来就像C^[有时甚至比C快。]但是阅读起来和Python一样容易”[@perkelJuliaComeSyntax2019]。

它是为科学计算而生的，能够处理**庞大的数据和计算**，同时保持着**易于操作、创建和原型的代码** 。

Julia的创立者在 [2012 blogpost](https://julialang.org/blog/2012/02/why-we-created-julia/) 中解释了他们建立Julia的初衷。
他们提到:

> 我们很贪心: 我们想同时获得很多东西。
> 我们想要一种开源的编程语言，具有相对公开的许可。
>
> 我们希望这种语言具有C语言的速度和Ruby语言的活力。
>
> 我们希望这种语言具有同像性，具有像Lisp那样的宏，并且类似Matlab那样具有明显、熟悉的数学符号。
>
> 我们希望这种语言类似Python一样适用于普通的编程，像R语言一样易于统计，像Perl一样可以自然地处理字符串，像Matlab一样强大的线性代数处理能力，以及像shell脚本语言一样擅长将程序组合在一起。
>
> 并且希望这种语言学习起来非常简单，同时可以让大多数认真的黑客感到高兴。
>
> 我们还希望它是交互式的，并且能够被编译。

大部分的用户被Julia吸引是由于超级快的速度。

毕竟，Julia是一个享有声誉的专属俱乐部成员。
[**petaflop club**](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/) 是一个由速度可以超过一个 petaflop^[一个 petaflop是每秒1000万亿次或1000亿次操作] 每秒时的峰值性能**.
目前，只有 C，C++，Fortran和Julia属于 [petaflop club](https://www.nextplatform.com/2017/11/28/julia-language-delivers-petascale-hpc-performance/) 这一俱乐部。

但是，速度并不是 Julia 所能提供的全部。
**易于使用**、**支持Unicode **以及一种可以使**代码共享毫不费力**是 Julia 的另外一些功能。
我们将在本节中讨论所有这些功能，但现在我们主要讨论 Julia 代码共享功能。

Julia 的库生态系统是独一无二的。
它不仅可以共享代码，还可以共享用户创建的类型。
例如，Python 的 `pandas` 使用它自己的 `Datetime` 类型来处理日期类型的数据。
与 R tidyverse 的 `lubridate` 包相同，它也定义了自己的 `datetime` 类型来处理日期类型的数据。

Julia 不需要任何这些库，因为它已经将所有日期内容放入其标准库中。
这意味着其他包不必担心日期的问题。
他们只需要通过定义新函数将 Julia 的 `DateTime` 类型扩展到新功能，而不需要定义新类型。
Julia 的`Dates` 模块已经可以做很多了不起的事情，但我们现在想要做的不止这些。
让我们来谈谈 Julia 的其他一些特性。

### Julia与其他编程语言

在 [@fig:language_comparison]这部分, 显示了一个清晰的结果，它将主要的开源科学计算语言划分为具有两个轴的 2x2 图表：**慢-快**和**易-难**。我们省略了闭源的语言，因为允许其他人免费运行您的代码可以在出现问题时方便检查源代码。

我们把 C++ 和 FORTRAN 分类为学习难度高和速度快的类别。
作为需要编译、类型检查和其他专业关注和关注的静态语言，它们真的很难学习，而且编写代码的速度很慢。
优点是这些语言的**速度非常快**。

把R语言和Python分类为学习难度低，速度慢的类别。

这类语言是不需要编译，并且在运行的时候执行的动态语言

正因为这个原因，它们很容易学习并且可以很快速的编写出代码。

当然，这有一个缺点：

它们是**非常慢**的语言。

Julia是分类为容易学习并且速度快的唯一语言。

我们不希望任何一种语言是难以学习并且运行速度极慢的，因此没有任何一种语言是属于这类别。

![Scientific Computing Language Comparisons: logos for FORTRAN, C++, Python, R and Julia.](images/language_comparisons.png){#fig:language_comparison}

 **Julia很快！**

**Julia非常快！**

它从一开始就是为速度而设计的。

它通过多次分发来实现这一点。

基本上，这个想法是生成效率非常高的 LLVM[^LLVM] 代码。
LLVM 代码， 也称为LLVM指令，是非常底层的，即非常接近您的计算机正在执行的实际操作。

因此，本质上，Julia 将您编写的易于阅读的代码转换为 LLVM 机器代码，这对于人类来说很难阅读，但对于计算机来说却很容易阅读。

例如，如果您定义一个函数，它接受一个参数并将一个整数传递给该函数，那么 Julia 将创建一个 _特殊化的_ `MethodInstance`。
下次您将整数传递给函数时，Julia 将查找之前创建的 `MethodInstance` 并引用它的执行。
现在，**最巧妙的**技巧是您也可以在调用函数的函数中执行此操作。
例如，如果将某种数据类型传递给函数 `f` 并且 `f` 调用函数 `g`，并且传递给 `g` 的数据类型是已知的并且始终相同，那么生成的函数 `g` 可以硬编码为函数`f`！

这意味着这意味着 Julia 甚至不必再查找`MethodInstances`，并且代码可以非常高效地运行。

需要权衡的是，在某些情况下，有关硬编码的`MethodInstances`的早期假设无效。
然后，必须重新创建`MethodInstance`，这需要额外的时间。

此外，需要权衡推断哪些可以硬编码，哪些不能硬编码，这也需要时间。
这也解释了为什么 Julia 在做第一次运行通常需要很长时间：
因为在后台，它正在优化您的代码。

编译器接着会做它最擅长的事情：它优化机器代码^[如果你想了解更多关于 Julia 是如何设计的，你一定要查看@bezanson2017julia。]。您可以在此处找到 Julia 和其他几种语言的 [benchmarks](https://julialang.org/benchmarks/)。
@fig:benchmarks 取自 [Julia 的网站基准测试部分^[请注意，上面描述的 Julia 结果不包括编译时间。]](https://julialang.org/benchmarks/)。
如您所见，Julia **确实**快。

![Julia versus other programming languages.](images/benchmarks.png){#fig:benchmarks}

我们真的相信Julia。
否则，我们就不会写这本书。
我们认为 Julia 是**科学计算和数据科学分析的未来**。
它让用户能够使用简单的语法开发速度快而强大的代码。
通常，研究人员使用一种非常简单但速度较慢的语言，然后通过原型设计来编写代码。
一旦确保代码正确运行并能够实现其目标，就开始将代码转换为快速但困难的语言。
这被称为“双语问题”，我们在接下来将讨论这一问题。

### 双语问题 {#sec:two_language}

“双语问题”是科学计算中非常典型的一种情况，研究人员通过设计算法来解决或分析手头的问题。
然后，使用易于编码的语言（如 Python 或 R）对解决方案进行原型设计。
如果原型可行，研究人员将使用一种不容易原型化，但是速度快的语言（C++ 或 FORTRAN）进行编码。
因此，我们会经历两种语言参与开发新解决方案的过程。

一种易于原型化但不适合实现的（主要是由于速度慢）。
另一个不太容易编码，因此也不容易原型化，但适合实现，因为它很快。
Julia 避免了这种情况，**可以和您设计代码原型（易用性）并且实现解决方案（速度）** 的语言相同。

此外，Julia 允许您使用 **Unicode 字符作为变量或参数**。

这意味着不用再使用 `sigma`或者`sigma_i`，而是可以用 $σ$ 或者 $σᵢ$ 就像你在数学符号中所写的那样。

当您看到算法或数学方程的代码时，您会看到几乎相同的符号和习惯用语。
我们将此功能称为**“和数学一对一的代码关系”**，这是一个强大的功能。

我们认为Julia的创造者之一在 [TEDx Talk](https://youtu.be/qGW0GT1rCvs) [@tedxtalksProgrammingLanguageHeal2020]中很好的解释了“双语问题”和“和数学一对一的代码关系”这两个问题

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/qGW0GT1rCvs' frameborder='0' allowfullscreen></iframe></div>

### 多重派发 {#sec:multiple_dispatch}

多重派发是一项强大的功能，它允许我们扩展现有功能或自定义新类型的定义，以及一些复杂的行为。
假设您要定义两个新的 `struct` 来表示两种不同的动物：

```jl
s = """
    abstract type Animal end
    struct Fox <: Animal
        weight::Float64
    end
    struct Chicken <: Animal
        weight::Float64
    end
    """
sc(s)
```

基本上，这就是“定义作为动物的狐狸”和“定义作为动物的鸡”。
接下来，我们可能有一只名叫 Fiona 的狐狸和一只名叫 Big Bird 的鸡。

```jl
s = """
    fiona = Fox(4.2)
    big_bird = Chicken(2.9)
    """
sc(s)
```

接下来，我们想知道它们加在一起的重量，我们可以为此编写一个函数：

```jl
sco("combined_weight(A1::Animal, A2::Animal) = A1.weight + A2.weight")
```

我们想知道这样子做是否是对的。
实现这一点的一种方法是使用条件：

```jl
s = """
    function naive_trouble(A::Animal, B::Animal)
        if A isa Fox && B isa Chicken
            return true
        elseif A isa Chicken && B isa Fox
            return true
        elseif A isa Chicken && B isa Chicken
            return false
        end
    end
    """
sco(s)
```

现在，让我们看看把fiona和big_bird放在一起会不会报错：

```jl
scob("naive_trouble(fiona, big_bird)")
```

Okay，这看起来不错。

写`naive_trouble`函数似乎是很容易的。然而，使用多重派发来构建一个新的函数`trouble`有它的优点。让我们按如下方式创建我们所需的新函数：

```jl
s = """
    trouble(F::Fox, C::Chicken) = true
    trouble(C::Chicken, F::Fox) = true
    trouble(C1::Chicken, C2::Chicken) = false
    """
sco(s)
```

在定义这些方法后，`trouble`给出与`naive_trouble`相同的结果。

例如：

```jl
scob("trouble(fiona, big_bird)")
```

把Big Bird和另一只叫做Dora的Chicken放在一起也可以起作用：

```jl
s = """
    dora = Chicken(2.2)
    trouble(dora, big_bird)
    """
scob(s)
```

因此，在这种情况下，多重派发的好处是您只需声明类型，Julia 就会为您的类型找到正确的方法。
更重要的是，对于在代码中使用多重派发的许多情况，Julia 编译器实际上会优化函数调用。
例如，我们可以这样写：

```
function trouble(A::Fox, B::Chicken, C::Chicken)
    return trouble(A, B) || trouble(B, C) || trouble(C, A)
end
```

根据上下文，Julia 可以将其优化为：

```
function trouble(A::Fox, B::Chicken, C::Chicken)
    return true || false || true
end
```

因为编译器**知道**`A`是一只Fox，`B`是一只Chicken，所以这可以用 `trouble(F::Fox, C::Chicken)`方法的内容来替换。
 `trouble(C1::Chicken, C2::Chicken)`也是如此。
接下来，编译器将其优化为：

```
function trouble(A::Fox, B::Chicken, C::Chicken)
    return true
end
```

多重派发的另一个好处是，当其他人想将现有动物与他们的动物Zebra进行比较时，这是允许的。
在他们的库中，他们可以定义一个 Zebra：

```jl
s = """
    struct Zebra <: Animal
        weight::Float64
    end
    """
sc(s)
```

以及与现有动物的结合将这么进行：

```jl
s = """
    trouble(F::Fox, Z::Zebra) = false
    trouble(Z::Zebra, F::Fox) = false
    trouble(C::Chicken, Z::Zebra) = false
    trouble(Z::Zebra, F::Fox) = false
    """
sco(s)
```

现在，我们可以检查Marty（我们的Zebra）和Big Bird是否安全：

```jl
s = """
    marty = Zebra(412)
    trouble(big_bird, marty)
    """
scob(s)
```

更好的地方是，我们可以计算**Zebra和其他动物的总重量，并且不需要在另外定义任何额外的函数**：

```jl
scob("combined_weight(big_bird, marty)")
```

因此，总而言之，仅考虑 Fox 和 Chicken 编写的代码甚至适用于 **以前从未见过的类型**！
实际上，这意味着 Julia 通常可以轻松地重用其他项目中的代码。
如果您和我们一样对多次派发感到兴奋，这里有两个更深入的例子。
第一个是@storopoli2021bayesianjulia 的 [fast and elegant implementation of a one-hot vector](https://storopoli.io/Bayesian-Julia/pages/1_why_Julia/#example_one-hot_vector)。
第二个是在 [Tanmay Bakshi YouTube's Channel](https://youtu.be/moyPIhvw4Nk?t=2107) 对 [Christopher Rackauckas](https://www.chrisrackauckas.com/) 的采访（见时间 35： 07 起）中[@tanmaybakshiBakingKnowledgeMachine2021]。
Chris 提到，在使用 [`DifferentialEquations.jl`](https://diffeq.sciml.ai/dev/)（目前由他开发并维护的一个包）时，一位用户提出了一个问题，即他的基于 GPU 的四元数 ODE 求解器没有用。
Chris 对这个问题感到非常惊讶，因为他从没想过有人会将 GPU 计算与四元数和求解 ODE 结合起来。
他更惊讶地发现这个用户犯了一个小错误，但是一切似乎是正常运行的。
这是因为Julia多重派发和高度的用户代码/类型分享的优点。

总而言之，我们认为 Julia 的创造者之一最好地解释了多重派发：
[Stefan Karpinski in JuliaCon 2019](https://youtu.be/kc9HwsxE1OY)。

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/kc9HwsxE1OY' frameborder='0' allowfullscreen></iframe></div>

## Julia in the Wild {#sec:julia_wild}

在@sec:julia_accomplish 中，我们解释了为什么我们认为 Julia 是一种独特的编程语言。
我们展示了有关 Julia 主要功能的简单示例。
如果您想深入了解 Julia 的使用方式，可以进一步查看我们有一些**有趣的用例**：

1. NASA 在超级计算机上使用 Julia 进行分析 ["Largest Batch of Earth-Sized Planets Ever Found"](https://exoplanets.nasa.gov/news/1669/seven-rocky-trappist-1-planets-may-be-made-of-similar-stuff/) 并在 15 分钟内实现 **1,000 倍加速**，用以对 1.88 亿个天体进行编目。

2. [The Climate Modeling Alliance (CliMa)](https://clima.caltech.edu/) 主要在Julia中使用**GPU 和 CPU 进行构建气候模型**。
  CliMA 于 2018 年与加州理工学院、美国宇航局喷气推进实验室和海军研究生院的研究人员合作推出，正在利用计算科学的最新进展开发地球系统模型，该模型可以以前所未有的精度和预测预测干旱、热浪和降雨。速度。

3. [US Federal Aviation Administration (FAA) is developing an **Airborne Collision Avoidance System (ACAS-X)** using Julia](https://youtu.be/19zm1Fn0S9M).

  这是“双语问题”的一个很好的例子（见@sec:julia_accomplish）。
  以前的解决方案使用 Matlab 来开发算法，然后利用 C++ 快速实现。
  现在，FAA 正在使用一种语言来完成所有这些工作：Julia。

4. [**175x speedup** for Pfizer's pharmacology models using GPUs in Julia](https://juliacomputing.com/case-studies/pfizer/).
  它在第 11 届美国药物计量学会议 (ACoP11) 上作为 [海报](https://chrisrackauckas.com/assets/Posters/ACoP11_Poster_Abstracts_2020.pdf) 发表并 [赢得优异（quality）奖](https://web.archive.org/web/20210121164011/https://www.go-acop.org/abstract-awards)。

5. [The Attitude and Orbit Control Subsystem (AOCS) of the Brazilian satellite Amazonia-1](https://discourse.julialang.org/t/julia-and-the-satellite-amazonia-1/57541) 由 Ronan Arraes Jardim Chagas  **全部用 Julia** 编写 (<https://ronanarraes.com/>).

6. [Brazil's national development bank (BNDES) ditched a paid solution and opted for open-source Julia modeling and gained a **10x speedup**.](https://youtu.be/NY0HcGqHj3g)

如果这些还不够让您熟悉Julia，您可以自行查阅 [Julia Computing website](https://juliacomputing.com/case-studies/).

[^readable]: no C++ or FORTRAN API calls.
[^LLVM]: LLVM stands for **L**ow **L**evel **V**irtual **M**achine, you can find more at the LLVM website (<http://llvm.org>).

