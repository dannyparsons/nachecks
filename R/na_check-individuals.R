#' Check missing values conditions (single condition)
#'
#' These set of functions check a condition on missing values in a vector
#' \code{x}. They return \code{TRUE} if check passes, and \code{FALSE}
#' otherwise. They are special cases of \code{\link{na_check}}, which is the
#' general case for specifying multiple checks.
#'
#' These functions replicate the functionality of
#' \code{\link{na_check}} as individual functions for single checks.
#'
#' For example, \code{na_check_n(x, 5)} is equivalent to
#' \code{na_check(x, n = 5)}.
#'
#' This more restricted form may be desirable when only a single check is
#' required.
#'
#' @param x Vector to check the missing values properties of.
#' @param prop The maximum proportion (0 to 1) of missing values allowed.
#' @param n The maximum number of missing values allowed.
#' @param consec The maximum number of consecutive missing values allowed.
#' @param n_non The minimum number of \strong{non-missing} values required.
#' @param strict A logical (default \code{FALSE}) indicating if the proportion
#'   of missing values must be \strong{strictly} less than \code{prop}
#'   (\code{strict = TRUE}) or only less than \code{prop} (\code{strict =
#'   FALSE}).
#'
#' @return These functions return \code{TRUE} if the check passes, and
#'   \code{FALSE} otherwise.
#'
#' They are convenient wrapper functions for:
#' \itemize{
#' \item \code{na_prop(x) <= prop} or \code{na_prop(x) < prop}
#' (if \code{strict = TRUE})
#' \item \code{na_n(x) <= n}
#' \item \code{na_consec(x) <= consec}
#' \item \code{na_non_na(x) >= n_non}
#' }
#'
#' @export
#' @examples
#' na_check_prop(c(1, 2, NA, 4), 0.6)
#'
#' na_check_prop(c(1, 2, NA, 4), 0.4)
#'
#' na_check_prop(c(1:10, NA), 0.1)
#'
#' na_check_prop(c(1:9, NA), 0.1, strict = TRUE)
#'
#' na_check_n(c(1, 2, NA, 4, NA, NA, 7), 5)
#'
#' na_check_n(c(1:9, NA, NA, NA), 2)
#'
#' na_check_consec(c(1, NA, NA, NA, 2, NA, NA, 7), 4)
#'
#' na_check_consec(c(rep(NA, 5), 1:2, rep(NA, 6)), 5)
#'
#' na_check_non_na(c(1, 2, NA, 4, NA, NA, 7), 5)
#'
#' na_check_non_na(c(1:9, NA, NA, NA), 2)
na_check_prop <- function(x, prop = NULL, strict = FALSE) {
  UseMethod("na_check_prop")
}

#' @export
na_check_prop.default <- function(x, prop = NULL, strict = FALSE) {
  if (is.null(prop)) return(TRUE)
  if (strict) na_prop(x) < prop
  else na_prop(x) <= prop
}

#' @export
#' @rdname na_check_prop
na_check_n <- function(x, n = NULL) {
  UseMethod("na_check_n")
}

#' @export
na_check_n.default <- function(x, n = NULL) {
  if (is.null(n)) return(TRUE)
  na_n(x) <= n
}
#' @export
#' @rdname na_check_prop
na_check_consec <- function(x, consec = NULL) {
  UseMethod("na_check_consec")
}

#' @export
na_check_consec.default <- function(x, consec = NULL) {
  if (is.null(consec)) return(TRUE)
  na_consec(x) <= consec
}

#' @export
#' @rdname na_check_prop
na_check_non_na <- function(x, n_non = NULL) {
  UseMethod("na_check_non_na")
}

#' @export
na_check_non_na.default <- function(x, n_non = NULL) {
  if (is.null(n_non)) return(TRUE)
  na_non_na(x) >= n_non
}
