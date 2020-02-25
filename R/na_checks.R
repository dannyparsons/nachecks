#' Check the proportion of missing values
#'
#' \code{check_prop_na} returns \code{TRUE} if the proportion of missing values
#' is below a given threshold. This is a convenient wrapper function for
#' \code{prop_na(x) < prop} or \code{prop_na(x) <= prop} (depending on
#' \code{strict}).
#'
#' If \code{strict = FALSE} (the default), \code{check_prop_na} is equivalent to
#' \code{prop_na(x) <= prop} i.e. it returns \code{TRUE} if the proportion of
#' missing values in \code{x} is less than or equal to \code{prop_na}, and
#' \code{FALSE} otherwise.
#'
#' If \code{strict = TRUE}, \code{check_prop_na} is equivalent to
#' \code{prop_na(x) < prop} i.e. the same as above but with a strictly less than
#' \code{prop} condition.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param prop The threshold as a proportion (0 to 1) for missing values in
#'   \code{x}.
#' @param strict A logical (default \code{FALSE}) indicating if the proportion
#'   of missing values must be \strong{strictly} less than \code{prop}
#'   (\code{strict = TRUE}) or only less than \code{prop_na} (\code{strict =
#'   FALSE}).
#'
#' @return \code{TRUE} if the proportion of missing values in \code{x} is less
#'   than (or strictly less than if \code{strict = TRUE}) \code{prop}, and
#'   \code{FALSE} otherwise.
#'
#' @examples
#' check_prop_na(c(1, 2, NA, 4), 0.6)
#' check_prop_na(c(1, 2, NA, 4), 0.4)
#'
#' check_prop_na(c(1:10, NA), 0.1)
#'
#' check_prop_na(c(1:9, NA), 0.1, strict = TRUE)
check_prop_na <- function(x, prop, strict = FALSE) {
  if (missing(prop)) return(TRUE)
  if (strict) prop_na(x) < prop
  else prop_na(x) <= prop
}

#' Check the number of missing values
#'
#' \code{check_n_na} returns \code{TRUE} if the number of
#' missing values is less than or equal to a given threshold.
#' This is a convenient wrapper function for \code{n_na(x) <= n}.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param n The threshold for missing values in \code{x}.
#'
#' @return \code{TRUE} if the number of missing values in \code{x}
#' is less than or equal to \code{n} and \code{FALSE} otherwise.
#'
#' @examples
#' check_n_na(c(1, 2, NA, 4, NA, NA, 7), 5)
#'
#' check_n_na(c(1:9, NA, NA, NA), 2)
check_n_na <- function(x, n) {
  if (missing(n)) return(TRUE)
  n_na(x) <= n
}

#' Check the number of non-missing values
#'
#' \code{check_n_non_na} returns \code{TRUE} if the number of
#' \strong{non-missing} values is greater than or equal to a given threshold.
#' This is a convenient wrapper function for \code{n_non_na(x) >= n}.
#'
#' Note that unlike the other \code{check_*} functions in \code{check_n_non_na}
#' the threshold is for a minimum number, since it is concerned with
#' \strong{non-missing} values.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param n The threshold for \strong{non-missing} values in \code{x}.
#'
#' @return \code{TRUE} if the number of \strong{non-missing} values in \code{x}
#'   is greater than or equal to \code{n} and \code{FALSE} otherwise.
#'
#' @examples
#' check_n_non_na(c(1, 2, NA, 4, NA, NA, 7), 5)
#'
#' check_n_non_na(c(1:9, NA, NA, NA), 2)
check_n_non_na <- function(x, n) {
  if (missing(n)) return(TRUE)
  n_non_na(x) >= n
}

#' Checks the longest sequence of consecutive missing values
#'
#' \code{check_consec_na} returns \code{TRUE} if the longest sequence of
#' consecutive missing values is less than or equal to a given threshold. This
#' is a convenient wrapper function for \code{consec_na(x) <= n}.
#'
#' @param x Vector to check the proportion of missing values in.
#' @param n The threshold for the longest sequence of consecutive missing values
#'   in \code{x}.
#'
#' @return \code{TRUE} if the longest sequence of consecutive missing values in
#'   \code{x} is less than or equal to \code{n} and \code{FALSE} otherwise.
#'
#' @examples
#' check_consec_na(c(1, NA, NA, NA, 2, NA, NA, 7), 4)
#'
#' check_consec_na(c(rep(NA, 5), 1:2, rep(NA, 6)), 5)
check_consec_na <- function(x, n) {
  if (missing(n)) return(TRUE)
  consec_na(x) <= n
}

#' Check conditions of missing values
#'
#' \code{check_na} checks conditions on missing values. If all the checks pass
#' it returns \code{TRUE}, otherwise \code{FALSE}. There are four type of checks
#' possible to specify: proportion and number of missing values, maximum number
#' of consecutive missing values, and number of non-missing values.
#'
#' \code{prop}, \code{na}, \code{consec} and \code{non_na} are optional and any
#' number of conditions may be specified, including none. If no checks are
#' specified then \code{TRUE} is returned, since this is considered as "all"
#' checks passing. If multiple conditions are specified, they must all be
#' satisfied to return \code{TRUE}.
#'
#' @param x Vector to check missing values conditions on.
#' @param prop The proportion threshold (0 to 1) for missing values in \code{x}.
#'   The proportion of missing values must be less than (or equal to)
#'   \code{prop} for this check to pass.
#' @param na The threshold for the number of missing values in \code{x}. The
#'   number of missing values must be less than or equal to \code{na} for this
#'   check to pass.
#' @param consec The threshold for the longest sequence of consecutive missing
#'   values in \code{x}. The longest sequence of consecutive missing values must
#'   be less than or equal to \code{consec} for this check to pass.
#' @param non_na The threshold for \strong{non-missing} values in \code{x}. The
#'   number of non-missing values in \code{x} must be greater than or equal to
#'   \code{non_na} for this check to pass.
#' @param strict A logical (default \code{FALSE}) indicating if the proportion
#'   of missing values must be \strong{strictly} less than \code{prop}
#'   (\code{strict = TRUE}) or only less than \code{prop_na} (\code{strict =
#'   FALSE}). Ignored if \code{prop_na} is missing.
#'
#' @return \code{TRUE} if all specified checks pass, and \code{FALSE} otherwise.
#' @examples
#' x <- c(1:3, NA, NA, NA, 4, NA, NA, 3)
#' # check if no more than 50% of values are missing
#' check_na(x, prop = 0.5)
#' # check if no more than 50% of values are missing and there are no more than 2 consecutive missing values.
#' check_na(x, prop = 0.5, consec = 2)
check_na <- function(x, prop, na, consec, non_na,
                     prop_strict = FALSE) {
  is_prop <- !missing(prop)
  is_na <- !missing(na)
  is_consec <- !missing(consec)
  is_non_na <- !missing(non_na)

  (!is_prop || (is_prop && check_prop_na(x = x, prop = prop, strict = prop_strict))) &&
    (!is_na || (is_na && check_n_na(x = x, n = na))) &&
    (!is_non_na || (is_non_na && check_n_non_na(x = x, n = non_na))) &&
    # Done last as most computationally intensive
    (!is_consec || (is_consec && check_consec_na(x = x, n = consec)))
}
