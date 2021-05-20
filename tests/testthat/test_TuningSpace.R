test_that("TuningSpaces construction", {
  # check that we cannot construct wrong tuning spaces
  set = list(
    minsplit = to_tune(2, 128, logscale = TRUE)
  )
  add_tuning_space("regr.svm.broken", set, "regression", "regr.svm")
  a = lts("regr.svm.broken")
  expect_error(a$get_learner(), "minsplit")
})

test_that("TuningSpaces$get_learner() works", {
  learner = lts("classif.rpart.default")$get_learner(predict_type = "prob")
  expect_learner(learner)
  expect_equal(learner$predict_type, "prob")
})
