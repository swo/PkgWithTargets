get_targets_object <- function(
    name,
    targets_script = fs::path_package("PkgWithTargets", "package_targets.R")
) {
    targets::tar_make(name, script = targets_script)
    targets::tar_read_raw(name)
}
