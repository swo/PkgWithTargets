#' Simulate data for modeling
#' 
#' @export
simulate_data <- function() {
    dplyr::tibble(x = rnorm(100), y = rnorm(100))
}
