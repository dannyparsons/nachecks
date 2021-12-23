
<!-- README.md is generated from README.Rmd. Please edit that file -->

# naflex: Flexible options for handling missing values

<!-- badges: start -->

[![R-CMD-check](https://github.com/dannyparsons/naflex/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dannyparsons/naflex/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/dannyparsons/naflex/branch/master/graph/badge.svg?token=MSQKXE5UYR)](https://codecov.io/gh/dannyparsons/naflex)
<!-- badges: end -->

The `naflex` R package provides additional flexibility for handling
missing values in summary functions beyond the existing () options
available in base R.

Most summary functions in base R e.g. `mean`, provide the two extreme
options for handling missing values:

1.  calculate the summary ignoring all missing values (`na.rm = TRUE`),
    or
2.  require no missing values for the summary to be calculated (na.rm =
    FALSE\`)

In many cases, something in between these two extremes is often more
appropriate. For example, you may wish to give a summary statistic if
less than `5%` of values are missing.

`naflex` provides helper functions to facilitate this flexibility. It
allows for omitting missing values conditionally, using four types of
requirements: - a maximum proportion of missing values allowed - a
maximum number of missing values allowed - a maximum number of
consecutive missing values allowed, and - a minimum number of
non-missing values required.

## Installation

``` r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("dannyparsons/naflex")
```

## Usage

The main function in `naflex` is `na_omit_if`. When wrapped around a
vector inside a summary function, it ensures the summary function
returns

## Compared to base R

You can do this by first calculating the proportion of missing values
and then using `na.rm = TRUE` as appropriate. `naflex` aims to simplify
this process.

## Relevance to applications

The World Meteorological Organization (WMO) Guidelines on the
Calculation of Climate Normals<sup id="a1">[1](#f1)</sup> recommends
that a monthly mean value calculated from daily values should be
calculated as long as there are no more than `10` missing values and no
more than `4` consecutive missing values in the month.

# References

<sup id="f1">1</sup>
<a href="https://library.wmo.int/index.php?lvl=notice_display&id=20130#.XljKS84zZnI">WMO
Guidelines on the Calculation of Climate Normals</a> [↩](#a1)
