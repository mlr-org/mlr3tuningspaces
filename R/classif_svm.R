set = list(
  cost = to_tune(1e-5, 1e5, logscale = TRUE),
  gamma = to_tune(1e-5, 1e5, logscale = TRUE)
)

add_tuning_space("classif.svm.s1", set, "classification", "classif.svm")