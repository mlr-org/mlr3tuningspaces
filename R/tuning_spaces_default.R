#' @title Default Tuning Spaces
#'
#' @description
#' Tuning spaces from the `r cite_bib("bischl_2021")` article.
#'
#' @name tuning_spaces_default
#'
#' @source
#' `r format_bib("bischl_2021")`
#' @aliases classif.ranger.default classif.rpart.default classif.svm.default
#' classif.xgboost.default regr.ranger.default regr.rpart.default
#' regr.svm.default regr.xgboost.default
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

# ranger
vals = list(
  replace = to_tune(p_lgl()),
  sample.fraction = to_tune(0.1, 1),
  num.trees = to_tune(1, 2000),
  mtry.ratio = to_tune(0, 1)
)

add_tuning_space(
  id = "classif.ranger.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.ranger",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.ranger.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.ranger",
  package = "mlr3learners"
)

# rpart
vals = list(
  minsplit = to_tune(2, 128, logscale = TRUE),
  minbucket = to_tune(1, 64, logscale = TRUE),
  cp = to_tune(1e-04, 1e-1, logscale = TRUE)
)

add_tuning_space(
  id = "classif.rpart.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.rpart"
)

add_tuning_space(
  id = "regr.rpart.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.rpart"
)

# svm
vals = list(
  cost = to_tune(1e-4, 1e4, logscale = TRUE),
  kernel = to_tune(c("polynomial", "radial", "sigmoid", "linear")),
  degree = to_tune(2, 5),
  gamma = to_tune(1e-4, 1e4, logscale = TRUE)
)

add_tuning_space(
  id = "classif.svm.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.svm",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.svm.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.svm",
  package = "mlr3learners"
)

# xgboost
vals = list(
  eta = to_tune(1e-4, 1, logscale = TRUE),
  nrounds = to_tune(1, 5000),
  max_depth = to_tune(1, 20),
  colsample_bytree = to_tune(1e-1, 1),
  colsample_bylevel = to_tune(1e-1, 1),
  lambda = to_tune(1e-3, 1e3, logscale = TRUE),
  alpha = to_tune(1e-3, 1e3, logscale = TRUE),
  subsample = to_tune(1e-1, 1)
)

add_tuning_space(
  id = "classif.xgboost.default",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.xgboost",
  package = "mlr3learners"
)

add_tuning_space(
  id = "regr.xgboost.default",
  values = vals,
  tags = c("default", "regression"),
  learner = "regr.xgboost",
  package = "mlr3learners"
)
