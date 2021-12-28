valid_logical <- function(x, name = "x") {
  if (!is.logical(x)) stop(name, " must be logical")
  if (length(x) != 1) stop(name, " must be length 1")
  if (is.na(x)) stop(name, " must not be missing")
  invisible(x)
}
