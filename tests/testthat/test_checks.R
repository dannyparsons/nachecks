context("Check functions")
library(naflex)

x <- c(1, 2, NA, NA, NA, 6, 7, NA, NA, 10)
y <- c("1", NA, "3", NA, NA)
z <- as.Date(c("1999/1/1", NA, NA, "1999/1/4", "1999/1/5"))
w <- 1:10

test_that("proportion of NA threshold passes", {
  expect_equal(check_prop_na(x, 0.6), TRUE)
  expect_equal(check_prop_na(x, 0.8), TRUE)
  expect_equal(check_prop_na(y, 0.9), TRUE)
  expect_equal(check_prop_na(y, 0.7), TRUE)
  expect_equal(check_prop_na(z, 0.45), TRUE)
  expect_equal(check_prop_na(z, 0.43), TRUE)
  expect_equal(check_prop_na(w, 0), TRUE)
})

test_that("proportion of NA threshold fails", {
  expect_equal(check_prop_na(x, 0.4), FALSE)
  expect_equal(check_prop_na(x, 0.01), FALSE)
  expect_equal(check_prop_na(y, 0.1), FALSE)
  expect_equal(check_prop_na(y, 0.15), FALSE)
  expect_equal(check_prop_na(z, 0.05), FALSE)
  expect_equal(check_prop_na(z, 0.2), FALSE)
})

test_that("strict = TRUE in prop_na returns FALSE on boundary", {
  expect_equal(check_prop_na(x, 0.5, TRUE), FALSE)
  expect_equal(check_prop_na(y, 0.6, TRUE), FALSE)
  expect_equal(check_prop_na(x, 0.4, TRUE), FALSE)
})

test_that("proportion check passes without threshold", {
  expect_equal(check_prop_na(x), TRUE)
  expect_equal(check_prop_na(y), TRUE)
  expect_equal(check_prop_na(z), TRUE)
  expect_equal(check_prop_na(w), TRUE)
})

test_that("number of NA threshold passes", {
  expect_equal(check_n_na(x, 6), TRUE)
  expect_equal(check_n_na(x, 60), TRUE)
  expect_equal(check_n_na(y, 4), TRUE)
  expect_equal(check_n_na(y, 100), TRUE)
  expect_equal(check_n_na(z, 3), TRUE)
  expect_equal(check_n_na(z, 8), TRUE)
  expect_equal(check_n_na(w, 0), TRUE)
})

test_that("number of NA threshold fails", {
  expect_equal(check_n_na(x, 4), FALSE)
  expect_equal(check_n_na(x, 3), FALSE)
  expect_equal(check_n_na(y, 0), FALSE)
  expect_equal(check_n_na(y, 2), FALSE)
  expect_equal(check_n_na(z, 0), FALSE)
  expect_equal(check_n_na(x, 1), FALSE)
})

test_that("number of NA check passes without threshold", {
  expect_equal(check_n_na(x), TRUE)
  expect_equal(check_n_na(y), TRUE)
  expect_equal(check_n_na(z), TRUE)
  expect_equal(check_n_na(w), TRUE)
})

test_that("number of non-NA threshold passes", {
  expect_equal(check_n_non_na(x, 5), TRUE)
  expect_equal(check_n_non_na(x, 3), TRUE)
  expect_equal(check_n_non_na(y, 1), TRUE)
  expect_equal(check_n_non_na(y, 2), TRUE)
  expect_equal(check_n_non_na(z, 2), TRUE)
  expect_equal(check_n_non_na(z, 3), TRUE)
  expect_equal(check_n_non_na(w, 10), TRUE)
})

test_that("number of non-NA threshold fails", {
  expect_equal(check_n_non_na(x, 6), FALSE)
  expect_equal(check_n_non_na(x, 60), FALSE)
  expect_equal(check_n_non_na(y, 3), FALSE)
  expect_equal(check_n_non_na(y, 21), FALSE)
  expect_equal(check_n_non_na(z, 4), FALSE)
  expect_equal(check_n_non_na(z, 5), FALSE)
})

test_that("number of non-NA check passes without threshold", {
  expect_equal(check_n_non_na(x), TRUE)
  expect_equal(check_n_non_na(y), TRUE)
  expect_equal(check_n_non_na(z), TRUE)
  expect_equal(check_n_non_na(w), TRUE)
})

test_that("max number of consecutive NA threshold passes", {
  expect_equal(check_consec_na(x, 3), TRUE)
  expect_equal(check_consec_na(x, 5), TRUE)
  expect_equal(check_consec_na(y, 2), TRUE)
  expect_equal(check_consec_na(y, 6), TRUE)
  expect_equal(check_consec_na(z, 2), TRUE)
  expect_equal(check_consec_na(z, 56), TRUE)
})

test_that("max number of consecutive NA threshold fails", {
  expect_equal(check_consec_na(x, 2), FALSE)
  expect_equal(check_consec_na(x, 0), FALSE)
  expect_equal(check_consec_na(y, 1), FALSE)
  expect_equal(check_consec_na(y, 0), FALSE)
  expect_equal(check_consec_na(z, 1), FALSE)
  expect_equal(check_consec_na(z, 0), FALSE)
})

test_that("max number of consecutive NA passes without threshold", {
  expect_equal(check_consec_na(x), TRUE)
  expect_equal(check_consec_na(y), TRUE)
  expect_equal(check_consec_na(z), TRUE)
})

test_that("check_na passes with no conditions", {
  expect_equal(check_na(x), TRUE)
  expect_equal(check_na(y), TRUE)
  expect_equal(check_na(z), TRUE)
  expect_equal(check_na(w), TRUE)
})

test_that("check_na passes with no conditions", {
  expect_equal(check_na(x), TRUE)
  expect_equal(check_na(y), TRUE)
  expect_equal(check_na(z), TRUE)
  expect_equal(check_na(w), TRUE)
})

test_that("check_na passes with prop and na conditions", {
  expect_equal(check_na(x, prop = 0.5, na = 6), TRUE)
  expect_equal(check_na(y, prop = 0.7, na = 3), TRUE)
  expect_equal(check_na(z, prop = 0.45, na = 50), TRUE)
  expect_equal(check_na(w, prop = 0.05, na = 0), TRUE)
})

test_that("check_na passes with prop and non_na conditions", {
  expect_equal(check_na(x, prop = 0.6, non_na = 5), TRUE)
  expect_equal(check_na(y, prop = 0.8, non_na = 0), TRUE)
  expect_equal(check_na(z, prop = 0.9, non_na = 2), TRUE)
  expect_equal(check_na(w, prop = 0.1, non_na = 10), TRUE)
})

test_that("check_na passes with four conditions", {
  expect_equal(check_na(x, prop = 0.5, n = 6, consec = 4, non_na = 5), TRUE)
  expect_equal(check_na(y, prop = 0.61, n = 4, consec = 2, non_na = 2), TRUE)
  expect_equal(check_na(z, prop = 0.75, n = 2, consec = 2, non_na = 2), TRUE)
  expect_equal(check_na(w, prop = 0, n = 0, consec = 0, non_na = 10), TRUE)
})
