module JDS

import Pkg

using Reexport: @reexport

@reexport begin
    using Books:
        BUILD_DIR,
        @sc,
        @sco,
        Options,
        build_all,
        catch_show,
        clean_stacktrace,
        code_block,
        convert_output,
        gen,
        output_block,
        sc,
        sco,
        scob,
        serve,
        without_caption_label
    using CSV
    using CairoMakie
    using CategoricalArrays
    using ColorSchemes
    using Colors
    using DataFrames:
        ByRow,
        DataFrame,
        DataFrameRow,
        Not,
        antijoin,
        combine,
        crossjoin,
        filter,
        groupby,
        innerjoin,
        leftjoin,
        outerjoin,
        rightjoin,
        select!,
        select,
        semijoin,
        subset,
        transform,
        transform!
    using Dates
    using Distributions
    using Downloads
    using FileIO
    using GLMakie
    using GeometryBasics
    using InteractiveUtils
    using LaTeXStrings
    using LinearAlgebra
    using Random: rand, randn, seed!
    using Statistics
    using StatsBase:
        mad,
        mode
    using TestImages
    using XLSX:
        eachtablerow,
        readxlsx,
        writetable
end # @reexport

const SMALL_IM_ATTR = "width=70%"

include("ci.jl")
include("df.jl")
include("environment.jl")
include("showcode_additions.jl")
include("makie.jl")
include("stats.jl")
include("bezier.jl")
include("front-cover.jl")

# Showcode additions.
export sce, scsob, trim_last_n_lines, plainblock

# Makie.
export publication_theme, plot_with_legend_and_colorbar
export LaTeX_Strings, demo_themes, new_cycle_theme, scatters_and_lines
export nested_sub_plot!, add_box_inset, add_axis_inset, peaks

# DataFrames.
export grades_2020, grades_2021, all_grades, grades_array, grade_2020
export convert_output, equals_alice, write_grades_csv, grades_with_commas
export write_grades_xlsx, write_xlsx, salaries, responses, wrong_types
export only_pass, correct_types, fix_age_column, fix_date_column

# Stats.
export more_grades
export statistics_graph, plot_central
export plot_dispersion_std, plot_dispersion_mad, plot_dispersion_iqr
export plot_corr
export plot_normal_lognormal, plot_discrete_continuous
export plot_pmf, plot_pdf, plot_cdf
export calculate_pdf
export anscombe_quartet, plot_anscombe

# Book cover.
export front_cover

end # module
