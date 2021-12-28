valid_proportion <- function(x, name = "x") {
  if (!is.numeric(x)) stop(name, " must be numeric")
  if (length(x) != 1) stop(name, " must be length 1")
  if (is.na(x) || is.infinite(x)) stop(name, " must not be missing or infinite")
  if (x < 0 || x > 1) stop(name, " must be a number between 0 and 1")
  invisible(x)
}
