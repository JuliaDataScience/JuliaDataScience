function more_grades()
    df1 = all_grades()
    df2 = DataFrame(;
            name = ["Bob", "Sally", "Hank"],
            grade = [6.5, 7.0, 6.0]
           )
    return vcat(df1, df2)
end
