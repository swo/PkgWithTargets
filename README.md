# PkgWithTargets

Example project showing how to use `targets` as part of an R package. There are two approaches: a formal example where `targets` is used as part of the package logic itself, and an informal example where `targets` is used to run a pipeline as part of code and scientific development.

The point of this trivial package is to generate randomly-distributed x and y data, then run a linear regression on it. The resulting slope and intercept are only trivially different from zero.

As in a normal package, the functions `simulate_data()` and `linear_fit()` are defined in `R/`. The package user could call, for example:
```r
library(PkgWithTargets)
my_data <- generate_data()
my_coef <- linear_fit(my_data)
```
Or, alternatively: `PkgWithTargets::linear_fit(PkgWithTargets::generate_data())`.

During development, a developer would continually update the code, load it with `devtools::load_all()`, write tests, and run tests with `devtools::test()`.

If either of `simulate_data()` or `linear_fit()` were computationally expensive, it would be nice to use `targets`.

## Informal `targets` example

A folder `scripts/` contains the functionality that is to be kept in the repo but not part of a formal package. (This folder could be named anything that doesn't collide with official package names like `R/`, `inst/`, `tests/`, or `man/`.)

The file `_targets.R`, which is called the "target script" in the `targets` jargon, is kept in that `scripts/` folder. One might also keep a file `run.R` that runs the relevant pipeline. This folder could also include other scripts that informally reference one another via `source()`, RMarkdown files, parameter or config files, etc.

In this approach, the most notable difference is that the `_targets.R` file must specify the top-level `R/` directory in `tar_source()`.

## Formal example

Typically, the `targets` script is kept in the top-level folder and named `_targets.R`. However, this approach won't work for a package, because when the package is installed, package functions defined in `R/` can only call one another or reference files in `inst/`. The solution is to put the `targets` script in `inst/` and, when calling `tar_make()`, to specify that script.

For similar reasons, one cannot count on `tar_source()` or other `source()` commands to find the files in `R/`, because the relative file paths are not guaranteed to work the same way after installation. Instead, the package must be installed and referenced by the target script.

Inconveniently, this means that every package function that is listed as a `targets` target must be exported. In this example, because `data` is a target, the function `simulate_data()` must be exported.

## How to extend the formal example

When adding new functionality:

- Write the new function or test
- If the function is a `targets` target:
  - Include roxygen function document with `@export`
  - Run `devtools::document()`, which updates `NAMESCAPE` to include the exported function
- Run `devtools::install_local(".", force = TRUE)`, which installs the package
- Run tests

Then, any session that has access to the installed package can run `PkgWithTargets::get_model()`.

This approach seems substantially slower and less convenient.

## Author

- Scott Olesen <ulp7@cdc.gov>
