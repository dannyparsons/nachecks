#' Calculate missing value properties
#'
#' @description
#'
#' A set of functions for calculating missing values properties of a vector.
#'
#' \itemize{
#' \item \code{\link{na_prop}}: The proportion of missing values
#' \item \code{\link{na_n}}: The number of missing values
#' \item \code{\link{na_consec}}: The maximum number of consecutive missing
#' values
#' \item \code{\link{na_non_na}}: The number of non-missing values
#' }
#'
#' @details
#'
#' These functions are used by \code{\link{na_omit_if}} to omit missing values
#' conditionally on the value of these properties. They are also useful
#' summaries in their own right.
#'
#' @param x A vector to calculate the missing values property of.
#'
#' @return
#' Each function returns a single number, a proportion (0 to 1) or a count.
#'
#' @export
#' @examples
#' na_prop(c(1, 2, NA, 4))
#'
#' na_prop(c(1:9, NA))
#'
#' na_n(c(1, 2, NA, 4, NA, NA, 7))
#'
#' na_n(c(1:9, NA, NA))
#'
#' na_consec(c(1, NA, NA, NA, 2, NA, NA, 7))
#'
#' na_consec(c(rep(NA, 5), 1:2, rep(NA, 6)))
#'
#' na_non_na(c(1, 2, NA, 4, NA, NA, 7))
#'
#' na_non_na(c(1:9, NA, NA))
na_prop <- function(x) UseMethod("na_prop")

#' @export
na_prop.default <- function(x) mean(is.na(x))

#' @export
#' @rdname na_prop
na_n <- function(x) UseMethod("na_n")

#' @export
na_n.default <- function(x) sum(is.na(x))

#' @export
#' @rdname na_prop
na_consec <- function(x) {
  UseMethod("na_consec")
}

#' @export
na_consec.default <- function(x) {
  if (length(x) == 0) 0
  r <- rle(is.na(x))
  m <- r$lengths[r$values]
  if (length(m) > 0) max(m) else 0
}

#' @export
#' @rdname na_prop
na_non_na <- function(x) UseMethod("na_non_na")

#' @export
na_non_na.default <- function(x) sum(!is.na(x))
