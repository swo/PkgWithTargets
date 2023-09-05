#' Linear regression coefficients for simple x/y data
#' 
#' @export
linear_fit <- function(data) {
    coefficients(lm(y ~ x, data = data))
}
