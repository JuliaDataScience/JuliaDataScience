function pkg_deps()
    deps = [pair.second for pair in Pkg.dependencies()]
    deps = filter(p -> p.is_direct_dep, deps)
    deps = filter(p -> !isnothing(p.version), deps)
    list = ["$(p.name) $(p.version)" for p in deps]
    sort!(list)
    Books.code_block(string(join(list, '\n')))
end
