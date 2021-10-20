# Appendix {#sec:appendix}

## Packages Versions {#sec:appendix_pkg}

This book is built with Julia `jl string(VERSION)` and the following packages:

```jl
JDS.pkg_deps()
```

```jl
let
    date = today()
    hour = Dates.hour(now())
    min = Dates.minute(now())

    "Build: $date $hour:$min UTC"
end
```
