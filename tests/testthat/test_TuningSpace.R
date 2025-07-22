test_that("get_learner function works", {
  learner = lts("classif.rpart.default")$get_learner(predict_type = "prob")
  expect_learner(learner)
  expect_equal(learner$predict_type, "prob")
})

test_that("get_learner function works with added parameters", {
  search_space = lts("classif.xgboost.default", min_child_weight = to_tune(0, 10))

  expect_class(search_space$get_learner()$param_set$values$min_child_weight, "TuneToken")
})

test_that("get_learner function works with changed parameters", {
  search_space = lts("classif.xgboost.default", nrounds = to_tune(1, 10000))

  expect_equal(search_space$get_learner()$param_set$values$nrounds$content$upper, 10000)
})

test_that("as.data.table.TuningSpace works", {
  keys =  mlr_tuning_spaces$keys()
  walk(keys, function(key) {
    tab = as.data.table(lts(key))
    expect_data_table(tab)
    expect_names(names(tab), must.include = c("id"))
  })
})
