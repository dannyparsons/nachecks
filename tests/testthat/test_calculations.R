context("Calculation functions")
library(naflex)

x <- c(1, 2, NA, NA, NA, 6, 7, NA, NA, 10)
y <- c("1", NA, "3", NA, NA)
z <- as.Date(c("1999/1/1", NA, NA, "1999/1/4", "1999/1/5"))
w <- 1:10

test_that("proportion of NA is correct", {
  expect_equal(prop_na(x), 0.5)
  expect_equal(prop_na(y), 0.6)
  expect_equal(prop_na(z), 0.4)
  expect_equal(prop_na(w), 0)
})

test_that("number of NA is correct", {
  expect_equal(n_na(x), 5)
  expect_equal(n_na(y), 3)
  expect_equal(n_na(z), 2)
  expect_equal(n_na(w), 0)
})

test_that("number of non-NA is correct", {
  expect_equal(n_non_na(x), 5)
  expect_equal(n_non_na(y), 2)
  expect_equal(n_non_na(z), 3)
  expect_equal(n_non_na(w), 10)
})

test_that("number of NA + non-NA equals length", {
  expect_equal(n_na(x) + n_non_na(x), length(x))
  expect_equal(n_na(y) + n_non_na(y), length(y))
  expect_equal(n_na(z) + n_non_na(z), length(z))
  expect_equal(n_na(w) + n_non_na(w), length(w))
})

test_that("max number of consecutive NA is correct", {
  expect_equal(consec_na(x), 3)
  expect_equal(consec_na(y), 2)
  expect_equal(consec_na(z), 2)
  expect_equal(consec_na(w), 0)
})
