## Load and Save Files {#sec:load_save}

Having only data inside Julia programs and not being able to load or save it would be very limiting.
Therefore, we start by mentioning how to store files to and load files from disk.
We focus on CSV, see @sec:csv, and Excel, see @sec:excel, file formats since those are the most common data storage formats for tabular data.

### CSV {#sec:csv}

**C**omma-**s**eparated **v**alues (CSV) files are are very effective way to store tables.
CSV files have two advantages over other data storage files.
First, it does exactly what the name indicates it does, namely storing values by separating them using commas `,`.
This acronym is also used as the file extension.
So, be sure that you save your files using the ".csv" extension such as "myfile.csv".
To demonstrate how a CSV file looks, we can install the `CSV.jl` package:

```
julia> ]

pkg> add CSV
```

and load it via:

```
using CSV
```

We can now use our previous data:

```jl
sco("
grades_2020()
"; process=without_caption_label)
```

and read it from a file after writing it:

```jl
@sc write_grades_csv()
```

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
path = write_grades_csv()
read(path, String)
end # hide
""")
```

Here, we also see the second benefit of CSV data format: the data can be read by using a simple text editor.
This differs from many alternative data formats which require proprietary software, e.g. Excel.

This works wonders, but what if our data **contains commas `,`** as values?
If we would naively write data with commas, it would make the files very hard to convert back to a table.
Luckily, `CSV.jl` handles this for us automatically.
Consider the following data with commas `,`:

```jl
@sco grades_with_commas()
```

If we write this, we get:

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
function write_comma_csv()
    path = "grades-commas.csv"
    CSV.write(path, grades_with_commas())
end
path = write_comma_csv()
read(path, String)
end # hide
""")
```

So, `CSV.jl` adds quotation marks `"` around the comma-containing values.
Another common way to solve this problem, is to write the data to a **t**ab-**s**eparated **v**alues (TSV) file format.
This assumes that the data doesn't contain tabs, which holds in most cases.

Also, note that TSV files can be also read using a simple text editor and uses the ".tsv" extension.

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
function write_comma_tsv()
    path = "grades-comma.tsv"
    CSV.write(path, grades_with_commas(); delim='\\t')
end
read(write_comma_tsv(), String)
end # hide
""")
```

Text file formats. like CSV and TSV files, can also come up with other delimiters, such as semicolons ";", spaces "\ ", or even something as unusual as "π".

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
function write_space_separated()
    path = "grades-space-separated.csv"
    CSV.write(path, grades_2020(); delim=' ')
end
read(write_space_separated(), String)
end # hide
""")
```

By convention, its still best to give files with special delimiters, such as ";", the ".csv" extension.

Loading CSV files using `CSV.jl` is done in a similar way.
You can use `CSV.read` and specify in what kind of format you want the output.
We specify a `DataFrame`.

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
CSV.read(path, DataFrame)
end # hide
"""; process=without_caption_label)
```

Conveniently, `CSV.jl` will automatically infer column types for us:

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
df = CSV.read(path, DataFrame)
end # hide
"""; process=string, post=output_block)
```

It works even for far more complex data:

```jl
sco("""
JDS.inside_tempdir() do # hide
my_data = \"\"\"
    a,b,c,d,e
    Kim,2018-02-03,3,4.0,2018-02-03T10:00
    \"\"\"
path = "my_data.csv"
write(path, my_data)
df = CSV.read(path, DataFrame)
end # hide
"""; process=string, post=output_block)
```

These CSV basics should cover most use cases.
For more information, see the [`CSV.jl` documentation](https://csv.juliadata.org/stable) and especially the [`CSV.File` constructor docstring](https://csv.juliadata.org/stable/#CSV.File).

### Excel {#sec:excel}

There are multiple Julia packages to read Excel files.
In this book, we will only look at [`XLSX.jl`](https://github.com/felipenoris/XLSX.jl), because it is the most actively maintained package in the Julia's ecosystem that deals with Excel data.
As a second benefit, `XLSX.jl` is written in pure Julia, which makes it easy for us to inspect and understand what's going on under the hood.

Install the `XSLX.jl` package via:

```
julia> ]

pkg> add XLSX
```

and load it with:

```
using XLSX
```

or

```
using XLSX:
    readxlsx,
    writetable
```

To write files, we define a little helper function for data and column names:

```jl
@sc write_xlsx("", DataFrame())
```

Now, we can easily write the grades to an Excel file:

```jl
@sc write_grades_xlsx()
```

When reading it back, we will see that `XLSX.jl` puts the data in a `XLSXFile` type which we can access the desired `sheet` much like a `Dict`:

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_xlsx()
xf = XLSX.readxlsx(path)
end # hide
""")
```

```jl
sco("""
JDS.inside_tempdir() do # hide
xf = XLSX.readxlsx(write_grades_xlsx())
sheet = xf["Sheet1"]
XLSX.eachtablerow(sheet) |> DataFrame
end # hide
"""; process=without_caption_label)
```

Notice that we cover just the basics of `XLSX.jl` but more powerful usage and customizations are available.
For more information and options, see the [`XLSX.jl` documentation](https://felipenoris.github.io/XLSX.jl/stable/).
