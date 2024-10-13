# naflex 0.1.1

* Internal updates and bug fixes:
* Added "_PACKAGE" to naflex.R, ensuring proper package structure.
* Updated the package testing and build checks, which were out of date and causing failures. Now using the standard checks recommended for R packages.

# naflex 0.1.0

* Initial CRAN release

## Features

* `na_omit_if` function for conditionally removing missing values if specified checks pass.

* Four types of checks are available:

  * `prop`: the maximum proportion (0 to 1) of missing values allowed
  * `n`: the maximum number of missing values allowed
  * `consec`: the maximum number of consecutive missing values allowed, and
  * `n_non`: the minimum number of non-missing values required.


* Four `na_omit_if_*` functions similar to `na_omit_if()` but for individual checks only
* `na_check()` and four `na_check_*` function corresponding to the `na_omit_if` functions but return `TRUE` or `FALSE`
* Four `na_*` functions for calculating the properties of missing values in a vector used in other functions
