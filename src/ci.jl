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
