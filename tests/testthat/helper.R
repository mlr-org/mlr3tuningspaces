# nolint start
library(mlr3)
library(mlr3misc)
library(mlr3learners)
library(mlr3torch)
library(paradox)
library(R6)

# lapply(list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE), source)
# nolint end

test_tuning_space = function(key, learner) {
  learner = lrn(learner)
  learner$param_set$values = mlr_tuning_spaces$get(key)$values
  expect_equal_sorted(learner$param_set$values, mlr_tuning_spaces$get(key)$values)

  learner = mlr_tuning_spaces$get(key)$get_learner()
  expect_learner(learner)
  expect_names(names(learner$param_set$values), must.include = names(mlr_tuning_spaces$get(key)$values))
}

sortnames = function(x) {
  if (!is.null(names(x))) {
    x <- x[order(names(x), decreasing = TRUE)]
  }
  x
}

expect_equal_sorted = function(x, y, ...) {
  expect_equal(sortnames(x), sortnames(y), ...)
}
