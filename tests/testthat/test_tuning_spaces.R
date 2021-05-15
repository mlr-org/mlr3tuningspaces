test_that("tuning spaces can be applied", {
  lapply(mlr_tuning_spaces$keys(), function(key) {
    tuning_space = mlr_tuning_spaces$get(key)
    test_tuning_space(tuning_space$learner, tuning_space$id)
  })
})