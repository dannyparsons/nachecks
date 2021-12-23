context("Calculation functions")
library(naflex)

x <- c(1, 2, NA, NA, NA, 6, 7, NA, NA, 10)
y <- c("1", NA, "3", NA, NA)
z <- as.Date(c("1999/1/1", NA, NA, "1999/1/4", "1999/1/5"))
w <- 1:10

test_that("proportion of NA is correct", {
  expect_equal(na_prop(x), 0.5)
  expect_equal(na_prop(y), 0.6)
  expect_equal(na_prop(z), 0.4)
  expect_equal(na_prop(w), 0)
})

test_that("number of NA is correct", {
  expect_equal(na_n(x), 5)
  expect_equal(na_n(y), 3)
  expect_equal(na_n(z), 2)
  expect_equal(na_n(w), 0)
})

test_that("number of non-NA is correct", {
  expect_equal(na_non_na(x), 5)
  expect_equal(na_non_na(y), 2)
  expect_equal(na_non_na(z), 3)
  expect_equal(na_non_na(w), 10)
})

test_that("number of NA + non-NA equals length", {
  expect_equal(na_n(x) + na_non_na(x), length(x))
  expect_equal(na_n(y) + na_non_na(y), length(y))
  expect_equal(na_n(z) + na_non_na(z), length(z))
  expect_equal(na_n(w) + na_non_na(w), length(w))
})

test_that("max number of consecutive NA is correct", {
  expect_equal(na_consec(x), 3)
  expect_equal(na_consec(y), 2)
  expect_equal(na_consec(z), 2)
  expect_equal(na_consec(w), 0)
})
