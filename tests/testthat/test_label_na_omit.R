context("Omit if functions")
library(naflex)

x <- c(1, 2, NA, NA, NA, 6, 7, NA, NA, 10)
y <- c("1", NA, "3", NA, NA)
z <- as.Date(c("1999/1/1", NA, NA, "1999/1/4", "1999/1/5"))
w <- 1:10

test_that("NA values removed correctly in na_omit_if_prop", {
  expect_equal(as.vector(label_na_omit(x)), as.vector(na.omit(x)))
  expect_equal(as.vector(label_na_omit(y)), as.vector(na.omit(y)))
  expect_equal(as.vector(label_na_omit(z)), as.vector(na.omit(z)))
  expect_equal(as.vector(label_na_omit(w)), as.vector(na.omit(w)))
})

test_that("na.action is consistent with na.omit() in label_na_omit", {
  expect_equal(attr(label_na_omit(x), "na.action"), attr(na.omit(x), "na.action"))
  expect_equal(attr(label_na_omit(y), "na.action"), attr(na.omit(y), "na.action"))
  expect_equal(attr(label_na_omit(z), "na.action"), attr(na.omit(z), "na.action"))
  expect_equal(attr(label_na_omit(w), "na.action"), attr(na.omit(w), "na.action"))
})
