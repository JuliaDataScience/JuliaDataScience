module JDS

import XLSX
import Pkg
import Plots

using Reexport
@reexport using Books
@reexport using CSV
@reexport using CairoMakie
@reexport using CategoricalArrays
@reexport using ColorSchemes
@reexport using Colors
@reexport using DataFrames
@reexport using Dates
@reexport using Downloads
@reexport using GLMakie
@reexport using LaTeXStrings
@reexport using Makie
@reexport using Random
@reexport using Statistics
@reexport using InteractiveUtils
@reexport using LinearAlgebra
@reexport using GeometryBasics
@reexport using FileIO
@reexport using TestImages


include("df.jl")
include("environment.jl")
include("showcode_additions.jl")
include("plots.jl")
include("makie.jl")
#include("AoG.jl")

# Showcode additions.
export sce, scsob, trim_last_n_lines, plainblock

# Plots.
export publication_theme, plot_with_legend_and_colorbar
export LaTeX_Strings, demo_themes, new_cycle_theme, scatters_and_lines
export nested_sub_plot!, add_box_inset, add_axis_inset, peaks

# DataFrames.
export grades_2020, grades_2021, all_grades, grades_array, grade_2020
export convert_output, equals_alice, write_grades_csv, grades_with_commas
export write_grades_xlsx, write_xlsx, salaries, responses, wrong_types
export only_pass, correct_types, fix_age_column, fix_date_column

"""
    build()

This method is called during CI.
"""
function build()
    println("Building JDS")
    Books.gen(; fail_on_error=true)
    extra_head = """
    <script src="https://cdn.usefathom.com/script.js" data-site="EEJXHKTE" defer></script>
    """
    Books.build_all(; extra_head, fail_on_error=true)
end

end # module
