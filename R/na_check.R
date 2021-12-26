#' Check missing values conditions
#'
#' \code{na_check} checks conditions on missing values in a vector. If all the
#' checks pass it returns \code{TRUE}, otherwise \code{FALSE}.
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
#' specified, they must all pass in order to return \code{TRUE}.
#' If no checks are specified then \code{TRUE} is returned, since
#' this is considered as "all" checks passing.
#'
#' @inheritParams na_check_prop
#' @param prop_strict A logical (default \code{FALSE}) indicating if the
#'   proportion of missing values must be \strong{strictly} less than
#'   \code{prop} (\code{prop_strict = TRUE}) or only less than \code{prop}
#'   (\code{prop_strict = FALSE}).
#'
#' @return \code{TRUE} if all specified checks pass, and \code{FALSE} otherwise.
#' @export
#' @examples
#' x <- c(1:3, NA, NA, NA, 4, NA, NA, 3)
#' # check if no more than 50% of values are missing
#' na_check(x, prop = 0.5)
#' # check if no more than 50% of values are missing
#' # and if there are no more than 2 consecutive missing values.
#' na_check(x, prop = 0.5, consec = 2)
na_check <- function(x, prop = NULL, n = NULL, consec = NULL, n_non = NULL,
                     prop_strict = FALSE) {
  UseMethod("na_check")
}

#' @export
na_check.default <- function(x, prop = NULL, n = NULL, consec = NULL,
                             n_non = NULL, prop_strict = FALSE) {

  (is.null(prop) || na_check_prop(x = x, prop = prop, strict = prop_strict)) &&
    (is.null(n) || na_check_n(x = x, n = n)) &&
    (is.null(n_non) || na_check_non_na(x = x, n_non = n_non)) &&
    # Done last as most computationally intensive
    (is.null(consec) || na_check_consec(x = x, consec = consec))
}
