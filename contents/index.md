# Welcome {-}

```{=comment}
This file is only included on the website.
```

Welcome! This is an open source and open access book on how to do **Data Science using [Julia](https://julialang.org)**.
Our target audience are researchers from all fields of applied sciences.
Of course, we hope to be useful for industry too.
You can navigate through the pages of the ebook by using the arrow keys (left/right) on your keyboard.

The book is also available as [**PDF**](/juliadatascience.pdf){target="_blank"}.

The source code is available at [GitHub](https://github.com/JuliaDataScience/JuliaDataScience){target="_blank"}.

### Work in Progress {-}

This book is almost finished and we plan to publish within a few months.
Roughly, the status is as follows:

- [x] 1. Preface
- [x] 2. Why Julia?
- [x] 3. Julia Basics
- [x] 4. DataFrames.jl
- [ ] 5. Plots.jl
- [x] 6. Makie.jl
- [x] 7. Statistics
- [ ] Review complete book
- [ ] Publish with Amazon Kindle Direct Publishing

For details about the status, see the [JuliaDataScience](https://github.com/JuliaDataScience/JuliaDataScience) GitHub repository.
Or, **sign up for updates**:

```{=html}
<form style="margin: 0 auto;" action="https://api.staticforms.xyz/submit" method="post">
    <input type="hidden" name="accessKey" value="2b78f325-fb4e-44e1-ad2f-4dc714ac402f">
    <input type="email" name="email">
    <input type="hidden" name="redirectTo" value="https://juliadatascience.io/thanks">
    <input type="submit" value="Submit" />
</form>
```

### Roadmap {-}

Of course, data science is about more things than just tables, basic statistics and plotting.
We want to cover more topics, but we have scheduled them for the second edition of the book.
For now, the planned topics for the second edition are:

- More statistics
- Plotting via `AlgebraOfGraphics.jl`.
- Machine learning (probably, `MLJ.jl` and `Flux.jl`)
- Bayesian statistics (`Turing.jl`)
- Exercises

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

```jl
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

