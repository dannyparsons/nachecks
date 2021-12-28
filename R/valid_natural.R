valid_natural <- function(x, name = "x") {
  if (!is.numeric(x)) stop(name, " must be numeric")
  if (length(x) != 1) stop(name, " must be length 1")
  if (is.na(x) || is.infinite(x)) stop(name, " must not be missing or infinite")
  if (!((x %% 1) == 0) || x < 0) stop(name, " must be a non-negative integer")
  invisible(x)
}
