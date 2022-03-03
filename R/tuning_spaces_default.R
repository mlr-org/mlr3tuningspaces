#' @title Default Tuning Spaces
#'
#' @name tuning_spaces_default
#'
#' @description
#' Tuning spaces from the `r cite_bib("bischl_2021")` article.
#'
#' @source
#' `r format_bib("bischl_2021")`
#'
#' @aliases classif.glmnet.default classif.kknn.default classif.ranger.default
#' classif.rpart.default classif.svm.default classif.xgboost.default
#' regr.glmnet.default regr.kknn.default regr.ranger.default regr.rpart.default
#' regr.svm.default regr.xgboost.default
#'
#' @section kknn tuning space:
#' `r rd_info(lts("classif.kknn.default"))`
#'
#' @section ranger tuning space:
#' `r rd_info(lts("classif.ranger.default"))`
#'
#' @section rpart tuning space:
#' `r rd_info(lts("classif.rpart.default"))`
#'
#' @section svm tuning space:
#' `r rd_info(lts("classif.svm.default"))`
#'
#' @section xgboost tuning space:
#' `r rd_info(lts("classif.xgboost.default"))`
#'
#' @include mlr_tuning_spaces.R
NULL

# glmnet
vals = list(
  s     = to_tune(1e-4, 1e4, logscale = TRUE),
  alpha = to_tune(0, 1)
)

add_tuning_space(
  id = "classif.glmnet.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.glmnet",
  package = "mlr3learners",
  label = "Default GLM with Elastic Net Regularization Classification"
)

add_tuning_space(
  id = "regr.glmnet.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.glmnet",
  package = "mlr3learners",
  label = "Default GLM with Elastic Net Regularization Regression"
)

# kknn
vals = list(
  k = to_tune(1, 50, logscale = TRUE),
  distance = to_tune(1, 5),
  kernel = to_tune(c("rectangular", "optimal", "epanechnikov", "biweight", "triweight", "cos",  "inv",  "gaussian", "rank"))
)

add_tuning_space(
  id = "classif.kknn.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.kknn",
  package = "mlr3learners",
  label = "Default k-Nearest-Neighbor Classification"
)

add_tuning_space(
  id = "regr.kknn.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.kknn",
  package = "mlr3learners",
  label = "Default k-Nearest-Neighbor Regression"
)

# ranger
vals = list(
  mtry.ratio      = to_tune(0, 1),
  replace         = to_tune(p_lgl()),
  sample.fraction = to_tune(1e-1, 1),
  num.trees       = to_tune(1, 2000)
)

add_tuning_space(
  id = "classif.ranger.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.ranger",
  label = "Default Ranger Classification"
)

add_tuning_space(
  id = "regr.ranger.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.ranger",
  label = "Default Ranger Regression"
)

# rpart
vals = list(
  minsplit  = to_tune(2, 128, logscale = TRUE),
  minbucket = to_tune(1, 64, logscale = TRUE),
  cp        = to_tune(1e-04, 1e-1, logscale = TRUE)
)

add_tuning_space(
  id = "classif.rpart.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.rpart",
  label = "Default Classification Tree"
)

add_tuning_space(
  id = "regr.rpart.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.rpart",
  label = "Default Regression Tree"
)

# svm
vals = list(
  cost    = to_tune(1e-4, 1e4, logscale = TRUE),
  kernel  = to_tune(c("polynomial", "radial", "sigmoid", "linear")),
  degree  = to_tune(2, 5),
  gamma   = to_tune(1e-4, 1e4, logscale = TRUE)
)

add_tuning_space(
  id = "classif.svm.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.svm",
  package = "mlr3learners",
  label = "Default Support Vector Machine Classification"
)

add_tuning_space(
  id = "regr.svm.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.svm",
  package = "mlr3learners",
  label = "Default Support Vector Machine Regression"
)

# xgboost
vals = list(
  eta               = to_tune(1e-4, 1, logscale = TRUE),
  nrounds           = to_tune(1, 5000),
  max_depth         = to_tune(1, 20),
  colsample_bytree  = to_tune(1e-1, 1),
  colsample_bylevel = to_tune(1e-1, 1),
  lambda            = to_tune(1e-3, 1e3, logscale = TRUE),
  alpha             = to_tune(1e-3, 1e3, logscale = TRUE),
  subsample         = to_tune(1e-1, 1)
)

add_tuning_space(
  id = "classif.xgboost.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.xgboost",
  package = "mlr3learners",
  label = "Default Extreme Gradient Boosting Classification"
)

add_tuning_space(
  id = "regr.xgboost.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.xgboost",
  package = "mlr3learners",
  label = "Default Extreme Gradient Boosting Regression"
)
