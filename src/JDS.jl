module JDS

import XLSX
import Pkg
import Plots

using Reexport
@reexport using AlgebraOfGraphics
@reexport using Books
@reexport using CairoMakie
@reexport using GLMakie
@reexport using CategoricalArrays
@reexport using CSV
@reexport using DataFrames
@reexport using Dates
@reexport using Downloads
@reexport using InteractiveUtils
@reexport using Makie
@reexport using ColorSchemes
@reexport using Colors
@reexport using LaTeXStrings
@reexport using Random

include("df.jl")
include("environment.jl")
include("showcode_additions.jl")
include("plots.jl")
include("makie.jl")
include("AoG.jl")

export sce, scsob, trim_last_n_lines, publication_theme, plot_with_legend_and_colorbar
export LaTeX_Strings, demo_themes, new_cycle_theme, scatters_and_lines
export nested_sub_plot!, add_box_inset, add_axis_inset, peaks

#plot = Plots.plot

function myplot()
    I = 1:30
    xy = mapping([I] => :x, [I .* 2] => :y)

    draw(xy)
end

"""
    build()

This method is called during CI.
"""
function build()
    println("Building JDS")
    Books.gen(; fail_on_error=true)
    extra_head = """
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-2RKMTDS1S8"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());  gtag('config', 'G-2RKMTDS1S8');
    </script>
    """
    Books.build_all(; extra_head, fail_on_error=true)
end

end # module
