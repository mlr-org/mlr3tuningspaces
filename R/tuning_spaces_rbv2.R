#' @title RandomBot Tuning Spaces
#' 
#' @description
#' Tuning spaces from the `r cite_bib("kuehn_2018")` article.
#' 
#' @name tuning_spaces_rbv2
#' 
#' @source
#' `r format_bib("kuehn_2018")`
#' 
#' @aliases classif.ranger.rbv2 classif.rpart.rbv2 classif.svm.rbv2 
#' classif.xgboost.rbv2 regr.ranger.rbv2 regr.rpart.rbv2
#' regr.svm.rbv2 regr.xgboost.rbv2
#' 
#' @section glmnet tuning space:
#' `r rd_info(lts("classif.glmnet.rbv2"))`
#' 
#' @section kknn tuning space:
#' `r rd_info(lts("classif.kknn.rbv2"))`
#' 
#' @section ranger tuning space:
#' `r rd_info(lts("classif.ranger.rbv2"))`
#' 
#' @section rpart tuning space:
#' `r rd_info(lts("classif.rpart.rbv2"))`
#' 
#' @section svm tuning space:
#' `r rd_info(lts("classif.svm.rbv2"))`
#' 
#' @section xgboost tuning space:
#' `r rd_info(lts("classif.xgboost.rbv2"))`
#' 
#' @include mlr_tuning_spaces.R
NULL

# glmnet
vals = list(
  alpha = to_tune(0, 1),
  s = to_tune(1e-4, 1e3, logscale = TRUE)
)

add_tuning_space(
  id = "classif.glmnet.rbv2",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.glmnet",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.glmnet.rbv2",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.glmnet",
  package = "mlr3learners"
)

# kknn
vals = list(
  k = to_tune(1, 30)
)

add_tuning_space(
  id = "classif.kknn.rbv2",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.kknn",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.kknn.rbv2",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.kknn",
  package = "mlr3learners"
)

# ranger
vals = list(
  num.trees = to_tune(1, 2000),
  replace = to_tune(p_lgl()),
  sample.fraction = to_tune(0.1, 1),
  #mtry.power = to_tune(0, 1),
  respect.unordered.factors = to_tune(c("ignore", "order", "partition")),
  min.node.size = to_tune(1, 100),
  splitrule = to_tune(c("gini", "extratrees")),
  num.random.splits = to_tune(1, 100)
)

add_tuning_space(
  id = "classif.ranger.rbv2",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.ranger",
  package = "mlr3learners"
)

vals = list(
  num.trees = to_tune(1, 2000),
  replace = to_tune(p_lgl()),
  sample.fraction = to_tune(0.1, 1),
  #mtry.power = to_tune(0, 1),
  respect.unordered.factors = to_tune(c("ignore", "order", "partition")),
  min.node.size = to_tune(1, 100),
  num.random.splits = to_tune(1, 100)
)

add_tuning_space(
  id = "regr.ranger.rbv2",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.ranger",
  package = "mlr3learners"
)

# rpart
vals = list(
  cp = to_tune(1e-4, 1, logscale = TRUE),
  maxdepth = to_tune(1, 30),
  minbucket = to_tune(1, 100),
  minsplit = to_tune(1, 100)
)

add_tuning_space(
  id = "classif.rpart.rbv2",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.rpart",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.rpart.rbv2",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.rpart",
  package = "mlr3learners"
)

# svm 
vals = list(
  kernel = to_tune(c("linear", "polynomial", "radial")),
  cost =  to_tune(1e-4, 1e3, logscale = TRUE),
  gamma = to_tune(1e-4, 1e3, logscale = TRUE),
  tolerance = to_tune(1e-4, 2, logscale = TRUE),
  degree = to_tune(2, 5)
)

add_tuning_space(
  id = "classif.svm.rbv2",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.svm",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.svm.rbv2",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.svm",
  package = "mlr3learners"
)

# xgboost
vals = list(
  booster = to_tune(c("gblinear", "gbtree", "dart")),
  nrounds = to_tune(p_dbl(2, 8, trafo = function(x) as.integer(round(exp(x))))),
  eta = to_tune(1e-4, 1, logscale = TRUE),
  gamma = to_tune(1e-5, 7, logscale = TRUE),
  lambda = to_tune(1e-4, 1e3, logscale = TRUE),
  alpha = to_tune(1e-4, 1e3, logscale = TRUE),
  subsample = to_tune(0.1, 1),
  max_depth = to_tune(1, 15),
  min_child_weight = to_tune(1, 1e2, logscale = TRUE),
  colsample_bytree = to_tune(0.01, 1),
  colsample_bylevel = to_tune(0.01, 1),
  rate_drop = to_tune(0, 1),
  skip_drop = to_tune( 0, 1)
)

add_tuning_space(
  id = "classif.xgboost.rbv2",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.xgboost",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.xgboost.rbv2",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.xgboost",
  package = "mlr3learners"
)
