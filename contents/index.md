# Welcome

```julia (editor=true, logging=false, output=true)
<style>
.language-switcher {
    font-size: 22px;
    text-align: right;
    margin-right: 0.2em;
    margin-bottom: 2em;
}

.language-switcher button {
    font-size: 20px;
}
</style>

<div class="language-switcher">
<a href="/"><button>🇺🇸</button></a>
<a href="/pt"><button>🇧🇷</button></a>
<a href="https://cn.julialang.org/JuliaDataScience"><button>🇨🇳</button></a>
</div>
```
```{=comment}
This file is only included on the website.
```

Welcome! This is an open source and open access book on how to do **Data Science using [Julia](https://julialang.org)**. Our target audience are researchers from all fields of applied sciences. Of course, we hope to be useful for industry too. You can navigate through the pages of the ebook by using the arrow keys (left/right) on your keyboard.

The book is also available as [**PDF**](/juliadatascience.pdf).

The source code is available at [GitHub](https://github.com/JuliaDataScience/JuliaDataScience).

### Citation Info {-}

To cite the content, please use:

```plaintext
Storopoli, Huijzer and Alonso (2021). Julia Data Science. https://juliadatascience.io. ISBN: 9798489859165.
```

Or in BibTeX format:

```plaintext
@book{storopolihuijzeralonso2021juliadatascience,
  title = {Julia Data Science},
  author = {Jose Storopoli and Rik Huijzer and Lazaro Alonso},
  url = {https://juliadatascience.io},
  year = {2021},
  isbn = {9798489859165}
}
```

### Front Cover {-}

```julia (editor=true, logging=false, output=true)
let
    fig = front_cover()
    # Use lazy loading to keep homepage speed high.
    link_attributes = """loading="lazy" width=80%"""
    # When changing this name, also change the link in README.md.
    # This doesn't work for some reason; I need to fix it.
    filename = "frontcover"
    Options(fig; filename, label=filename)
end
```
