# Julia Data Science BonitoBook Configuration

This directory contains the configuration files for the Julia Data Science interactive book.

## Files

- `book.jl` - Main book configuration with table of contents and book structure
- `style.jl` - Complete styling and theming for the book (light/dark themes, Julia branding)
- `README.md` - This documentation file

## Book Structure

The book is organized with the following structure:

1. **Front Matter**
   - Welcome (index.md)
   - Preface (preface.md)
   - Notation (notation.md)

2. **Introduction**
   - Why Julia? (why_julia.md)
   - Julia Basics (julia_basics.md)

3. **DataFrames**
   - DataFrames.jl (dataframes.md)
   - Loading and Saving Files (dataframes_load_save.md)
   - Indexing (dataframes_indexing.md)
   - Select (dataframes_select.md)
   - Transform (dataframes_transform.md)
   - Split-Apply-Combine (dataframes_groupby_combine.md)
   - Joins (dataframes_join.md)
   - Missing Data (dataframes_missing.md)
   - Performance Tips (dataframes_performance.md)

4. **DataFramesMeta**
   - DataFramesMeta.jl (dataframesmeta.md)
   - DataFramesMeta Macros (dataframesmeta_macros.md)
   - DataFramesMeta Select (dataframesmeta_select.md)
   - DataFramesMeta Subset (dataframesmeta_subset.md)
   - DataFramesMeta Transform (dataframesmeta_transform.md)
   - DataFramesMeta Combine (dataframesmeta_combine.md)
   - DataFramesMeta Order By (dataframesmeta_orderby.md)
   - DataFramesMeta Chain (dataframesmeta_chain.md)

5. **Statistics**
   - Statistics (stats.md)
   - Probability Distributions (stats_distributions.md)
   - Statistical Visualization (stats_vis.md)

6. **Data Visualization - Makie**
   - Data Visualization with Makie.jl (data_vis_makie.md)
   - Creating Figures (data_vis_makie_create_figure.md)
   - CairoMakie.jl (data_vis_makie_cairo.md)
   - GLMakie.jl (data_vis_makie_glmakie.md)
   - Layouts (data_vis_makie_layouts.md)
   - Themes (data_vis_makie_themes.md)
   - Colors (data_vis_makie_colors.md)
   - LaTeX (data_vis_makie_latex.md)
   - Recipe (data_vis_makie_recipe.md)

7. **Data Visualization - AlgebraOfGraphics**
   - Data Visualization with AlgebraOfGraphics.jl (data_vis_aog.md)
   - Plot Customizations (data_vis_aog_custom.md)
   - Layouts (data_vis_aog_layouts.md)
   - Statistical Plotting (data_vis_aog_stats.md)
   - AlgebraOfGraphics and Makie (data_vis_aog_makie.md)

8. **Appendices**
   - Makie Cheat Sheets (makie_cheat_sheets.md)
   - References (references.md)
   - Appendix (appendix.md)

## Usage

From the project root directory:

```bash
# Start development server
julia make.jl serve

# Build static site
julia make.jl build
```

The main book page provides a table of contents with links to individual chapter notebooks.

## Customization

To modify the book structure:

1. Edit the `BOOK_STRUCTURE` constant in `book.jl`
2. Add or remove chapters as needed
3. Modify styling in the `book_styles()` function
4. Update table of contents generation in `generate_toc()`

## Chapter Format

Each chapter should be a markdown file with:

- A title heading starting with `# Title {#sec:id}` or just `# Title`
- Standard markdown content
- Julia code blocks with proper syntax highlighting

The system automatically extracts chapter titles and generates appropriate navigation.

## Styling Features

The `style.jl` file provides:

- **Automatic Light/Dark Theme**: Adapts to browser preference or can be forced
- **Julia Branding**: Uses official Julia colors (purple, green, blue, red)
- **Responsive Design**: Works on desktop and mobile devices
- **Monaco Editor Theming**: Matches the book theme
- **Makie Plot Integration**: Automatically adjusts plot themes
- **Interactive Elements**: Styled buttons, inputs, dropdowns with Julia colors
- **Print Support**: Optimized styles for PDF export
- **Accessibility**: High contrast ratios and proper focus indicators

### Theme Variables

The styling uses CSS custom properties that automatically adapt:
- `--julia-purple`: Primary brand color (#9558b2)
- `--julia-green`: Secondary color (#389826) 
- `--julia-red`: Accent color (#cb3c33)
- `--julia-blue`: Link color (#4063d8)
- Light/dark variants automatically applied