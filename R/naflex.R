#' naflex: Flexible missing value checks and omit functions.
#'
#' The \code{naflex} package provides greater flexibility for dealing with missing values, particularly when calculating summaries.
#'
#' na omit if functions, na check functions and na calculation functions.
#'
#' @section na omit functions:
#' na omit if functions omit missing values in a vector if specified conditions are met.
#' The general function is \code{na_omit_if} which allows for specify four type of missing value checks:
#' (\code{prop}) a maximum proportion of missing values  allowed
#' (\code{na}) a maximum number of missing values allowed
#' (\code{consec}) a maximum number of consecutive missing values, and
#' (\code{non_na}) a minimum number of non-missing values required.
#'
#' @docType package
#' @name naflex
NULL
