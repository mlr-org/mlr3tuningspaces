test_that("tuning spaces can be applied", {
  data = as.data.table(mlr_tuning_spaces)
  mapply(test_tuning_space, data$key, data$learner)
})