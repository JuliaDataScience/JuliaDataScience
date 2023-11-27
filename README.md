<p align="center">
  <img width="30%" src="https://user-images.githubusercontent.com/20724914/137383342-b140f99e-5588-4862-a5e0-de3c30dfd588.png">
</p>

<h1 align="center">Julia Data Science</h1>

<h3 align="center">
  Open source and open access book for data science in Julia.
</h3>

[![CI Build](https://github.com/JuliaDataScience/JuliaDataScience/workflows/CI/badge.svg)](https://github.com/JuliaDataScience/JuliaDataScience/actions?query=workflow%3ACI+branch%3Amain)
[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

You can read the full book on <https://juliadatascience.io>.

This book was once available on Amazon, but due to an absurd reason, our publishing account was terminated, and our book was removed.
Interestingly, all Amazon customer accounts remain functional.
It seems that our removal may have been a result of not selling enough books.
Nevertheless, the book and its PDF version can still be accessed in their entirety on this website.

## Contributing

Pull requests are welcomed.
Note that we do have some checks on CI using [GitHub Actions](.github/workflows).
Here is the full list of checks:

- [Typos](.github/workflows/typos.yml):
  We automate typos check with [`typos`](https://github.com/crate-ci/typos).
  Regarding the typos check, there might be some false positives.
  In that case you can add a regex rule to filter out the typos in the `_typos.toml` file.
  We already included all the false positives we've found so far with some explainable comments.
  Hence, you should be able to follow the examples and add your own.
  You can make `typos` a [`pre-commit`](https://pre-commit.com) check,
  where it will check before the commit is executed for typos.
  The configuration is already provided in the
  [`.pre-commit-config.yaml`](.pre-commit-config.yaml) file.
  Just install [`pre-commit`](https://pre-commit.com) and
  run:

  ```bash
  pre-commit install --install-hooks
  ```

- [Format](.github/workflows/Format.yml):
  We check Julia code format using
  [`JuliaFormatter.jl`](https://github.com/domluna/JuliaFormatter.jl)
- [Build and Deploy](.github/workflows/CI.yml):
  Julia Data Science book, both website and PDF, is built in a CI job.

## LICENSE

This book is licensed under [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International][cc-by-nc-sa].

[![CC BY-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

Also using an image from the Love pack by Freepik at [Flaticon](https://www.flaticon.com/free-icons/coffee).

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
