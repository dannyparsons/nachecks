#' Check conditions of missing values
#'
#' \code{na_check} checks conditions on missing values. If all the checks pass
#' it returns \code{TRUE}, otherwise \code{FALSE}. There are four type of checks
#' possible to specify: proportion and number of missing values, maximum number
#' of consecutive missing values, and number of non-missing values.
#'
#' \code{prop}, \code{n}, \code{consec} and \code{n_non} are optional and any
#' number of conditions may be specified, including none. If no checks are
#' specified then \code{TRUE} is returned, since this is considered as "all"
#' checks passing. If multiple conditions are specified, they must all be
#' satisfied to return \code{TRUE}.
#'
#' @param x Vector to check missing values conditions on.
#' @param prop The proportion threshold (0 to 1) for missing values in \code{x}.
#'   The proportion of missing values must be less than (or equal to)
#'   \code{prop} for this check to pass.
#' @param n The threshold for the number of missing values in \code{x}. The
#'   number of missing values must be less than or equal to \code{n} for this
#'   check to pass.
#' @param consec The threshold for the longest sequence of consecutive missing
#'   values in \code{x}. The longest sequence of consecutive missing values must
#'   be less than or equal to \code{consec} for this check to pass.
#' @param n_non The threshold for \strong{non-missing} values in \code{x}. The
#'   number of non-missing values in \code{x} must be greater than or equal to
#'   \code{n_non} for this check to pass.
#' @param prop_strict A logical (default \code{FALSE}) indicating if the
#'   proportion of missing values must be \strong{strictly} less than
#'   \code{prop} (\code{strict = TRUE}) or only less than \code{na_prop}
#'   (\code{strict = FALSE}). Ignored if \code{na_prop} is missing.
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
na_check.default <- function(x, prop = NULL, n = NULL, consec = NULL, n_non = NULL,
                     prop_strict = FALSE) {
  is_prop <- !is.null(prop)
  is_na <- !is.null(n)
  is_consec <- !is.null(consec)
  is_na_non_na <- !is.null(n_non)

  (!is_prop || (is_prop && na_check_prop(x = x, prop = prop, strict = prop_strict))) &&
    (!is_na || (is_na && na_check_n(x = x, n = n))) &&
    (!is_na_non_na || (is_na_non_na && na_check_non_na(x = x, n_non = n_non))) &&
    # Done last as most computationally intensive
    (!is_consec || (is_consec && na_check_consec(x = x, consec = consec)))
}
