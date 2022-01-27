
<!-- README.md is generated from README.Rmd. Please edit that file -->

# naflex: Flexible options for handling missing values

<!-- badges: start -->

[![R-CMD-check](https://github.com/dannyparsons/naflex/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dannyparsons/naflex/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/dannyparsons/naflex/branch/master/graph/badge.svg?token=MSQKXE5UYR)](https://app.codecov.io/gh/dannyparsons/naflex)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/naflex)](https://cran.r-project.org/package=naflex)
[![license](https://img.shields.io/badge/license-LGPL%20(%3E=%203)-lightgrey.svg)](https://www.gnu.org/licenses/lgpl-3.0.en.html)
[![DOI](https://zenodo.org/badge/242815229.svg)](https://zenodo.org/badge/latestdoi/242815229)
<!-- badges: end -->

## Overview

The `naflex` R package provides additional flexibility for handling
missing values in summary functions beyond the existing options
(`na.rm = TRUE`/`FALSE`) available in base R.

Most summary functions in base R e.g. `mean`, provide the two extreme
options for handling missing values:

1.  calculate the summary ignoring all missing values (`na.rm = TRUE`),
    or
2.  require no missing values for the summary to be calculated
    (`na.rm = FALSE`)

In many cases, something in between these two extremes is often more
appropriate. For example, you may wish to give a summary statistic if
less than `5%` of values are missing.

`naflex` provides helper functions to facilitate this flexibility. It
allows for omitting missing values conditionally, using four types of
checks:

1.  a maximum proportion of missing values allowed
2.  a maximum number of missing values allowed
3.  a maximum number of consecutive missing values allowed, and
4.  a minimum number of non-missing values required.

## Motivation

The motivating application for producing this package was the
calculation of *Climate Normals*: Long term averages of surface
meteorological measurements that provide benchmark information about the
climate at specific locations e.g. total rainfall and mean temperature.
The World Meteorological Organization (WMO) Guidelines on the
Calculation of Climate Normals<sup id="a1">[1](#f1)</sup> provides
recommendations to standardise these calculations across countries,
including handling of missing values.

For example, it recommendations that a monthly mean value calculated
from daily values should only be calculated when there are no more than
`10` missing values in the month and no more than `4` days of
consecutive missing values. Adhering to such rules using base R requires
doing further calculations and increasing the complexity and length of
code. The aim of `naflex` is to make it easier to apply such rules
routinely and efficiently as part of calculations.

## Installation

Install the current release from CRAN:

``` r
install.packages("naflex")
```

Or install the latest development version from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("dannyparsons/naflex")
```

## Usage

The main function in `naflex` is `na_omit_if`.

When wrapped around a vector in a summary function, `na_omit_if` ensures
that the summary value is calculated when the checks pass, and returns
`NA` if not. The example below shows how to calculate the `mean`,
conditionally on the proportion of missing values.

``` r
library(naflex)

x <- c(1, 3, NA, NA, 3, 2, NA, 5, 8, 7)

# Calculate if 30% or less missing values
mean(na_omit_if(x, prop = 0.3))
#> [1] 4.142857
# Calculate if 20% or less missing values
mean(na_omit_if(x, prop = 0.2))
#> [1] NA
```

Four types of checks are available:

1.  `prop`: the maximum proportion (0 to 1) of missing values allowed
2.  `n`: the maximum number of missing values allowed
3.  `consec`: the maximum number of consecutive missing values allowed,
    and
4.  `n_non`: the minimum number of non-missing values required.

If multiple checks are specified, all checks must pass for missing
values to be removed. For example, although there are less than 4
missing values in `x`, there are two consecutive missing values, hence
the `consec = 1` check fails in the example below the result is `NA`.

``` r
# Calculate if 4 or less missing values and 1 or less consecutive missing values 
mean(na_omit_if(x, n = 4, consec = 1))
#> [1] NA
```

The use of `%>%` (“pipe”) from `magrittr` can be used to make the code
look clearer and more familiar. The beginning of the line is now the
same as standard R and it moves `na_omit_if` after `x` which then
appears more like an option within the function, like `na.rm`, which is
how you might think about `na_omit_if` conceptually in this case.

``` r
require(magrittr)
#> Loading required package: magrittr

sum(x %>% na_omit_if(prop = 0.25))
#> [1] NA
```

Note that you should not use `na_omit_if` with `na.rm = TRUE` in the
summary function since this will always remove missing values so the
checks are essentially ignored.

## How `naflex` works & more details

`na_omit_if` works by removing the missing values from `x` if the checks
pass, and leaving `x` unmodified otherwise.

``` r
# Missing values removed
na_omit_if(x, n = 4)
#> [1] 1 3 3 2 5 8 7
#> attr(,"na.action")
#> [1] 3 4 7
#> attr(,"class")
#> [1] "omit"
```

`na_omit_if` can be thought of like an extension of `stats::na.omit` and
if missing values are removed, an `na.action` attribute and `omit` class
are added for consistency with `stats::na.omit`.

``` r
# Missing values not removed, x is unmodified
na_omit_if(x, n = 2)
#>  [1]  1  3 NA NA  3  2 NA  5  8  7
```

A further set of four `na_omit_if_*` functions are provided for doing
the same thing but restricted to a single check
e.g. `na_omit_if_n(x, 2)`.

`na_check` has the same parameters as `na_omit_if` but returns a logical
indicating whether the checks pass. It is used internally in
`na_omit_if` and may also be a useful helper function.

``` r
if (na_check(x, n = 4, consec = 1)) "NA checks pass" else "NA checks fail"
#> [1] "NA checks fail"
```

A set a four `na_check_*` functions are also provided for doing the same
thing restricted to a single check e.g. `na_check_prop(x, 0.2)`

Finally, `naflex` provides a set of helper functions for calculating
missing value properties used in these checks.

``` r
na_prop(x)
#> [1] 0.3
na_n(x)
#> [1] 3
na_consec(x)
#> [1] 2
na_non_na(x)
#> [1] 7
```

## Compared to base R

In base R, this functionality can often be achieved using a combination
of `ifelse`, `is.na`, `rle` and the option `na.rm = TRUE`.`naflex` aims
to simplify, shorten and standardise this process for users.

For example, the equivalent of:

``` r
mean(na_omit_if(x, n = 4, prop = 0.2))
#> [1] NA
```

in base R is:

``` r
ifelse(sum(is.na(x)) <= 4 && mean(is.na(x)) <= 0.2, mean(x, na.rm = TRUE), NA)
#> [1] NA
```

The check for longest sequence of consecutive missing values is more
complex and requires clever use of the `rle` function. For example,

``` r
mean(na_omit_if(x, consec = 5))
#> [1] 4.142857
```

is equivalent to:

``` r
r <- rle(is.na(x))
m <- r$lengths[r$values]
ifelse(max(m) <= 5, mean(x, na.rm = TRUE), NA)
#> [1] 4.142857
```

## References

<sup id="f1">1</sup>
<a href="https://library.wmo.int/index.php?lvl=notice_display&id=20130#.XljKS84zZnI" target="_blank">WMO
Guidelines on the Calculation of Climate Normals</a> [↩](#a1)
