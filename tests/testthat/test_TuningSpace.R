test_that("get_learner function works", {
  learner = lts("classif.rpart.default")$get_learner(predict_type = "prob")
  expect_learner(learner)
  expect_equal(learner$predict_type, "prob")
})
