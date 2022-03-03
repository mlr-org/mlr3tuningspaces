test_that("mlr_tuning_spaces", {
  expect_dictionary(mlr_tuning_spaces, min_items = 1L)
  keys = mlr_tuning_spaces$keys()

  for (key in keys) {
    tuning_space = lts(key)
    expect_r6(tuning_space, "TuningSpace")
  }
})

test_that("lts character dispatch works", {
  tuning_space = lts("classif.rpart.default")
  expect_r6(tuning_space, "TuningSpace")
})

test_that("lts learner dispatch works", {
  learner = lts(lrn("classif.rpart"))
  expect_learner(learner)
})

test_that("lts learner dispatch with constants works", {
  learner = lts(lrn("classif.rpart", xval = 1))
  expect_learner(learner)
  expect_equal(learner$param_set$values$xval, 1)
  expect_class(learner$param_set$values$minsplit, "RangeTuneToken")
})

test_that("ltss character dispatch works", {
  tuning_spaces = ltss(c("classif.rpart.default", "classif.svm.default"))
  expect_list(tuning_spaces, len = 2)
  expect_r6(tuning_spaces[[1]], "TuningSpace")
  expect_r6(tuning_spaces[[2]], "TuningSpace")
})

test_that("ltss learner dispatch works", {
  learners = ltss(list(lrn("classif.rpart"), lrn("classif.svm")))
  expect_learner(learners[[1]])
  expect_learner(learners[[2]])
})

test_that("ltss learner dispatch with constants works", {
  learners = ltss(list(lrn("classif.rpart", xval = 1), lrn("classif.svm", type = "C-classification")))
  expect_learner(learners[[1]])
  expect_learner(learners[[2]])
  expect_equal(learners[[1]]$param_set$values$xval, 1)
  expect_class(learners[[1]]$param_set$values$minsplit, "RangeTuneToken")
  expect_equal(learners[[2]]$param_set$values$type, "C-classification")
  expect_class(learners[[2]]$param_set$values$degree, "RangeTuneToken")
})

test_that("as.data.table objects parameter", {
  tab = as.data.table(mlr_tuning_spaces, objects = TRUE)
  expect_data_table(tab)
  expect_list(tab$object, "TuningSpace", any.missing = FALSE)
})
