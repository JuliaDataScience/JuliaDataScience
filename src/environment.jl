julia_version() = "This book is built with Julia $VERSION and the following packages:"

function pkg_deps()
    deps = [pair.second for pair in dependencies()]
	deps = filter(p -> p.is_direct_dep, deps)
	deps = filter(p -> !isnothing(p.version), deps)
	list = ["$(p.name) $(p.version)" for p in deps]
	sort!(list)
	join(list, '\n')
end
