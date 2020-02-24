### Omit functions returning x modified/unmodified
na_omit_if <- function(x, prop, na, consec, non_na,
                       prop_strict = FALSE) {
  if (check_na(x = x, prop = prop, na = na, consec = consec,
               non_na = non_na, prop_strict = prop_strict)) {
    x[!is.na(x)]
  } else x
}

na_omit_if_prop <- function(x, prop, strict = FALSE) {
  if (check_prop_na(x = x, prop = prop, strict = strict)) {
    omit <- which(is.na(x))
    x[-omit]
    attr(omit, "class") <- "omit"
    attr(x, "na.action") <- omit
  } else x
}

na_omit_if_n <- function(x, n) {
  if (check_n_na(x = x, n = n)) {
    x[!is.na(x)]
  } else x
}

na_omit_if_non_na <- function(x, n) {
  if (check_n_non_na(x = x, n = n)) {
    x[!is.na(x)]
  } else x
}

na_omit_if_consec <- function(x, n) {
  if (check_consec_na(x = x, n = n)) {
    x[!is.na(x)]
  } else x
}

label_omit <- function(x) {
  omit <- which(is.na(x))
  x <- x[-omit]
  attr(omit, "class") <- "omit"
  attr(x, "na.action") <- omit
}
