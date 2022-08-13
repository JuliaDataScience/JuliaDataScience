"""
    build()

This method is called during CI.
"""
function build()
    @info "Building JDS"
    fail_on_error = true
    gen(; fail_on_error)
    extra_head = """
    <script defer type="text/javascript" src="https://api.pirsch.io/pirsch.js" id="pirschjs" data-code="eB2Isj56H4g6ndupKwaKyHau7lCkTsVV"></script>
    """
    build_all(; extra_head, fail_on_error)
end
