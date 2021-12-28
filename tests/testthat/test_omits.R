context("Omit functions")
library(naflex)

x <- c(1, 2, NA, NA, NA, 6, 7, NA, NA, 10)
y <- c("1", NA, "3", NA, NA)
z <- as.Date(c("1999/1/1", NA, NA, "1999/1/4", "1999/1/5"))
w <- 1:10

x_omit <- na.omit(x)
y_omit <- na.omit(y)
z_omit <- na.omit(z)
w_omit <- na.omit(w)

test_that("proportion of NA check passes and omits", {
  expect_equal(na_omit_if_prop(x, 0.6), x_omit)
  expect_equal(na_omit_if_prop(x, 0.8), x_omit)
  expect_equal(na_omit_if_prop(y, 0.9), y_omit)
  expect_equal(na_omit_if_prop(y, 0.7), y_omit)
  expect_equal(na_omit_if_prop(z, 0.45), z_omit)
  expect_equal(na_omit_if_prop(z, 0.43), z_omit)
  expect_equal(na_omit_if_prop(w, 0), w_omit)
})

test_that("proportion of NA check fails and doesn't omit", {
  expect_equal(na_omit_if_prop(x, 0.4), x)
  expect_equal(na_omit_if_prop(x, 0.01), x)
  expect_equal(na_omit_if_prop(y, 0.1), y)
  expect_equal(na_omit_if_prop(y, 0.15), y)
  expect_equal(na_omit_if_prop(z, 0.05), z)
  expect_equal(na_omit_if_prop(z, 0.2), z)
})

test_that("strict = TRUE in na_omit_if_prop doesn't omit on boundary", {
  expect_equal(na_omit_if_prop(x, 0.5, TRUE), x)
  expect_equal(na_omit_if_prop(y, 0.6, TRUE), y)
  expect_equal(na_omit_if_prop(z, 0.4, TRUE), z)
})

test_that("na_omit_if_prop omits when prop missing", {
  expect_equal(na_omit_if_prop(x), x_omit)
  expect_equal(na_omit_if_prop(y), y_omit)
  expect_equal(na_omit_if_prop(z), z_omit)
  expect_equal(na_omit_if_prop(w), w_omit)
})

test_that("number of NA check passes and omits", {
  expect_equal(na_omit_if_n(x, 6), x_omit)
  expect_equal(na_omit_if_n(x, 60), x_omit)
  expect_equal(na_omit_if_n(y, 4), y_omit)
  expect_equal(na_omit_if_n(y, 100), y_omit)
  expect_equal(na_omit_if_n(z, 3), z_omit)
  expect_equal(na_omit_if_n(z, 8), z_omit)
  expect_equal(na_omit_if_n(w, 0), w_omit)
})

test_that("number of NA check fails and doesn't omit", {
  expect_equal(na_omit_if_n(x, 4), x)
  expect_equal(na_omit_if_n(x, 3), x)
  expect_equal(na_omit_if_n(y, 0), y)
  expect_equal(na_omit_if_n(y, 2), y)
  expect_equal(na_omit_if_n(z, 0), z)
})

test_that("number of NA check omits without threshold", {
  expect_equal(na_omit_if_n(x), x_omit)
  expect_equal(na_omit_if_n(y), y_omit)
  expect_equal(na_omit_if_n(z), z_omit)
  expect_equal(na_omit_if_n(w), w_omit)
})

test_that("number of non-NA check passes and omits", {
  expect_equal(na_omit_if_non_na(x, 5), x_omit)
  expect_equal(na_omit_if_non_na(x, 3), x_omit)
  expect_equal(na_omit_if_non_na(y, 1), y_omit)
  expect_equal(na_omit_if_non_na(y, 2), y_omit)
  expect_equal(na_omit_if_non_na(z, 2), z_omit)
  expect_equal(na_omit_if_non_na(z, 3), z_omit)
  expect_equal(na_omit_if_non_na(w, 10), w_omit)
})

test_that("number of non-NA check fails and doesn't omit", {
  expect_equal(na_omit_if_non_na(x, 6), x)
  expect_equal(na_omit_if_non_na(x, 60), x)
  expect_equal(na_omit_if_non_na(y, 3), y)
  expect_equal(na_omit_if_non_na(y, 21), y)
  expect_equal(na_omit_if_non_na(z, 4), z)
  expect_equal(na_omit_if_non_na(z, 5), z)
})

test_that("number of non-NA check omits without threshold", {
  expect_equal(na_omit_if_non_na(x), x_omit)
  expect_equal(na_omit_if_non_na(y), y_omit)
  expect_equal(na_omit_if_non_na(z), z_omit)
  expect_equal(na_omit_if_non_na(w), w_omit)
})

test_that("max number of consecutive NA check passes and omits", {
  expect_equal(na_omit_if_consec(x, 3), x_omit)
  expect_equal(na_omit_if_consec(x, 5), x_omit)
  expect_equal(na_omit_if_consec(y, 2), y_omit)
  expect_equal(na_omit_if_consec(y, 6), y_omit)
  expect_equal(na_omit_if_consec(z, 2), z_omit)
  expect_equal(na_omit_if_consec(z, 56), z_omit)
})

test_that("max number of consecutive NA check fails and doesn't omit", {
  expect_equal(na_omit_if_consec(x, 2), x)
  expect_equal(na_omit_if_consec(x, 0), x)
  expect_equal(na_omit_if_consec(y, 1), y)
  expect_equal(na_omit_if_consec(y, 0), y)
  expect_equal(na_omit_if_consec(z, 1), z)
  expect_equal(na_omit_if_consec(z, 0), z)
})

test_that("max number of consecutive NA omits without threshold", {
  expect_equal(na_omit_if_consec(x), x_omit)
  expect_equal(na_omit_if_consec(y), y_omit)
  expect_equal(na_omit_if_consec(z), z_omit)
})

test_that("na_omit_if omits with no checks", {
  expect_equal(na_omit_if(x), x_omit)
  expect_equal(na_omit_if(y), y_omit)
  expect_equal(na_omit_if(z), z_omit)
  expect_equal(na_omit_if(w), w_omit)
})

test_that("na_omit_if omits with prop and n conditions", {
  expect_equal(na_omit_if(x, prop = 0.5, n = 6), x_omit)
  expect_equal(na_omit_if(y, prop = 0.7, n = 3), y_omit)
  expect_equal(na_omit_if(z, prop = 0.45, n = 50), z_omit)
  expect_equal(na_omit_if(w, prop = 0.05, n = 0), w_omit)
})

test_that("na_omit_if omits with prop and n_non conditions", {
  expect_equal(na_omit_if(x, prop = 0.6, n_non = 5), x_omit)
  expect_equal(na_omit_if(y, prop = 0.8, n_non = 0), y_omit)
  expect_equal(na_omit_if(z, prop = 0.9, n_non = 2), z_omit)
  expect_equal(na_omit_if(w, prop = 0.1, n_non = 10), w_omit)
})

test_that("na_omit_if omits with four passing conditions", {
  expect_equal(na_omit_if(x, prop = 0.5, n = 6, consec = 4, n_non = 5), x_omit)
  expect_equal(na_omit_if(y, prop = 0.61, n = 4, consec = 2, n_non = 2), y_omit)
  expect_equal(na_omit_if(z, prop = 0.75, n = 2, consec = 2, n_non = 2), z_omit)
  expect_equal(na_omit_if(w, prop = 0, n = 0, consec = 0, n_non = 10), w_omit)
})

test_that("na_omit_if doesn't omit with three passing
          and one failing condition", {
  expect_equal(na_omit_if(x, prop = 0.5, n = 6, consec = 2, n_non = 5), x)
  expect_equal(na_omit_if(y, prop = 0.55, n = 4, consec = 2, n_non = 2), y)
  expect_equal(na_omit_if(z, prop = 0.75, n = 1, consec = 2, n_non = 2), z)
})
