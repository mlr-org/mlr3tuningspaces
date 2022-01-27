testthat("as_search_space on TuningSpace works", {
  tuning_space = lts("classif.rpart.default")
  search_space = as_search_space(tuning_space)
  expect_r6(search_space, "ParamSet")
  expect_set_equal(search_space$ids(), c("minsplit", "minbucket", "cp"))
})
