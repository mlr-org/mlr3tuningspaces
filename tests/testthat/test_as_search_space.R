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
