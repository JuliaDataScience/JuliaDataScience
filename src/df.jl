function grades_ages()
    name = ["Bob", "Sally", "Bob 2", "Alice", "Hank"]
    age = [17, 18, 17, 20, 19]
    DataFrame(; name, age)
end

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

function row_alice()
    names = grades_array().name
    i = findfirst(names .== "Alice")
end

function value_alice()
    grades = grades_array().grade_2020
    i = row_alice()
    grades[i]
end

function P()
    struct Point
        a::Int
        b::Int
    end
end

function call_P()
    Point = P() # hide
    Point(1, 2)
end
