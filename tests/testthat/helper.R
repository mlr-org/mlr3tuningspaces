# nolint start
library(mlr3)
library(mlr3misc)
library(mlr3learners)
library(paradox)
library(R6)

lapply(list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE), source)
# nolint end

test_tuning_space = function(learner, set) {
  learner = lrn(learner)
  learner$param_set$values = mlr_tuning_spaces$get(set)$values
  expect_equal(learner$param_set$values, mlr_tuning_spaces$get(set)$values)
  
  learner = learner$get_learner()
  expect_learner(learner)
  expect_equal(learner$param_set$values, mlr_tuning_spaces$get(set)$values)
}