function grades_ages()
    name = ["Bob", "Sally", "Bob 2", "Alice", "Hank"]
    age = [17, 18, 17, 20, 19]
    DataFrame(; name, age)
end

export grades_2020
function grades_2020()
    name = ["Sally", "Bob", "Alice", "Hank"]
    grade_2020 = [1, 5, 8.5, 4]
    DataFrame(; name, grade_2020)
end

function grades_2021()
    name = ["Bob 2", "Sally", "Hank"]
    grade_2020 = [9.5, 9.5, 5]
    DataFrame(; name, grade_2021)
end

function grades_for_2020()
    innerjoin(grades_ages(), grades_2020(); on=:name)
end

export grades_array
function grades_array()
    name = ["Bob", "Sally", "Alice", "Hank"]
    age = [17, 18, 20, 19]
    grade_2020 = [5.0, 1.0, 8.5, 4.0]
    (; name, age, grade_2020)
end

function second_row()
    name, age, grade_2020 = grades_array()
    i = 2
    row = (name[i], age[i], grade_2020[i])
end

function names_grades1()
    df = grades_2020()
    df.name
end

function names_grades2()
    df = grades_2020()
    df[!, :name]
end

# Should fix this in Books.jl
export convert_output
function Books.convert_output(path, expr, out::DataFrameRow; kwargs...)
    Books.convert_output(path, expr, DataFrame(out); kwargs...)
end

export grade_2020
function grade_2020(i::Int)
    df = grades_2020()
    df[i, :]
end

function grade_2020(name::String)
    df = grades_2020()
    dic = Dict(zip(df.name, df.grade_2020))
    dic[name]
end

function grades_indexing()
    df = grades_2020()
    df[1:2, :name]
end

function grades_2020(names::Vector{Int})
    df = grades_2020()
    df[names, :]
end

export equals_alice
equals_alice(n::String) = n == "Alice"

export write_grades_csv
function write_grades_csv()
    path = "grades.csv"
    CSV.write(path, grades_2020())
end

export grades_with_commas
function grades_with_commas()
    df = grades_2020()
    df[3, :name] = "Alice,"
    df
end

inside_tempdir(f) = cd(f, mktempdir())
output_block_inside_tempdir(f) = output_block(inside_tempdir(f))

export write_xlsx
function write_xlsx(name, df::DataFrame)
    path = "$name.xlsx"
    data = collect(eachcol(df))
    cols = names(df)
    XLSX.writetable(path, data, cols)
end

export write_grades_xlsx
function write_grades_xlsx()
    path = "grades"
    write_xlsx(path, grades_2020())
    "$path.xlsx"
end
