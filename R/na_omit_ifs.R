#' Omit missing values conditionally on checks
#'
#' \code{na_omit_if} omits missing values from \code{x} if the specified missing
#' values checks are satisfied. There are four type of checks possible to
#' specify: proportion and number of missing values, maximum number of
#' consecutive missing values, and number of non-missing values. If any of the
#' checks fail, \code{x} is returned unmodified.
#'
#' \code{prop}, \code{na}, \code{consec} and \code{non_na} are optional and any
#' number of conditions may be specified, including none. If no checks are
#' specified then missing values are omited, since this is considered as "all"
#' checks passing. If multiple conditions are specified, they must all be
#' satisfied to omit missing values.
#'
#' @param x Vector to omit missing values in if checks pass.
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
#'   (\code{strict = TRUE}) or only less than or equal to \code{prop_na}
#'   (\code{strict = FALSE}). Ignored if \code{prop_na} is missing.
#'
#' @return A vector of the same type as \code{x}. Either \code{x} with missing
#'   values removed if all checks pass, or \code{x} unmodified if all checks do
#'   not pass. For consistency with \code{\link[stats::na.fail]{na.omit}}, if missing
#'   values are removed, the indices of the removed values form an
#'   \code{na.action} attribute of class \code{omit} in the result. If no
#'   missing values are removed (because the checks failed or there were no missing values in \code{x}) then no \code{na.action} attribute is added.
#'
#' @examples
#' x <- c(1, 3, NA, NA, NA, 4, 2, NA, 4, 6)
#' sum(na_omit_if(x, prop = 0.45, na = 10, consec = 5))
#' sum(na_omit_if(x, prop = 0.45))
#' require(magrittr)
#' sum(x %>% na_omit_if(prop = 0.45))
#'
#' # WMO specification for calculating monthly values from daily data
#' daily_rain <- rnorm(30)
#' daily_rain[c(3, 5, 6, 7, 8, 9, 24, 28)] <- NA
#' sum(daily_rain %>% na_omit_if(na = 10, consec = 4))
na_omit_if <- function(x, prop, na, consec, non_na,
                       prop_strict = FALSE) {
  if (check_na(x = x, prop = prop, na = na, consec = consec,
               non_na = non_na, prop_strict = prop_strict)) {
    label_na_omit(x)
  } else x
}

na_omit_if_prop <- function(x, prop, strict = FALSE) {
  if (check_prop_na(x = x, prop = prop, strict = strict)) {
    label_na_omit(x)
  } else x
}

na_omit_if_n <- function(x, n) {
  if (check_n_na(x = x, n = n)) {
    label_na_omit(x)
  } else x
}

na_omit_if_non_na <- function(x, n) {
  if (check_n_non_na(x = x, n = n)) {
    label_na_omit(x)
  } else x
}

na_omit_if_consec <- function(x, n) {
  if (check_consec_na(x = x, n = n)) {
    label_na_omit(x)
  } else x
}

label_na_omit <- function(x) {
  omit <- which(is.na(x))
  if(length(omit) > 0) {
    x <- x[-omit]
    attr(omit, "class") <- "omit"
    attr(x, "na.action") <- omit
  }
  x
}
