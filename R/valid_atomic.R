valid_atomic <- function(x, name = "x") {
  if (!is.atomic(x) || !is.null(dim(x)))
    stop(name, " must be an (atomic) vector")
  invisible(x)
}
