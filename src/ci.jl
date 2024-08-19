"""
    build()

This method is called during CI.
"""
function build()
    @info "Building JDS"
    fail_on_error = true
    gen(; fail_on_error)
    build_all(; fail_on_error)
end

"""
    patch_large_svg()

This method is called during CI and patches JDS_cheatsheet_cairomakie_.svg.
Somehow this SVG is 27MB and doesn't render in the browser.
Luckily, we can just remove the SVG and point the HTML to the PNG instead.
"""
function patch_large_svg()
    build_dir = Books.BUILD_DIR
    filename = "JDS_cheatsheet_cairomakie_"
    svg_filename = "$(filename).svg"
    png_filename = "$(filename).png"
    html_path = joinpath(build_dir, "makie_cheat_sheets.html")
    html_text = read(html_path, String)
    new_html_text = replace(html_text, svg_filename => png_filename)
    @assert html_text != new_html_text
    write(html_path, new_html_text)

    svg_path = joinpath(build_dir, "im", svg_filename)
    @assert isfile(svg_path)
    rm(svg_path)
end
