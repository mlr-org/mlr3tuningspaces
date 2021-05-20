test_that("as.data.table works for TuningSpaces", {
  tab = as.data.table(mlr_tuning_spaces)
  expect_names(colnames(tab), identical.to = c("key", "learner", "n_values"))
})
