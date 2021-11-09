## Index and Summarize
## 索引和汇总

Let's go back to the example `grades_2020()` data defined before:
让我们回到之前定义过的例子grades_2020()：

```jl
sco("grades_2020()"; process=without_caption_label)
```

To retrieve a **vector** for `name`, we can access the `DataFrame` with the `.`, as we did previously with `struct`s in @sec:julia_basics:
我们可以使用（操作符）“.”访问DataFrame，获取由（表中）名字组成的向量，如同我们此前在@sec:julia_basics使用结构体一样：

```jl
@sco JDS.names_grades1()
```

or we can index a `DataFrame` much like an `Array` with symbols and special characters.
或者，我们可以更像使用数组一样，用符号标识（Symbols）或特殊字符对DataFrame进行索引。
The **second index is the column indexing**:
第二个索引是列索引：

```jl
@sco JDS.names_grades2()
```

Note that `df.name` is exactly the same as `df[!, :name]`, which you can verify yourself by doing:
“df.name”与“df[!, :name]”完全相同，你可以像下面这样操作来自行验证：

```
julia> df = DataFrame(id=[1]);

julia> @edit df.name
```

In both cases, it gives you the column `:name`.
两个例子中，都给出了“名字”列。
There also exists `df[:, :name]` which copies the column `:name`.
还有df[:, :name]，它拷贝了“名字”列。
In most cases, `df[!, :name]` is the best bet since it is more versatile and does an in-place modification.
大多情况下，使用df[!, :name]是最好的选择，因为它更加通用而且采用“就地修改”的方式。

For any **row**, say the second row, we can use the **first index as row indexing**:
对任意某行，比如第二行，我们可以使用第一个索引作为行索引。

```jl
s = """
    df = grades_2020()
    df[2, :]
    df = DataFrame(df[2, :]) # hide
    """
sco(s; process=without_caption_label)
```

or create a function to give us any row `i` we want:
或者生成一个函数，来提供给我们任何想要的行“i”：

```jl
@sco process=without_caption_label JDS.grade_2020(2)
```

We can also get only `names` for the first 2 rows using **slicing** (again similar to an `Array`):
我们还可以通过使用切片，只获取前两行的名字（这又与数组类似）：

```jl
@sco JDS.grades_indexing(grades_2020())
```

If we assume that all names in the table are unique, we can also write a function to obtain the grade for a person via their `name`.
如果我们假定表中的名字都是独一无二的，我们可以写出一个函数，通过每个人的名字来获取此人的等级。
To do so, we convert the table back to one of Julia's basic data structures (see @sec:data_structures) which is capable of creating mappings, namely `Dict`s:
为了这样做，我们将表转换回到Julia的能够生成映射的基本数据结构之一———字典：

```jl
@sco post=output_block grade_2020("Bob")
```

which works because `zip` loops through `df.name` and `df.grade_2020` at the same time like a "zipper":
字典如同zipper的zip循环一样，可以同时遍历df.name和df.grade_2020：

```jl
sco("""
df = grades_2020()
collect(zip(df.name, df.grade_2020))
""")
```

However, converting a `DataFrame` to a `Dict` is only useful when the elements are unique.
但是，仅当表中的各元素是独一无二时，将DataFrame转换为字典才有用。
Generally that is not the case and that's why we need to learn how to `filter` a `DataFrame`.
通常情况，表中的元素并非独一无二，这也是为什么我们需要学习如何对DataFrame进行筛选的原因。

## Filter and Subset {#sec:filter_subset}
## 筛选和子集

There are two ways to remove rows from a `DataFrame`, one is `filter` (@sec:filter) and the other is `subset` (@sec:subset).
有两种方式可以将行从DataFrame中移除。一种方式是“筛选”，而另一种是使用“子集”。
`filter` was added earlier to `DataFrames.jl`, is more powerful and more consistent with syntax from Julia base, so that is why we start discussing `filter` first.
`subset` is newer and often more convenient.
“筛选”早期就已加入进DataFrames.jl，功能更强，与Julia Base的语法也更一致，因此我们首先讨论“筛选”。“子集”比较新，而且通常更方便易用。

### Filter {#sec:filter}
### 筛选

From this point on, we start to get into the more powerful features of `DataFrames.jl`.
从现在起，我们开始深入到DataFrames.jl更强大的特性中了。
To do this, we need to learn some functions, such as `select` and `filter`.
为此，我们需要学习一些函数，比如“选取”和“筛选”。
But don't worry!
但无需过虑。
It might be a relief to know that the **general design goal of `DataFrames.jl` is to keep the number of functions that a user has to learn to a minimum[^verbs]**.
要知道，DataFrames.jl的设计目标，就是将使用者需要学习的函数数量保持在一个最低限度。了解了这点，是不是会让你放轻松些？

[^verbs]: According to Bogumił Kamiński (lead developer and maintainer of `DataFrames.jl`) on Discourse (<https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/5>).

Like before, we resume from the `grades_2020`:
如前，我们仍然从grades_2020开始：

```jl
sco("grades_2020()"; process=without_caption_label)
```

We can filter rows by using `filter(source => f::Function, df)`.
我们可以使用filter(source => f::Function, df)来对行进行筛选。
Note how this function is very similar to the function `filter(f::Function, V::Vector)` from Julia `Base` module.
该函数与Julia Base模块中的filter(f::Function, V::Vector)非常相似。
This is because `DataFrames.jl` uses **multiple dispatch** (see @sec:multiple_dispatch) to define a new method of `filter` that accepts a `DataFrame` as argument.
这是因为DataFrames.jl使用多重分派来定义筛选的一个新方法，这个方法可以接受DataFrame作为一个参数。


At first sight, defining and working with a function `f` for filtering can be a bit difficult to use in practice.
乍一看，在实践中定义及使用一个筛选函数有些难。
Hold tight, that effort is well-paid, since **it is a very powerful way of filtering data**.
但不要放弃（抓紧），这个付出会得到很好的回报，因为它是筛选数据非常有力的方法。
As a simple example, we can create a function `equals_alice` that checks whether its input equals "Alice":
简单举例，我们可以生成一个函数equals_alice，来检查是否输入为"Alice"：

```jl
@sco post=output_block JDS.equals_alice("Bob")
```

```jl
sco("equals_alice(\"Alice\")"; post=output_block)
```

Equipped with such a function, we can use it as our function `f` to filter out all the rows for which `name` equals "Alice":
“装备”了这样一个函数，我们可以使用它来筛选出所有名字为“Alice”的行：

```jl
s = "filter(:name => equals_alice, grades_2020())"
sco(s; process=without_caption_label)
```

Note that this doesn't only work for `DataFrame`s, but also for vectors:
这个筛选函数不仅仅可以用于DataFrames，也可以用于向量：

```jl
s = """filter(equals_alice, ["Alice", "Bob", "Dave"])"""
sco(s)
```

We can make it a bit less verbose by using an **anonymous function** (see @sec:function_anonymous):
通过使用匿名函数，我们可以使筛选函数更简洁一些：

```jl
s = """filter(n -> n == "Alice", ["Alice", "Bob", "Dave"])"""
sco(s)
```

which we can also use on `grades_2020`:
同样可以将其用于grades_2020：

```jl
s = """filter(:name => n -> n == "Alice", grades_2020())"""
sco(s; process=without_caption_label)
```

To recap, this function call can be read as "for each element in the column `:name`, let's call the element `n`, check whether `n` equals Alice".
简要概括，该函数调用，可以看作“对名字列中的每个元素——让我们称其为元素n——检查n是否为Alice”。
For some people, this is still too verbose.
对有些人来说，这仍然过于冗长。
Luckily, Julia has added a _partial function application_ of `==`.
幸运的是，Julia为“==”增加了一个偏函数（partial function）。
The details are not important -- just know that you can use it just like any other function:
具体细节不很重要——只要知道你可以像使用其它函数一样使用它就可以了：

```jl
sco("""
s = "This is here to workaround a bug in books" # hide
filter(:name => ==("Alice"), grades_2020())
"""; process=without_caption_label)
```

To get all the rows which are *not* Alice, `==` (equality) can be replaced by `!=` (inequality) in all previous examples:
如要获取所有不等于Alice的行，在此前的所有例子中，可以将== (等于)替换为!= (不等于)：

```jl
s = """filter(:name => !=("Alice"), grades_2020())"""
sco(s; process=without_caption_label)
```

Now, to show **why anonymous functions are so powerful**, we can come up with a slightly more complex filter.
现在来演示为何匿名函数如此强大有力，我们可以使用一个略微复杂的筛选。
In this filter, we want to have the people whose names start with A or B **and** have a grade above 6:
在这个筛选中，我们希望得到名字以A或B起始，且等级在6以上的人名清单：

```jl
s = """
    function complex_filter(name, grade)::Bool
        interesting_name = startswith(name, 'A') || startswith(name, 'B')
        interesting_grade = 6 < grade
        interesting_name && interesting_grade
    end
    """
sc(s)
```

```jl
s = "filter([:name, :grade_2020] => complex_filter, grades_2020())"
sco(s; process=without_caption_label)
```

### Subset {#sec:subset}
### 子集

The `subset` function was added to make it easier to work with missing values (@sec:missing_data).
子集函数是为了更容易地处理缺失值而添加的。
In contrast to `filter`, `subset` works on complete columns instead of rows or single values.
与筛选不同，子集处理整列，而不是行或单个值。
If we want to use our earlier defined functions, we should wrap it inside `ByRow`:
如果我们想使用之前定义的函数，需要将函数打包在ByRow内：

```jl
s = "subset(grades_2020(), :name => ByRow(equals_alice))"
sco(s; process=without_caption_label)
```

Also note that the `DataFrame` is now the first argument `subset(df, args...)`, whereas in `filter` it was the second one `filter(f, df)`.
还需注意，对于函数subset(df, args...)，DataFrame是它的第一个参数，而在筛选中，DataFrame是函数filter(f, df)的第二个参数。
The reason for this is that Julia defines filter as `filter(f, V::Vector)` and `DataFrames.jl` chose to maintain consistency with existing Julia functions that were extended to `DataFrame`s types by multiple dispatch.
此中原因是Julia将筛选定义为filter(f, V::Vector)，而DataFrames.jl选择与现有Julia函数保持一致，这些Julia函数可通过多重分派，扩展至DataFrames类型。

> **_NOTE:_**
> **_注意：_**
> Most of native `DataFrames.jl` functions, which `subset` belongs to, have a **consistent function signature that always takes a `DataFrame` as first argument**.
> 大多DataFrames.jl原生函数，包括“子集”，总是一致地将DataFrame作为第一个参数。

Just like with `filter`, we can also use anonymous functions inside `subset`:
如同“筛选”，我们可以在“子集”中使用匿名函数

```jl
s = "subset(grades_2020(), :name => ByRow(name -> name == \"Alice\"))"
sco(s; process=without_caption_label)
```

Or, the partial function application for `==`:
或者是对于“==”的偏函数：

```jl
s = "subset(grades_2020(), :name => ByRow(==(\"Alice\")))"
sco(s; process=without_caption_label)
```

Ultimately, let's show the real power of `subset`.
最终，让我们来展示“子集”的真正威力。
First, we create a dataset with some missing values:
首先，我们创建一个含有缺失值的数据集。

```jl
@sco salaries()
```

This data is about a plausible situation where you want to figure out your colleagues' salaries, and haven't figured it out for Zed yet.
这数据有关一种似是而非的情形：你想算出你同事的薪资，却没有算Z的薪资。
Even though we don't want to encourage these practices, we suspect it is an interesting example.
尽管我们不想鼓励这种情况实际发生，但我们可以设想这是一个有趣的例子。
Suppose we want to know who earns more than 2000.
假设我们想知道谁的薪水超过2000。
If we use `filter`, without taking the `missing` values into account, it will fail:
如果我们使用“筛选”而没有考虑到缺失值，筛选将无法成功进行。

```jl
s = "filter(:salary => >(2_000), salaries())"
sce(s, post=trim_last_n_lines(25))
```

`subset` will also fail, but it will fortunately point us towards an easy solution:
“子集”也会失败，但幸运的是，子集会指引我们通往解决方案的途径：

```jl
s = "subset(salaries(), :salary => ByRow(>(2_000)))"
sce(s, post=trim_last_n_lines(25))
```

So, we just need to pass the keyword argument `skipmissing=true`:
我们只需传递关键字参数skipmissing=true即可：

```jl
s = "subset(salaries(), :salary => ByRow(>(2_000)); skipmissing=true)"
sco(s; process=without_caption_label)
```

```{=comment}
Rik, we need a example of both filter and subset with multiple conditions, as in:
我们需要一个既有筛选又有子集的，复合情况的例子，如下：

`filter(row -> row.col1 >= something1 && row.col2 <= something2, df)`

and:

`subset(df, :col1 => ByRow(>=(something1)), :col2 => ByRow(<=(something2)>))
```
