## 加载和保存文件 {#sec:load_save}

如果我们仅能在当前Julia的项目中使用数据，无法加载或保存这些数据，是很局限性的。因此，在这里我们首先介绍要如何在您的磁盘上进行保存和加载文件，并将主要介绍 CSV 以及 Excel 这两种文件格式，因为这些是表格（tabular）类型的数据中最常见的存储方式。

### CSV {#sec:csv}

**C**omma-**s**eparated **v**alues (CSV) ，逗号分隔符文件是一种很有效的表格数据存储方式。和其他的数据存储文件相比，CSV 文件具有两个优势。首先，就如它的名称所指出的，我们可以通过逗号分隔符`,`来存储数值，并且通常使用首字母缩写来作为保存文件的扩展名。因此，确保您要保存的文件扩展名为".csv"，例如''myfile.csv''。为了演示 CSV 文件具体是如何工作的，我们可以安装[`CSV.jl`](http://csv.juliadata.org/latest/) 包：

```
julia> ]

pkg> add CSV
```

然后可以通过下述方式加载它：

```
using CSV
```

现在，我们可以利用之前的数据：

```jl
sco("
grades_2020()
"; process=without_caption_label)
```

同时，我们可以在写入一个文件之后读取该文件：

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

在这里，我们可以发现CSV数据格式的第二个优势：和其他的数据格式不一样，CSV格式的数据可以通过一些简单的文本编辑器进行浏览，不需要指定的软件，例如Excel.，这是件很酷的事，但是要怎么处理数据中包含了逗号**contains commas `,`** 作为数值的情况？如果我们天真地将逗号直接写入数据，那么在之后的文件读取中将很难转换回表格的格式。

幸运的是，`CSV.jl`可以为我们自动处理这类问题。

考虑下面带有逗号`,`的数据：

```jl
@sco grades_with_commas()
```

如果我们按上述方式写入数据，会得到下面的信息：

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

我们可以发现，`CSV.jl`在包含逗号的数值周围添加了`"`作为区分。

同样值得注意的是，TSV文件也可以使用简单的文本编辑器进行浏览，并使用".tsv"作为其文件扩展名。

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

我们还可以注意到，类似CSV和TSV文件的文本文件格式可以使用其他的分隔符来存储，例如分号";"，空格"\ "，甚至是"π"这种比较不常用的符号。

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

按照惯例，我们最好提供带有特殊分隔符的文件，例如";"和".csv"的文件扩展名。

使用`CSV.jl`来加载 CSV 文件的方法也是类似的。

您可以使用`CSV.read`来指定您想要输出的具体格式。

在这里我们指定输出具体为`DataFrame`格式。

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
CSV.read(path, DataFrame)
end # hide
"""; process=without_caption_label)
```

并且，`CSV.jl`会很方便的自动为我们判断列（column） 的类型：

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
df = CSV.read(path, DataFrame)
end # hide
"""; process=string, post=output_block)
```

甚至可以在很复杂的数据上起作用：

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

这些关于CSV文件的基础知识应该足以覆盖大多数的使用场景。

如果您希望获取更多关于Julia中CSV文件的信息，可以参阅 [`CSV.jl` documentation](https://csv.juliadata.org/stable) 该文档，尤其是[`CSV.File` constructor docstring](https://csv.juliadata.org/stable/#CSV.File)文件.

### Excel {#sec:excel}

在Julia中有多个包可以进行读取Excel文件。

在本书中，我们将只关注`XLSX.jl`这个包，因为这是Julia社区中维护最积极的Excel数据处理包。

第二个好处是，`XLSL.jl`是用纯julia语言编写的，我们可以很轻松地检查并理解代码是如何工作的。

按下列方式加载`XLSX.jl`：

```
using XLSX:
    eachtablerow,
    readxlsx,
    writetable
```

为了写入文件，我们为数据和列名（column names）定义了一个辅助函数：

```jl
@sc write_xlsx("", DataFrame())
```

现在，我们可以很轻松的把成绩写入Excel文件中了: 

```jl
@sc write_grades_xlsx()
```

之后读取整个文件的时候，我们会看到`XLSX.jl`把数据放在了`XLSXFile`的类型中，我们可以像访问字典`Dict`的方式一样访问我们需要的`sheet`：

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_xlsx()
xf = readxlsx(path)
end # hide
""")
```

```jl
s = """
    JDS.inside_tempdir() do # hide
    xf = readxlsx(write_grades_xlsx())
    sheet = xf["Sheet1"]
    eachtablerow(sheet) |> DataFrame
    end # hide
    """
sco(s; process=without_caption_label)
```

需要注意的是，我们仅提到了`XLSX.jl`相关的基础知识，您可以自行了解更多有效的用法，或者可以自定义关于Excel数据处理的包。

如果您希望获取更多的信息和选项，请参阅 [`XLSX.jl` documentation](https://felipenoris.github.io/XLSX.jl/stable/)的相关文档。