# Unlike a typical targets script, do not call `library()`, as this is bad
# practice for package code

# Unlike a typical targets script, there is no need to set dependencies for
# the functions in R/ using a command like
# `targets::tar_option_set(packages = c("tibble"))`. Instead, those dependencies
# are accounted for in the regular packages way, via the DESCRIPTION file.

# Distributed computing options would go here

# Unlike a typical targets script, there is no need to source R files using
# `targets::tar_source()` or individidual `source()` commands. Instead, use
# explicit calls to the package name in the targets list.

list(
  targets::tar_target(
    name = data,
    command = PkgWithTargets::simulate_data()
  ),
  targets::tar_target(
    name = model,
    command = PkgWithTargets::linear_fit(data)
  )
)
