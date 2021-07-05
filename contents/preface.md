# Preface {#sec:preface}

In this preface, we discuss two important aspects of data analysis.
Actually, there is a third one, Julia, but it deserves a whole chapter (see [@sec:why_julia]).

First, we emphasize the **"data" part of Data Science** and why data skills are, and will remain, in **high demand** both in industry and academia.

Second, we make an argument for **incorporate software engineering practices into data science** which should reduce friction in updating and sharing code with collaborators.
Most of data analyses are a collaborative endeavor, these practices should come in handy.

## Why Data Science? {#sec:why_data_science}

Data Science is not only machine learning and statistics, also it is not all about prediction, alas, it is not even a discipline fully contained within STEM (Science, Technology, Engineering, and Mathematics) fields [@Meng2019Data].
But one thing we can assure with highly confidence is that **data is always involved**.
Our aim in this book is two-fold:

* First, we want to focus on the backbone of data science: data.
* Second, we want you to use Julia.

We will cover why we think you should use Julia in [@sec:why_julia].
For now, let's turn our attention towards data.

### Data is Everywhere {#sec:data_everywhere}

![Yes, data is the new black.](images/data-everywhere.png){#fig:data_everywhere}

**Data is abundant** and will be even more in the near future.
A report from the end of 2012 concluded that from 2005 to 2020, the amount of data stored digitally will **grow by a factor of 300, from 130 exabytes^[1 exabyte (EB) = 1,000,000 terabyte (TB).] to a whooping 40,000 exabytes** [@gantz2012digital].
This is equal to 40 trillion gigabytes and, to put in perspective, more than **5,200 gigabytes for every living human currently in this planet!**
In 2020, on average every person created **1.7 MB of data per second** [@domo2018data].
A recent report predicted that almost **two thirds (65%) of national GDPs will will have undergone digitization by 2022** [@fitzgerald2020idc].

Every profession will be impacted not only by the increasing availability of data but also by data's increased importance [@chen2014big; @khan2014big].
This is why data skills are important.
In order to become the researcher or professional that the world is demanding right now you need to feel comfortable around data.
You need to become a **data literate**.

### Data Literacy {#sec:data_literacy}

According to [Wikipedia](https://en.wikipedia.org/wiki/Data_literacy), the formal definition of **data literacy is "the ability to read, understand, create, and communicate data as information."**.
We also like the informal idea that, as a data literate, you won't feel overwhelmed by data, quite the contrary, you would feel empowered by it.

Data literacy can be seen as a highly competitive skill to possess.
In this book we'll cover two aspects of data literacy:

1. **Data Manipulation** with DataFrames.jl ([@sec:dataframes]).
In this chapter you will learn how to:
    1. Read CSV and Excel data from disk and from the internet
    2. ...
    3. ...
1. **Data Visualization** with Plots.jl and Makie.jl ([@sec:plots] and [@sec:makie]).
In these chapter you will learn how to:
    1. ...
    2. ...
    3. ...

## Software engineering and data science {#sec:engineering}

Unlike most books on data science, this book lays more emphasis on **properly structuring code**.
The reason for this is that we noticed that many data scientists simply place their code in one large file and run all the statements sequentially.
You can think of this as writing a book for someone and forcing that person to read it from beginning to start.
This works great for small and simple projects, but the bigger or more complex the project becomes, more problems will start to arise.
For example, with a well written book: the book is split into distinctly named chapters and sections which contains several references to other parts in the book.
The software equivalent of this is **splitting code into functions**.
Each function has a name and some contents.
With functions, you can basically tell the computer at any point in your code to jump to some other place and continue from there.
This allows you to more easily re-use code between projects, update code, share code, collaborate and see big picture.
Hence, with functions, you can **save time**.

So, when reading this book, you eventually will get accustomed to reading and using functions.
Also, another benefit of having good software engineering skills is that it will allow you to more easily read packages's source code that you're using, which could be greatly beneficial when you are debugging your code or wonder how exactly the code works.
Finally, you can rest assured that we do not att all invented ourselves this emphasis on functions.
In industry, it is common practice to encourage developers to use **"functions instead of comments"**.
That means that, instead of writing a comment for humans and some code for the computer, the developers write a function which is universally read by humans and computers.

## Acknowledgements

Many people have contributed directly and indirectly to this book.
Rik would like to thank his PhD supervisors, [Peter de Jonge](https://www.rug.nl/staff/peter.de.jonge/), [Ruud den Hartigh](https://www.rug.nl/staff/j.r.den.hartigh/) and [Frank Blaauw](https://frankblaauw.nl/), for their support.
