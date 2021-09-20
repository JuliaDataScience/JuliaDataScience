# Preface {#sec:preface}

There are many programming languages and each and every one of them has its strengths and weaknesses.
Some languages are very quick, but verbose.
Other languages are very easy to write in, but slow. This is known as the `two-language` problem and `Julia` aims at circumventing this problem. 
Even though all three of us come from different fields, we all found the Julia language more effective for our research than languages that we've used before.
We discuss some of our arguments in @sec:why_julia.
Compared to other languages, Julia is one of the newest languages around.
This means that the ecosystem around the language is sometimes difficult to navigate through.
It's difficult to figure out where to start and how all the different packages fit together.
That is why we decided to create this book!
We wanted to make it easier for researchers, and especially our colleagues, to start using this awesome language.

Like discussed above, each language has its strengths and weaknesses.
In our opinion, data science is definitely a strength of Julia.
At the same time, all three of us used data science tools in our day to day life.
And, probably, you want to use data science too!
That is why this book has a focus on data science.

In the next part of this section, we emphasize the **"data" part of data science** and why data skills are, and will remain, in **high demand** in industry as well as in academia.
We make an argument for **incorporate software engineering practices into data science** which should reduce friction in updating and sharing code with collaborators.
Most data analyses are a collaborative endeavor; that is why these practices will help you.

### Data is Everywhere {#sec:data_everywhere}

**Data is abundant** and will be even more in the near future.
A report from late 2012 concluded that from 2005 to 2020, the amount of data stored digitally will **grow by a factor of 300, from 130 exabytes^[1 exabyte (EB) = 1,000,000 terabyte (TB).] to a whooping 40,000 exabytes** [@gantz2012digital].
This is equal to 40 trillion gigabytes and, to put it into perspective, more than **5.2 terabytes for every living human currently in this planet!**
In 2020, on average, every person created **1.7 MB of data per second** [@domo2018data].
A recent report predicted that almost **two thirds (65%) of national GDPs will have undergone digitization by 2022** [@fitzgerald2020idc].

Every profession will be impacted by the increasing availability of data and data's increased importance [@chen2014big; @khan2014big].
Data is used to communicate and build knowledge, and to make decisions.
This is why data skills are important.
If you become comfortable with handling data, you will become a valuable researcher or professional.
In other words, you will become **data literate**.

## What is Data Science? {#sec:why_data_science}

Data science is not only machine learning and statistics, also, it is not all about prediction.
Alas, it is not even a discipline fully contained within STEM (Science, Technology, Engineering, and Mathematics) fields [@Meng2019Data].
But, one thing that we can assure with high confidence is that data science is always about **data**.
Our aims of this book are twofold:

* We focus on the backbone of data science: data.
* We use the Julia programming language to process the data.

We cover why Julia is an extremely effective language for data science in @sec:why_julia.
For now, let's turn our attention towards data.

### Data Literacy {#sec:data_literacy}

According to [Wikipedia](https://en.wikipedia.org/wiki/Data_literacy), the formal definition of **data literacy is "the ability to read, understand, create, and communicate data as information."**.
We also like the informal idea that, as a data literate, you won't feel overwhelmed by data, but instead can use it to make the right decisions.
Data literacy can be seen as a highly competitive skill to possess.
In this book we'll cover two aspects of data literacy:

1. **Data Manipulation** with `DataFrames.jl` (@sec:dataframes).
In this chapter you will learn how to:
    1. Read CSV and Excel data into Julia.
    2. Process data in Julia, that is, learn how to answer data questions.
1. **Data Visualization** with `Plots.jl` and `Makie.jl` (@sec:datavisPlots and @sec:datavisMakie).
In these chapter you will learn how to:
    1. ...
    2. ...
    3. ...

## Software Engineering {#sec:engineering}

Unlike most books on data science, this book lays more emphasis on properly **structuring code**.
The reason for this is that we noticed that many data scientists simply place their code into one large file and run all the statements sequentially.
You can think of this like forcing book readers to always read it from beginning to end, and without being allowed to revisit earlier sections or jumping to interesting sections right away.
This works fine for small and simple projects, but the bigger or more complex the project becomes, more problems will start to arise.
For example, in a well written book, the book is split into distinctly named chapters and sections which contain several references to other parts in the book.
The software equivalent of this is **splitting code into functions**.
Each function has a name and some contents.
By using functions, you can tell the computer at any point in your code to jump to some other place and continue from there.
This allows you to more easily re-use code between projects, update code, share code, collaborate and see the big picture.
Hence, with functions, you can **save time**.

So, while reading this book, you will eventually get used to reading and using functions.
Another benefit of having good software engineering skills is that it will allow you to more easily read the packages's source code that you're using, which could be greatly beneficial when you are debugging your code or wonder how exactly the package that you're using works.
Finally, you can rest assured that we did not invent this emphasis on functions ourselves.
In industry, it is common practice to encourage developers to use **"functions instead of comments"**.
That means that, instead of writing a comment for humans and some code for the computer, the developers write a function which is read by both humans and computers.

Also, we've put much effort into sticking to a consistent style guide.
Programming style guides provide guidelines for writing code.
For example, about where there should be whitespace and what names should be capitalized, or not.
Sticking to a strict style guide might sound pedantic and it sometimes is.
However, the more consistent the code is, the easier it is to read and understand the code.
To read our code, you don't need to know our style guide.
You'll figure it out when reading.
If you do want to see the details of our style guide, checkout @sec:notation.

## Acknowledgements

Many people have contributed directly and indirectly to this book.

Jose Storopoli would like to thank his colleagues, specially [Fernando Serra](https://orcid.org/0000-0002-8178-7313), [Wonder Alexandre Luz Alves](https://orcid.org/0000-0003-0430-950X) and [André Librantz](https://orcid.org/0000-0001-8599-9009), for their encouragement and support.

Rik Huijzer would like to thank his PhD supervisors, [Peter de Jonge](https://www.rug.nl/staff/peter.de.jonge/), [Ruud den Hartigh](https://www.rug.nl/staff/j.r.den.hartigh/) and [Frank Blaauw](https://frankblaauw.nl/) for their support.

Lazaro Alonso would like to thank his wife and daughters for their encouragement to get involved in this project.
