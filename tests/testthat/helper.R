# nolint start
library(mlr3)
library(mlr3misc)
library(mlr3learners)
library(paradox)
library(R6)

lapply(list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE), source)
# nolint end

test_tuning_space = function(key, learner) {
  learner = lrn(learner)
  learner$param_set$values = mlr_tuning_spaces$get(key)$values
  expect_equal(learner$param_set$values, mlr_tuning_spaces$get(key)$values)

  learner = mlr_tuning_spaces$get(key)$get_learner()
  expect_learner(learner)
  expect_names(names(learner$param_set$values), must.include = names(mlr_tuning_spaces$get(key)$values))
}

test_package_defaults = function(key) {
  tuning_space = lts(key)
  learner_1 = lrn(tuning_space$learner)
  learner_2 = tuning_space$get_learner()
  task = if ("LearnerClassif" %in% class(learner_1)) tsk("spam") else tsk("mtcars")
  resampling = rsmp("cv", folds = 5)
  resampling$instantiate(task)

  set.seed(4832)
  rr = resample(task, learner_1, resampling)
  score_1 = rr$score()$classif.ce
  set.seed(4832)
  rr = resample(task, learner_2, resampling)
  score_2 = rr$score()$classif.ce

  expect_equal(score_1, score_2)
}
