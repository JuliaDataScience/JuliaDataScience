## Load and Save Files {#sec:load_save}

Having only data inside Julia programs and not being able to load or save it would be very limiting.
Therefore, we start by mentioning how to store files to disk and how to load files from disk.
We focus on CSV and Excel since those are the most prevalent.

### CSV

Comma-separated value (CSV) files are are ridiculously effective way to store tables.
Unlike many competing data storage solutions, CSV files have two advantages.
Firstly, it does exactly what the name indicates it does, namely storing values by separating the columns by commas.
This abbreviation is, also, used as the file extension.
So, be sure that you save your files as "myfile.csv".
To demonstrate how a CSV file looks, we can install the CSV package:

```
julia> ]

pkg> add CSV
```

and load it via

```
using CSV
```

We can, now, take some data:

```jl
sco("""
without_caption_label( # hide
grades_2020()
) # hide
""")
```

and read it from a file after writing it

```jl
sco("""
JDS.code_block_inside_tempdir() do # hide
function write_grades_csv()
    path = "grades.csv"
    CSV.write(path, grades_2020())
end
path = write_grades_csv()
read(path, String)
end # hide
""")
```

Here, we also see the second benefit of this data format:
the data can be read by using a text editor.
This is unlike many alternatives which require proprietary software.

This is all very nice, of course, but what if our data **contains commas**?
If we would naively write data with commas, it would make the files very hard to convert back to a table.
Luckily, CSV solves it for us automatically.
Consider the following data with commas:

```jl
@sco grades_with_commas()
```

If we write this, we get

```jl
sco("""
JDS.code_block_inside_tempdir() do # hide
function write_comma_csv()
    path = "grades-commas.csv"
    CSV.write(path, grades_with_commas())
end
path = write_comma_csv()
read(path, String)
end # hide
""")
```

So, CSV adds quotation marks around the comma containing values.
Another common way to solve this problem, is to write the data to a tab-separated value (TSV) file.
This assumes that the data doesn't contain tabs, which holds in most cases.

```jl
sco("""
JDS.code_block_inside_tempdir() do # hide
function write_comma_tsv()
    path = "grades-comma.tsv"
    CSV.write(path, grades_with_commas(); delim='\\t')
end
read(write_comma_tsv(), String)
end # hide
""")
```

You can also come up with other delimiters, such as semicolons ";", spaces " ", or even "π".

```jl
sco("""
JDS.code_block_inside_tempdir() do # hide
function write_pi_separated()
    path = "grades-pi-separated.csv"
    CSV.write(path, grades_2020())
end
read(write_pi_separated(), String)
end # hide
""")
```

By convention, we still give files with special delimiters, such as ";", the `.csv` extension.

Loading data in a similar way.
Now, use `read` and specify in what kind of format you want the output.
We specify a DataFrame.

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
without_caption_label( # hide
CSV.read(path, DataFrame)
) # hide
end # hide
""")
```

