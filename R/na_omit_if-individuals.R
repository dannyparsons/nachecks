#' Conditionally omit missing values (single condition)
#'
#' These set of functions remove missing values from \code{x} if the single,
#' specified check is satisfied, and returns \code{x} unmodified otherwise. They
#' are special cases of \code{\link{na_omit_if}}, which is the general case for
#' specifying multiple checks.
#'
#' These functions replicate a subset of the functionality of
#' \code{\link{na_omit_if}}.
#'
#' For example, \code{na_omit_if_consec(x, 4)} is equivalent to
#' \code{na_omit_if(x, consec = 4)}.
#'
#' This more restricted form may be desirable when only a single check is
#' required.
#'
#' @param x Vector to omit missing values in if checks pass.
#' @param prop The proportion threshold (0 to 1) for missing values in \code{x}.
#'   The proportion of missing values in \code{x} must be less than (or equal
#'   to) \code{prop} for this check to pass, or strictly less than \code{prop}
#'   if \code{strict = TRUE}.
#' @param na The threshold for the number of missing values in \code{x}. The
#'   number of missing values in \code{x} must be less than or equal to \code{na} for this
#'   check to pass.
#' @param consec The threshold for the longest sequence of consecutive missing
#'   values in \code{x}. The longest sequence of consecutive missing values in \code{x} must
#'   be less than or equal to \code{consec} for this check to pass.
#' @param na_non_na The threshold for \strong{non-missing} values in \code{x}. The
#'   number of non-missing values in \code{x} must be greater than or equal to
#'   \code{na_non_na} for this check to pass.
#' @param strict A logical (default \code{FALSE}) indicating if the proportion
#'   of missing values must be \strong{strictly} less than \code{prop}
#'   (\code{strict = TRUE}) or only less than or equal to \code{na_prop}
#'   (\code{strict = FALSE}).
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
