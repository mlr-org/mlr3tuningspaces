test_that("lts sugar function works", {
  # character dispatch
  tuning_space = lts("classif.rpart.default")
  expect_r6(tuning_space, "TuningSpace")

  # learner dispatch
  learner = lts(lrn("classif.rpart"))
  expect_learner(learner)

  # learner and constants
  learner = lts(lrn("classif.rpart", xval = 1))
  expect_learner(learner)
  expect_equal(learner$param_set$values$xval, 1)
  expect_class(learner$param_set$values$minsplit, "RangeTuneToken")
})

test_that("ltss sugar function works", {
  # character dispatch
  tuning_spaces = ltss(c("classif.rpart.default", "classif.svm.default"))
  expect_list(tuning_spaces, len = 2)
  expect_r6(tuning_spaces[[1]], "TuningSpace")
  expect_r6(tuning_spaces[[2]], "TuningSpace")

  # learner dispatch
  learners = ltss(list(lrn("classif.rpart"), lrn("classif.svm")))
  expect_learner(learners[[1]])
  expect_learner(learners[[2]])

  # learner and constants
  learners = ltss(list(lrn("classif.rpart", xval = 1), lrn("classif.svm", type = "C-classification")))
  expect_learner(learners[[1]])
  expect_learner(learners[[2]])
  expect_equal(learners[[1]]$param_set$values$xval, 1)
  expect_class(learners[[1]]$param_set$values$minsplit, "RangeTuneToken")
  expect_equal(learners[[2]]$param_set$values$type, "C-classification")
  expect_class(learners[[2]]$param_set$values$degree, "RangeTuneToken")
})