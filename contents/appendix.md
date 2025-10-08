# Appendix {#sec:appendix}

## Packages Versions {#sec:appendix_pkg}

This book is built with Julia `jl string(VERSION)` and the following packages:

```julia (editor=true, logging=false, output=true)
JDS.pkg_deps()
```
```julia (editor=true, logging=false, output=true)
let
    date = today()
    hour = Dates.hour(now())
    min = Dates.minute(now())

    "Build: $date $hour:$min UTC"
end
```
