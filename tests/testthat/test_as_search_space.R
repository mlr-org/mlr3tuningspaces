test_that("as_search_space on TuningSpace works", {
  tuning_space = lts("classif.rpart.default")
  search_space = as_search_space(tuning_space)
  expect_r6(search_space, "ParamSet")
  expect_set_equal(search_space$ids(), c("minsplit", "minbucket", "cp"))
})

test_that("search space from TuningSpace works", {
  tuning_space = lts("classif.rpart.default")
  instance = TuningInstanceSingleCrit$new(task = tsk("iris"), learner = lrn("classif.rpart"),
    resampling = rsmp("holdout"), measure = msr("classif.ce"),
    terminator = trm("evals", n_evals = 1), search_space = tuning_space)

  expect_r6(instance$search_space, "ParamSet")
  expect_set_equal(instance$search_space$ids(), c("minsplit", "minbucket", "cp"))
})

test_that("search space from TuningSpace works", {
  tuning_space = lts("classif.rpart.default")
  instance = TuningInstanceMultiCrit$new(task = tsk("iris"), learner = lrn("classif.rpart"),
    resampling = rsmp("holdout"), measures = msrs(c("classif.ce", "classif.acc")),
    terminator = trm("evals", n_evals = 1), search_space = tuning_space)

  expect_r6(instance$search_space, "ParamSet")
  expect_set_equal(instance$search_space$ids(), c("minsplit", "minbucket", "cp"))
})

test_that("search space from TuningSpace works", {
  tuning_space = lts("classif.rpart.default")
  at = AutoTuner$new(learner = lrn("classif.rpart"), resampling = rsmp("holdout"),
    measure = msr("classif.ce"), terminator = trm("evals", n_evals = 1),
    search_space = tuning_space, tuner = tnr("random_search"))

  expect_r6(at$instance_args$search_space, "ParamSet")
  expect_set_equal(at$instance_args$search_space$ids(), c("minsplit", "minbucket", "cp"))
})

test_that("as_search_space works with added parameters", {
  search_space = lts("classif.xgboost.default", min_child_weight = to_tune(0, 10))

  expect_names(as_search_space(search_space)$ids(), must.include = "min_child_weight")
})

test_that("as_search_space works with changed parameters", {
  search_space = lts("classif.xgboost.default", nrounds = to_tune(1, 10000))

  expect_equal(as_search_space(search_space)$params$nrounds$upper, 10000)
})
