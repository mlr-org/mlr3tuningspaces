#' @title Package Tuning Space
#'
#' @description
#' This tuning space contains only default parameter values from the
#' upstream learner packages.
#'
#' @name tuning_spaces_package
#'
#' @aliases classif.kknn.package classif.ranger.package classif.rpart.package
#' classif.svm.package classif.xgboost.package regr.kknn.package
#' regr.ranger.package regr.rpart.package regr.svm.package regr.xgboost.package
#'
#' @section kknn tuning space:
#' `r rd_info(lts("classif.kknn.package"))`
#'
#' @section ranger tuning space:
#' `r rd_info(lts("classif.ranger.package"))`
#'
#' @section rpart tuning space:
#' `r rd_info(lts("classif.rpart.package"))`
#'
#' @section svm tuning space:
#' `r rd_info(lts("classif.svm.package"))`
#'
#' @section xgboost tuning space:
#' `r rd_info(lts("classif.xgboost.package"))`
#'
#' @include mlr_tuning_spaces.R
NULL

# kknn
vals = list(
  k = 7,
  distance = 2,
  kernel = "optimal",
  scale = TRUE
)

add_tuning_space(
  id = "classif.kknn.package",
  values = vals,
  tags = c("package", "classification"),
  learner = "classif.kknn",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.kknn.package",
  values = vals,
  tags = c("package", "regression"),
  learner = "regr.kknn",
  package = "mlr3learners"
)

# ranger
vals = list(
  num.trees = 500,
  mtry = NULL, # floor(sqrt(p))
  min.node.size = NULL, # 5 for classification but 10 for probability
  max.depth = 0,
  replace = TRUE,
  sample.fraction = 1,
  splitrule = "gini"
)

add_tuning_space(
  id = "classif.ranger.package",
  values = vals,
  tags = c("package", "classification"),
  learner = "classif.ranger",
  package = "mlr3learners"
)

vals = list(
  num.trees = 500,
  mtry = NULL, # floor(sqrt(p))
  min.node.size = 5,
  max.depth = 0,
  replace = TRUE,
  sample.fraction = 1,
  splitrule = "variance"
)

add_tuning_space(
  id = "regr.ranger.package",
  values = vals,
  tags = c("package", "regression"),
  learner = "regr.ranger",
  package = "mlr3learners"
)

# rpart
vals = list(
  minsplit = 20,
  minbucket = 7,
  cp = 0.01,
  maxcompete = 4,
  maxsurrogate = 5,
  usesurrogate = 2,
  xval = 10,
  surrogatestyle = 0,
  maxdepth = 30
)

add_tuning_space(
  id = "classif.rpart.package",
  values = vals,
  tags = c("package", "classification"),
  learner = "classif.rpart"
)

add_tuning_space(
  id = "regr.rpart.package",
  values = vals,
  tags = c("package", "regression"),
  learner = "regr.rpart"
)

# svm
vals = list(
  scale = TRUE,
  type = "C-classification",
  kernel = "radial",
  # gamma = 1/(data dimension),
  cost = 1,
  tolerance = 0.001,
  epsilon = 0.1,
  shrinking = TRUE
)

add_tuning_space(
  id = "classif.svm.package",
  values = vals,
  tags = c("package", "classification"),
  learner = "classif.svm",
  package = "mlr3learners"
)

vals = list(
  scale = TRUE,
  type = "eps-regression",
  kernel = "radial",
  # gamma = 1/(data dimension),
  cost = 1,
  tolerance = 0.001,
  epsilon = 0.1,
  shrinking = TRUE
)

add_tuning_space(
  id = "regr.svm.package",
  values = vals,
  tags = c("package", "regression"),
  learner = "regr.svm",
  package = "mlr3learners"
)

# xgboost
vals = list(
  booster = "gbtree",
  eta = 0.3,
  gamma = 0,
  max_depth = 6,
  min_child_weight = 1,
  max_delta_step = 0,
  subsample = 1,
  colsample_bytree = 1,
  colsample_bylevel = 1,
  lambda = 1,
  alpha = 0,
  tree_method = "auto",
  scale_pos_weight = 1,
  refresh_leaf = TRUE,
  process_type = "default",
  num_parallel_tree = 1
)

add_tuning_space(
  id = "classif.xgboost.package",
  values = vals,
  tags = c("package", "classification"),
  learner = "classif.xgboost",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.xgboost.package",
  values = vals,
  tags = c("package", "regression"),
  learner = "regr.xgboost",
  package = "mlr3learners"
)
