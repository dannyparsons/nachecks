context("Check functions")
library(naflex)

x <- c(1, 2, NA, NA, NA, 6, 7, NA, NA, 10)
y <- c("1", NA, "3", NA, NA)
z <- as.Date(c("1999/1/1", NA, NA, "1999/1/4", "1999/1/5"))
w <- 1:10

test_that("proportion of NA threshold passes", {
  expect_equal(na_check_prop(x, 0.6), TRUE)
  expect_equal(na_check_prop(x, 0.8), TRUE)
  expect_equal(na_check_prop(y, 0.9), TRUE)
  expect_equal(na_check_prop(y, 0.7), TRUE)
  expect_equal(na_check_prop(z, 0.45), TRUE)
  expect_equal(na_check_prop(z, 0.43), TRUE)
  expect_equal(na_check_prop(w, 0), TRUE)
})

test_that("proportion of NA threshold fails", {
  expect_equal(na_check_prop(x, 0.4), FALSE)
  expect_equal(na_check_prop(x, 0.01), FALSE)
  expect_equal(na_check_prop(y, 0.1), FALSE)
  expect_equal(na_check_prop(y, 0.15), FALSE)
  expect_equal(na_check_prop(z, 0.05), FALSE)
  expect_equal(na_check_prop(z, 0.2), FALSE)
})

test_that("strict = TRUE in na_prop returns FALSE on boundary", {
  expect_equal(na_check_prop(x, 0.5, TRUE), FALSE)
  expect_equal(na_check_prop(y, 0.6, TRUE), FALSE)
  expect_equal(na_check_prop(z, 0.4, TRUE), FALSE)
})

test_that("proportion check passes without threshold", {
  expect_equal(na_check_prop(x), TRUE)
  expect_equal(na_check_prop(y), TRUE)
  expect_equal(na_check_prop(z), TRUE)
  expect_equal(na_check_prop(w), TRUE)
})

test_that("number of NA threshold passes", {
  expect_equal(na_check_n(x, 6), TRUE)
  expect_equal(na_check_n(x, 60), TRUE)
  expect_equal(na_check_n(y, 4), TRUE)
  expect_equal(na_check_n(y, 100), TRUE)
  expect_equal(na_check_n(z, 3), TRUE)
  expect_equal(na_check_n(z, 8), TRUE)
  expect_equal(na_check_n(w, 0), TRUE)
})

test_that("number of NA threshold fails", {
  expect_equal(na_check_n(x, 4), FALSE)
  expect_equal(na_check_n(x, 3), FALSE)
  expect_equal(na_check_n(y, 0), FALSE)
  expect_equal(na_check_n(y, 2), FALSE)
  expect_equal(na_check_n(z, 0), FALSE)
})

test_that("number of NA check passes without threshold", {
  expect_equal(na_check_n(x), TRUE)
  expect_equal(na_check_n(y), TRUE)
  expect_equal(na_check_n(z), TRUE)
  expect_equal(na_check_n(w), TRUE)
})

test_that("number of non-NA threshold passes", {
  expect_equal(na_check_non_na(x, 5), TRUE)
  expect_equal(na_check_non_na(x, 3), TRUE)
  expect_equal(na_check_non_na(y, 1), TRUE)
  expect_equal(na_check_non_na(y, 2), TRUE)
  expect_equal(na_check_non_na(z, 2), TRUE)
  expect_equal(na_check_non_na(z, 3), TRUE)
  expect_equal(na_check_non_na(w, 10), TRUE)
})

test_that("number of non-NA threshold fails", {
  expect_equal(na_check_non_na(x, 6), FALSE)
  expect_equal(na_check_non_na(x, 60), FALSE)
  expect_equal(na_check_non_na(y, 3), FALSE)
  expect_equal(na_check_non_na(y, 21), FALSE)
  expect_equal(na_check_non_na(z, 4), FALSE)
  expect_equal(na_check_non_na(z, 5), FALSE)
})

test_that("number of non-NA check passes without threshold", {
  expect_equal(na_check_non_na(x), TRUE)
  expect_equal(na_check_non_na(y), TRUE)
  expect_equal(na_check_non_na(z), TRUE)
  expect_equal(na_check_non_na(w), TRUE)
})

test_that("max number of consecutive NA threshold passes", {
  expect_equal(na_check_consec(x, 3), TRUE)
  expect_equal(na_check_consec(x, 5), TRUE)
  expect_equal(na_check_consec(y, 2), TRUE)
  expect_equal(na_check_consec(y, 6), TRUE)
  expect_equal(na_check_consec(z, 2), TRUE)
  expect_equal(na_check_consec(z, 56), TRUE)
})

test_that("max number of consecutive NA threshold fails", {
  expect_equal(na_check_consec(x, 2), FALSE)
  expect_equal(na_check_consec(x, 0), FALSE)
  expect_equal(na_check_consec(y, 1), FALSE)
  expect_equal(na_check_consec(y, 0), FALSE)
  expect_equal(na_check_consec(z, 1), FALSE)
  expect_equal(na_check_consec(z, 0), FALSE)
})

test_that("max number of consecutive NA passes without threshold", {
  expect_equal(na_check_consec(x), TRUE)
  expect_equal(na_check_consec(y), TRUE)
  expect_equal(na_check_consec(z), TRUE)
})

test_that("na_check passes with no conditions", {
  expect_equal(na_check(x), TRUE)
  expect_equal(na_check(y), TRUE)
  expect_equal(na_check(z), TRUE)
  expect_equal(na_check(w), TRUE)
})

test_that("na_check passes with prop and n conditions", {
  expect_equal(na_check(x, prop = 0.5, n = 6), TRUE)
  expect_equal(na_check(y, prop = 0.7, n = 3), TRUE)
  expect_equal(na_check(z, prop = 0.45, n = 50), TRUE)
  expect_equal(na_check(w, prop = 0.05, n = 0), TRUE)
})

test_that("na_check passes with prop and n_non conditions", {
  expect_equal(na_check(x, prop = 0.6, n_non = 5), TRUE)
  expect_equal(na_check(y, prop = 0.8, n_non = 0), TRUE)
  expect_equal(na_check(z, prop = 0.9, n_non = 2), TRUE)
  expect_equal(na_check(w, prop = 0.1, n_non = 10), TRUE)
})

test_that("na_check passes with four conditions", {
  expect_equal(na_check(x, prop = 0.5, n = 6, consec = 4, n_non = 5), TRUE)
  expect_equal(na_check(y, prop = 0.61, n = 4, consec = 2, n_non = 2), TRUE)
  expect_equal(na_check(z, prop = 0.75, n = 2, consec = 2, n_non = 2), TRUE)
  expect_equal(na_check(w, prop = 0, n = 0, consec = 0, n_non = 10), TRUE)
})
