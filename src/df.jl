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

export grades_2021
function grades_2021()
    name = ["Bob 2", "Sally", "Hank"]
    grade_2021 = [9.5, 9.5, 6]
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

grades_indexing(df) = df[1:2, :name]

function grades_2020(names::Vector{Int})
    df = grades_2020()
    df[names, :]
end

export equals_alice
equals_alice(name::String) = name == "Alice"

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

export salaries
function salaries()
    names = ["John", "Hank", "Karen", "Zed"]
    salary = [1_900, 2_800, 2_800, missing]
    DataFrame(; names, salary)
end

export responses
function responses()
    id = [1, 2]
    q1 = [28, 61]
    q2 = [:us, :fr]
    q3 = ["F", "B"]
    q4 = ["B", "C"]
    q5 = ["A", "E"]
    DataFrame(; id, q1, q2, q3, q4, q5)
end

export wrong_types
function wrong_types()
    id = 1:4
    date = ["28-01-2018", "03-04-2019", "01-08-2018", "22-11-2020"]
    age = ["adolescent", "adult", "infant", "adult"]
    DataFrame(; id, date, age)
end

"""
Not using `transform(df, :date => str2date; renamecols=false)`, because it's less readable.
"""
function fix_date_column(df::DataFrame)
    strings2dates(dates::Vector) = Date.(dates, dateformat"dd-mm-yyyy")
    dates = strings2dates(df[!, :date])
    df[!, :date] = dates
    df
end
export fix_date_column

function fix_age_column(df)
    levels = ["infant", "adolescent", "adult"]
    ages = categorical(df[!, :age]; levels, ordered=true)
    df[!, :age] = ages
    df
end
export fix_age_column

function correct_types()
    df = wrong_types()
    df = fix_date_column(df)
    df = fix_age_column(df)
end
export correct_types

function only_pass()
    leftjoined = leftjoin(grades_2020(), grades_2021(); on=:name)
    pass(A, B) = [5.5 < a || 5.5 < b for (a, b) in zip(A, B)]
    leftjoined = transform(leftjoined, [:grade_2020, :grade_2021] => pass => :pass)
    passed = subset(leftjoined, :pass; skipmissing=true)
    return passed.name
end
export only_pass
