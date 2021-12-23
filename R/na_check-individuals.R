#' Check the proportion of missing values
#'
#' \code{na_check_prop} returns \code{TRUE} if the proportion of missing values
#' is below a given threshold. This is a convenient wrapper function for
#' \code{na_prop(x) < prop} or \code{na_prop(x) <= prop} (depending on
#' \code{strict}).
#'
#' If \code{strict = FALSE} (the default), \code{na_check_prop} is equivalent to
#' \code{na_prop(x) <= prop} i.e. it returns \code{TRUE} if the proportion of
#' missing values in \code{x} is less than or equal to \code{na_prop}, and
#' \code{FALSE} otherwise.
#'
#' If \code{strict = TRUE}, \code{na_check_prop} is equivalent to
#' \code{na_prop(x) < prop} i.e. the same as above but with a strictly less than
#' \code{prop} condition.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param prop The threshold as a proportion (0 to 1) for missing values in
#'   \code{x}.
#' @param strict A logical (default \code{FALSE}) indicating if the proportion
#'   of missing values must be \strong{strictly} less than \code{prop}
#'   (\code{strict = TRUE}) or only less than \code{na_prop} (\code{strict =
#'   FALSE}).
#'
#' @return \code{TRUE} if the proportion of missing values in \code{x} is less
#'   than (or strictly less than if \code{strict = TRUE}) \code{prop}, and
#'   \code{FALSE} otherwise.
#'
#' @export
#' @examples
#' na_check_prop(c(1, 2, NA, 4), 0.6)
#' na_check_prop(c(1, 2, NA, 4), 0.4)
#'
#' na_check_prop(c(1:10, NA), 0.1)
#'
#' na_check_prop(c(1:9, NA), 0.1, strict = TRUE)
na_check_prop <- function(x, prop = NULL, strict = FALSE) {
  UseMethod("na_check_prop")
}

#' @export
na_check_prop.default <- function(x, prop = NULL, strict = FALSE) {
  if (is.null(prop)) return(TRUE)
  if (strict) na_prop(x) < prop
  else na_prop(x) <= prop
}

#' Check the number of missing values
#'
#' \code{na_check_n} returns \code{TRUE} if the number of
#' missing values is less than or equal to a given threshold.
#' This is a convenient wrapper function for \code{na_n(x) <= n}.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param n The threshold for missing values in \code{x}.
#'
#' @return \code{TRUE} if the number of missing values in \code{x}
#' is less than or equal to \code{n} and \code{FALSE} otherwise.
#'
#' @export
#' @examples
#' na_check_n(c(1, 2, NA, 4, NA, NA, 7), 5)
#'
#' na_check_n(c(1:9, NA, NA, NA), 2)
na_check_n <- function(x, n = NULL) {
  UseMethod("na_check_n")
}

#' @export
na_check_n.default <- function(x, n = NULL) {
  if (is.null(n)) return(TRUE)
  na_n(x) <= n
}
#' Checks the longest sequence of consecutive missing values
#'
#' \code{na_check_consec} returns \code{TRUE} if the longest sequence of
#' consecutive missing values is less than or equal to a given threshold. This
#' is a convenient wrapper function for \code{na_consec(x) <= n}.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param n The threshold for the longest sequence of consecutive missing values
#'   in \code{x}.
#'
#' @return \code{TRUE} if the longest sequence of consecutive missing values in
#'   \code{x} is less than or equal to \code{n} and \code{FALSE} otherwise.
#'
#' @export
#' @examples
#' na_check_consec(c(1, NA, NA, NA, 2, NA, NA, 7), 4)
#'
#' na_check_consec(c(rep(NA, 5), 1:2, rep(NA, 6)), 5)
na_check_consec <- function(x, consec = NULL) {
  UseMethod("na_check_consec")
}

#' @export
na_check_consec.default <- function(x, consec = NULL) {
  if (is.null(consec)) return(TRUE)
  na_consec(x) <= consec
}

#' Check the number of non-missing values
#'
#' \code{na_check_non_na} returns \code{TRUE} if the number of
#' \strong{non-missing} values is greater than or equal to a given threshold.
#' This is a convenient wrapper function for \code{na_non_na(x) >= n}.
#'
#' Note that unlike the other \code{check_*} functions in \code{na_check_non_na}
#' the threshold is for a minimum number, since it is concerned with
#' \strong{non-missing} values.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param n The threshold for \strong{non-missing} values in \code{x}.
#'
#' @return \code{TRUE} if the number of \strong{non-missing} values in \code{x}
#'   is greater than or equal to \code{n} and \code{FALSE} otherwise.
#'
#' @export
#' @examples
#' na_check_non_na(c(1, 2, NA, 4, NA, NA, 7), 5)
#'
#' na_check_non_na(c(1:9, NA, NA, NA), 2)
na_check_non_na <- function(x, n_non = NULL) {
  UseMethod("na_check_non_na")
}

#' @export
na_check_non_na.default <- function(x, n_non = NULL) {
  if (is.null(n_non)) return(TRUE)
  na_non_na(x) >= n_non
}
