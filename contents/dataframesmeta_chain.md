## Piping Operations {#sec:dataframesmeta_chain}

R users are familiar with the pipe operator `%>%` which allows **chaining** operations together. That means that the output of an operation will be used as input in the next operation and so on.

This can be accomplished with the `@chain` macro. To use it, we start with `@chain` followed by the `DataFrame` and a `begin` statement. Every operation inside the `begin ... end` statement will be used as input for the next operation, therefore chaining operations together.

Here is a simple example with a `groupby` followed by a `@combine`:

```julia (editor=true, logging=false, output=true)
@chain leftjoined begin
    groupby(:name)
    @combine :mean_grade_2020 = mean(:grade_2020)
end
```
> ***NOTE:*** `@chain` will replace the first positional argument while chaining operations. This is not a problem in `DataFrames.jl` and `DataFramesMeta.jl`, since the `DataFrame` is always the first positional argument.


We can also nest as many as `begin ... end` statements we desired inside the operations:

```julia (editor=true, logging=false, output=true)
# second @chain # hide
@chain leftjoined begin
    groupby(:name)
    @combine begin
        :mean_grade_2020 = mean(:grade_2020)
        :mean_grade_2021 = mean(:grade_2021)
    end
end
```
To conclude, let's show a `@chain` example with all of the `DataFramesMeta.jl` macros we covered so far:

```julia (editor=true, logging=false, output=true)
# third @chain # hide
@chain leftjoined begin
    @rtransform begin
        :grade_2020 = :grade_2020 * 10
        :grade_2021 = :grade_2021 * 10
    end
    groupby(:name)
    @combine begin
        :mean_grade_2020 = mean(:grade_2020)
        :mean_grade_2021 = mean(:grade_2021)
    end
    @rtransform :mean_grades = (:mean_grade_2020 + :mean_grade_2021) / 2
    @rsubset :mean_grades > 50
    @orderby -:mean_grades
end
```
