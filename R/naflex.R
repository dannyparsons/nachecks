#' naflex: Flexible missing value checks and omit functions.
#'
#' The \code{naflex} package provides greater flexibility for dealing with
#' missing values than the \code{na.rm = TRUE/FALSE} option available in most
#' summary functions in R.
#'
#' Most summary functions in R e.g. \code{mean} provide the option for the two
#' extremes:
#' \itemize{
#' \item calculate the summary ignoring all missing values, \code{na.rm = TRUE}, or
#'
#' \item require no missing values for the summary to be calculated, \code{na.rm =
#' FALSE}
#' }
#' In many applications something in between these two extremes is often
#' appropriate. For example, you may wish to give a summary statistic if less
#' than 10\% of values are missing.
#'
#' \code{naflex} provides helper functions to facilitate this flexibility for
#' dealing with missing values.
#'
#' In particular \code{naflex} provides four types of missing value checks:
#' \itemize{
#' \item a maximum proportion of missing values allowed
#' \item a maximum number of missing values allowed
#' \item a maximum number of consecutive missing values allowed, and
#' \item a minimum number of non-missing values required.
#' }
#' @docType package
#' @name naflex
NULL
