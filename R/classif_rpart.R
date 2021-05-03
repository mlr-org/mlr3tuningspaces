set = list(
  cp = to_tune(1e-3, 1, logscale = TRUE),
  maxdepth = to_tune(3, 30),
  minbucket = to_tune(1, 60),
  minsplit = to_tune(5, 50)
)

add_tuning_space("classif.rpart.s1", set, "classification", "classif.rpart")
