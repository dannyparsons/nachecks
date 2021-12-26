#' Conditionally omit missing values
#'
#' \code{na_omit_if} removes missing values from \code{x} if the specified
#' checks are satisfied, and returns \code{x} unmodified otherwise. When used
#' within summary functions, \code{na_omit_if} provides greater flexibility than
#' the \code{na.rm} option e.g. \code{sum(na_omit_if(x, prop = 0.05))}.
#'
#' There are four type of checks available:
#' \itemize{
#' \item a maximum proportion of missing values allowed (\code{prop})
#' \item a maximum number of missing values allowed (\code{n})
#' \item a maximum number of consecutive missing values allowed (\code{consec}),
#' and
#' \item a minimum number of non-missing values required (\code{n_non}).
#' }
#'
#' Any number of checks may be specified, including none. If multiple checks are
#' specified, they must all pass in order for missing values to be
#' omitted. If no checks are specified then missing values are omitted, since
#' this is considered as "all" checks passing.
#'
#' @inheritParams na_omit_if_prop
#' @inheritParams na_check
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
#' @examples
#' x <- c(1, 3, NA, NA, NA, 4, 2, NA, 4, 6)
#'
#' sum(na_omit_if(x, prop = 0.45, n = 10, consec = 5))
#' sum(na_omit_if(x, prop = 0.45))
#'
#' require(magrittr)
#' sum(x %>% na_omit_if(prop = 0.45))
#'
#' # WMO specification for calculating monthly values from daily data
#' daily_rain <- rnorm(30)
#' daily_rain[c(3, 5, 6, 7, 8, 9, 24, 28)] <- NA
#' sum(daily_rain %>% na_omit_if(n = 10, consec = 4))
na_omit_if <- function(x, prop, n, consec, n_non,
                       prop_strict = FALSE) {
  UseMethod("na_omit_if")
}

#' @export
na_omit_if.default <- function(x, prop = NULL, n = NULL, consec = NULL,
                               n_non = NULL, prop_strict = FALSE) {
  if (na_check(x = x, prop = prop, n = n, consec = consec,
               n_non = n_non, prop_strict = prop_strict)) {
    stats::na.omit(x)
  } else x
}

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

#' @export
na_omit_if_n <- function(x, n) {
  UseMethod("na_omit_if_n")
}

#' @export
na_omit_if_n.default <- function(x, n) {
  if (na_check_n(x = x, n = n)) {
    stats::na.omit(x)
  } else x
}

#' @export
na_omit_if_non_na <- function(x, n_non) {
  UseMethod("na_omit_if_non_na")
}

#' @export
na_omit_if_non_na.default <- function(x, n_non) {
  if (na_check_non_na(x = x, n_non = n_non)) {
    stats::na.omit(x)
  } else x
}

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
