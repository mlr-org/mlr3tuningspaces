#' @title RandomBot V2 Tuning Spaces
#'
#' @name mlr_tuning_spaces_rbv2
#'
#' @description
#' Tuning spaces from the `r cite_bib("binder_2020")` article.
#'
#' @source
#' `r format_bib("binder_2020")`
#'
#' @aliases
#' mlr_tuning_spaces_classif.glmnet.rbv2
#' mlr_tuning_spaces_classif.kknn.rbv2
#' mlr_tuning_spaces_classif.ranger.rbv2
#' mlr_tuning_spaces_classif.rpart.rbv2
#' mlr_tuning_spaces_classif.svm.rbv2
#' mlr_tuning_spaces_classif.xgboost.rbv2
#' mlr_tuning_spaces_regr.glmnet.rbv2
#' mlr_tuning_spaces_regr.kknn.rbv2
#' mlr_tuning_spaces_regr.ranger.rbv2
#' mlr_tuning_spaces_regr.rpart.rbv2
#' mlr_tuning_spaces_regr.svm.rbv2
#' mlr_tuning_spaces_regr.xgboost.rbv2
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
#' `mtry.power` is replaced by `mtry.ratio`.
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
  s     = to_tune(1e-4, 1e3, logscale = TRUE)
)

add_tuning_space(
  id = "classif.glmnet.rbv2",
  values = vals,
  tags = c("rbv2", "classification"),
  learner = "classif.glmnet",
  package = "mlr3learners",
  label = "Classification GLM with RandomBot"
)

add_tuning_space(
  id = "regr.glmnet.rbv2",
  values = vals,
  tags = c("rbv2", "regression"),
  learner = "regr.glmnet",
  package = "mlr3learners",
  label = "Regression GLM with RandomBot"
)

# kknn
vals = list(
  k = to_tune(1, 30)
)

add_tuning_space(
  id = "classif.kknn.rbv2",
  values = vals,
  tags = c("rbv2", "classification"),
  learner = "classif.kknn",
  package = "mlr3learners",
  label = "Classification KKNN with RandomBot"
)

add_tuning_space(
  id = "regr.kknn.rbv2",
  values = vals,
  tags = c("rbv2", "regression"),
  learner = "regr.kknn",
  package = "mlr3learners",
  label = "Regression KKNN with RandomBot"
)

# ranger
vals = list(
  num.trees                 = to_tune(1, 2000),
  replace                   = to_tune(p_lgl()),
  sample.fraction           = to_tune(0.1, 1),
  mtry.ratio                = to_tune(0, 1),
  respect.unordered.factors = to_tune(c("ignore", "order", "partition")),
  min.node.size             = to_tune(p_int(1, 100)),
  splitrule                 = to_tune(c("gini", "extratrees")),
  num.random.splits         = to_tune(1, 100)
)

add_tuning_space(
  id = "classif.ranger.rbv2",
  values = vals,
  tags = c("rbv2", "classification"),
  learner = "classif.ranger",
  package = "mlr3learners",
  label = "Classification Ranger with RandomBot"
)

vals = list(
  num.trees                 = to_tune(1, 2000),
  replace                   = to_tune(p_lgl()),
  sample.fraction           = to_tune(0.1, 1),
  mtry.ratio                = to_tune(0, 1),
  respect.unordered.factors = to_tune(c("ignore", "order", "partition")),
  min.node.size             = to_tune(p_int(1, 100)),
  num.random.splits         = to_tune(1, 100)
)

add_tuning_space(
  id = "regr.ranger.rbv2",
  values = vals,
  tags = c("rbv2", "regression"),
  learner = "regr.ranger",
  package = "mlr3learners",
  label = "Regression Ranger with RandomBot"
)

# rpart
vals = list(
  cp        = to_tune(1e-4, 1, logscale = TRUE),
  maxdepth  = to_tune(1, 30),
  minbucket = to_tune(1, 100),
  minsplit  = to_tune(1, 100)
)

add_tuning_space(
  id = "classif.rpart.rbv2",
  values = vals,
  tags = c("rbv2", "classification"),
  learner = "classif.rpart",
  package = "mlr3learners",
  label = "Classification Rpart with RandomBot"
)

add_tuning_space(
  id = "regr.rpart.rbv2",
  values = vals,
  tags = c("rbv2", "regression"),
  learner = "regr.rpart",
  package = "mlr3learners",
  label = "Regression Rpart with RandomBot"
)

# svm
vals = list(
  kernel    = to_tune(c("linear", "polynomial", "radial")),
  cost      = to_tune(1e-4, 1e3, logscale = TRUE),
  gamma     = to_tune(1e-4, 1e3, logscale = TRUE),
  tolerance = to_tune(1e-4, 2, logscale = TRUE),
  degree    = to_tune(2, 5)
)

add_tuning_space(
  id = "classif.svm.rbv2",
  values = vals,
  tags = c("rbv2", "classification"),
  learner = "classif.svm",
  package = "mlr3learners",
  label = "Classification SVM with RandomBot"
)

add_tuning_space(
  id = "regr.svm.rbv2",
  values = vals,
  tags = c("rbv2", "regression"),
  learner = "regr.svm",
  package = "mlr3learners",
  label = "Regression SVM with RandomBot"
)

# xgboost
vals = list(
  booster           = to_tune(c("gblinear", "gbtree", "dart")),
  nrounds           = to_tune(7, 2981, logscale = TRUE),
  eta               = to_tune(1e-4, 1, logscale = TRUE),
  gamma             = to_tune(1e-5, 7, logscale = TRUE),
  lambda            = to_tune(1e-4, 1e3, logscale = TRUE),
  alpha             = to_tune(1e-4, 1e3, logscale = TRUE),
  subsample         = to_tune(0.1, 1),
  max_depth         = to_tune(1, 15),
  min_child_weight  = to_tune(1, 1e2, logscale = TRUE),
  colsample_bytree  = to_tune(0.01, 1),
  colsample_bylevel = to_tune(0.01, 1),
  rate_drop         = to_tune(0, 1),
  skip_drop         = to_tune(0, 1)
)

add_tuning_space(
  id = "classif.xgboost.rbv2",
  values = vals,
  tags = c("rbv2", "classification"),
  learner = "classif.xgboost",
  package = "mlr3learners",
  label = "Classification XGBoost with RandomBot"
)

add_tuning_space(
  id = "regr.xgboost.rbv2",
  values = vals,
  tags = c("rbv2", "regression"),
  learner = "regr.xgboost",
  package = "mlr3learners",
  label = "Regression XGBoost with RandomBot"
)
