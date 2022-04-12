test_that("get_learner function works", {
  learner = lts("classif.rpart.default")$get_learner(predict_type = "prob")
  expect_learner(learner)
  expect_equal(learner$predict_type, "prob")
})

test_that("as.dat.table.TuningSpace works", {
  keys =  mlr_tuning_spaces$keys()
  walk(keys, function(key) {
    tab = as.data.table(lts(key))
    expect_data_table(tab)
    expect_names(names(tab), must.include = c("id"))
  })
})
