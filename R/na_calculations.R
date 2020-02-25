#' Calculate the proportion of missing values
#'
#' \code{prop_na} returns the proportion (0 to 1) of missing values in \code{x}.
#' It is a convenient wrapper for \code{mean(is.na(x))}.
#'
#' @param x Vector to calculate the proportion of missing values in.
#'
#' @return The proportion (0 to 1) of missing values in \code{x}.
#' @examples
#' prop_na(c(1, 2, NA, 4))
#'
#' prop_na(c(1:9, NA))
prop_na <- function(x) mean(is.na(x))

#' Calculate the number of missing values
#'
#' \code{n_na} returns the number of missing values in \code{x}.
#' It is a convenient wrapper for \code{sum(is.na(x))}.
#'
#' @param x Vector to calculate the number of missing values in.
#'
#' @return The number of missing values in \code{x}.
#' @examples
#' n_na(c(1, 2, NA, 4, NA, NA, 7))
#'
#' n_na(c(1:9, NA, NA))
n_na <- function(x) sum(is.na(x))

#' Calculate the number of non-missing values
#'
#' \code{n_non_na} returns the number of \strong{non-missing} values
#' in \code{x}.
#' It is a convenient wrapper for \code{sum(!is.na(x))}.
#'
#' @param x Vector to calculate the number of \strong{non-missing} values in.
#'
#' @return The number of \strong{non-missing} values in \code{x}.
#' @examples
#' n_non_na(c(1, 2, NA, 4, NA, NA, 7))
#'
#' n_non_na(c(1:9, NA, NA))
n_non_na <- function(x) sum(!is.na(x))

#' Calculate the length of the longest sequence of consecutive missing values
#'
#' \code{consec_na} returns the length of the longest sequence of consecutive
#' missing values in \code{x}.
#'
#' \code{consec_na} calculates the sequences of missing values in \code{x} and
#' returns the length of the longest sequence.
#'
#' @param x Vector to calculate the maximum number of consecutive missing values
#'   in.
#'
#' @return The length of the longest sequence of consecutive missing values in
#'   \code{x}.
#' @examples
#' consec_na(c(1, NA, NA, NA, 2, NA, NA, 7))
#'
#' consec_na(c(rep(NA, 5), 1:2, rep(NA, 6)))
consec_na <- function(x) {
  r <- rle(is.na(x))
  m <- r$lengths[r$values]
  if (length(m) > 0) max(m) else 0
}
