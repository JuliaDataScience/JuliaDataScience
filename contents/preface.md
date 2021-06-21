# Preface {#sec:preface}


## Why Data Science? {#sec:why_data_science}

### Data is Everywhere {#sec:data_everywhere}

```{=comment}
The abundance of data and what this means to almost every knowledge worker. (Drucker 1959)
```

### Data Literacy {#sec:data_literacy}

```{=comment}
Data literacy as a competitive skill. Some references (wikipedia has a nice one) [https://en.wikipedia.org/wiki/Data_literacy]

As data collection and data sharing become routine and data analysis and big data become common ideas in the news, business,[2] government[3] and society,[4] it becomes more and more important for students, citizens, and readers to have some data literacy.
```

## Software engineering and data science {#sec:engineering}

Unlike most books on data science, this book lays more emphasis on properly structuring code.
The reason for this is that we noticed that many data scientists simply place their code in one large file and run all the statements sequentially.
You can think of this as writing a book for someone and forcing that person to read it from beginning to start.
This works great for small projects, but the bigger the project becomes, the more problems will start to arise.
For example, with a well written book, the book is split into well named chapters and sections and contains many references to other parts inside the book.
The software equivalent of this is splitting code into functions.
Each function has a name and some contents.
With functions, you can basically tell the computer at one point in your code to jump to some other place and continue there.
This allows you to more easily re-use code between projects, update code and see the big picture.
Hence, with functions, you can **save time**.

So, when reading this book, you will get accustomed to reading and using functions.
As another benefit, this will allow you to more easily read the source code for the packages that you're using, which is greatly beneficial when you are debugging your code or wonder how the code that your using is working exactly.
Finally, you can rest assured that we do not came up with this emphasis on functions ourselves at all.
In industry, it is common practise to encourage developers to use functions instead of comments.
That means that, instead of writing a comment for humans and some code for the computer, the developers write a function which is read by humans and computers.
