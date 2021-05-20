# nolint start
library(mlr3)
library(mlr3misc)
library(mlr3learners)
library(paradox)
library(R6)

lapply(list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE), source)
# nolint end

test_tuning_space = function(learner, id) {
  learner = lrn(learner)
  learner$param_set$values = mlr_tuning_spaces$get(id)$values
  expect_equal(learner$param_set$values, mlr_tuning_spaces$get(id)$values)
  
  learner = mlr_tuning_spaces$get(id)$get_learner()
  expect_learner(learner)
  expect_names(names(learner$param_set$values), must.include = names(mlr_tuning_spaces$get(id)$values))
}