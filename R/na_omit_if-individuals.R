#' Conditionally omit missing values (single condition)
#'
#' These set of functions remove missing values from \code{x} if the single,
#' specified check is satisfied, and returns \code{x} unmodified otherwise. They
#' are special cases of \code{\link{na_omit_if}}, which is the general case for
#' specifying multiple checks.
#'
#' These functions replicate the functionality of
#' \code{\link{na_omit_if}} as individual functions for single checks.
#'
#' For example, \code{na_omit_if_consec(x, 4)} is equivalent to
#' \code{na_omit_if(x, consec = 4)}.
#'
#' This more restricted form may be desirable when only a single check is
#' required.
#'
#' @inheritParams na_check_prop
#' @param x Vector to omit missing values in if checks pass.
#'
#' @return A vector of the same type as \code{x}. Either \code{x} with missing
#'   values removed if all checks pass, or \code{x} unmodified if any checks
#'   fail.
#'
#'   For consistency with \code{\link[stats]{na.omit}}, if missing
#'   values are removed, the indices of the removed values form an
#'   \code{na.action} attribute of class \code{omit} in the result.
#'
#'   If missing values are not removed (because the checks failed or there were
#'   no missing values in \code{x}) then no \code{na.action} attribute is added.
#'
#' @export
na_omit_if_prop <- function(x, prop, strict = FALSE) {
  UseMethod("na_omit_if_prop")
}

#' @export
na_omit_if_prop.default <- function(x, prop, strict = FALSE) {
  if (na_check_prop(x = x, prop = prop, strict = strict)) {
    stats::na.omit(x)
  } else x
}

#' @rdname na_omit_if_prop
#' @export
na_omit_if_n <- function(x, na) {
  UseMethod("na_omit_if_n")
}

#' @export
na_omit_if_n.default <- function(x, na) {
  if (na_check_n(x = x, na = na)) {
    stats::na.omit(x)
  } else x
}

#' @rdname na_omit_if_prop
#' @export
na_omit_if_consec <- function(x, consec) {
  UseMethod("na_omit_if_consec")
}

#' @export
na_omit_if_consec.default <- function(x, consec) {
  if (na_check_consec(x = x, consec = consec)) {
    stats::na.omit(x)
  } else x
}

#' @rdname na_omit_if_prop
#' @export
na_omit_if_non_na <- function(x, na_non_na) {
  UseMethod("na_omit_if_non_na")
}

#' @export
na_omit_if_non_na.default <- function(x, na_non_na) {
  if (na_check_non_na(x = x, na_non_na = na_non_na)) {
    stats::na.omit(x)
  } else x
}
