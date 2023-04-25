#' @title RandomBot Tuning Spaces
#'
#' @name mlr_tuning_spaces_rbv1
#'
#' @description
#' Tuning spaces from the `r cite_bib("kuehn_2018")` article.
#'
#' @source
#' `r format_bib("kuehn_2018")`
#'
#' @aliases
#' mlr_tuning_spaces_classif.glmnet.rbv1
#' mlr_tuning_spaces_classif.kknn.rbv1
#' mlr_tuning_spaces_classif.ranger.rbv1
#' mlr_tuning_spaces_classif.rpart.rbv1
#' mlr_tuning_spaces_classif.svm.rbv1
#' mlr_tuning_spaces_classif.xgboost.rbv1
#' mlr_tuning_spaces_regr.glmnet.rbv1
#' mlr_tuning_spaces_regr.kknn.rbv1
#' mlr_tuning_spaces_regr.ranger.rbv1
#' mlr_tuning_spaces_regr.rpart.rbv1
#' mlr_tuning_spaces_regr.svm.rbv1
#' mlr_tuning_spaces_regr.xgboost.rbv1
#'
#' @section glmnet tuning space:
#' `r rd_info(lts("classif.glmnet.rbv1"))`
#'
#' @section kknn tuning space:
#' `r rd_info(lts("classif.kknn.rbv1"))`
#'
#' @section ranger tuning space:
#' `r rd_info(lts("classif.ranger.rbv1"))`
#'
#' The tuning space of the ranger learner is slightly different from the original paper.
#' The hyperparameter `mtry.power` is replaced by `mtry.ratio` and `min.node.size` is explored in a range from 1 to 100.
#'
#' @section rpart tuning space:
#' `r rd_info(lts("classif.rpart.rbv1"))`
#'
#' @section svm tuning space:
#' `r rd_info(lts("classif.svm.rbv1"))`
#'
#' @section xgboost tuning space:
#' `r rd_info(lts("classif.xgboost.rbv1"))`
#'
#' @include mlr_tuning_spaces.R
NULL

# glmnet
vals = list(
  alpha = to_tune(0, 1),
  s     = to_tune(1e-4, 1e3, logscale = TRUE)
)

add_tuning_space(
  id = "classif.glmnet.rbv1",
  values = vals,
  tags = c("rbv1", "classification"),
  learner = "classif.glmnet",
  package = "mlr3learners",
  label = "Classification GLM with RandomBot"
)

add_tuning_space(
  id = "regr.glmnet.rbv1",
  values = vals,
  tags = c("rbv1", "regression"),
  learner = "regr.glmnet",
  package = "mlr3learners",
  label = "Regression GLM with RandomBot"
)

# kknn
vals = list(
  k = to_tune(1, 30)
)

add_tuning_space(
  id = "classif.kknn.rbv1",
  values = vals,
  tags = c("rbv1", "classification"),
  learner = "classif.kknn",
  package = "mlr3learners",
  label = "Classification KKNN with RandomBot"
)

add_tuning_space(
  id = "regr.kknn.rbv1",
  values = vals,
  tags = c("rbv1", "regression"),
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
  respect.unordered.factors = to_tune(c("ignore", "order")),
  min.node.size             = to_tune(1, 100)
)

add_tuning_space(
  id = "classif.ranger.rbv1",
  values = vals,
  tags = c("rbv1", "classification"),
  learner = "classif.ranger",
  package = "mlr3learners",
  label = "Classification Ranger with RandomBot"
)

vals = list(
  num.trees                 = to_tune(1, 2000),
  replace                   = to_tune(p_lgl()),
  sample.fraction           = to_tune(0.1, 1),
  mtry.ratio                = to_tune(0, 1),
  respect.unordered.factors = to_tune(c("ignore", "order")),
  min.node.size             = to_tune(1, 100)
)

add_tuning_space(
  id = "regr.ranger.rbv1",
  values = vals,
  tags = c("rbv1", "regression"),
  learner = "regr.ranger",
  package = "mlr3learners",
  label = "Regression Ranger with RandomBot"
)

# rpart
vals = list(
  cp        = to_tune(0, 1),
  maxdepth  = to_tune(1, 30),
  minbucket = to_tune(1, 60),
  minsplit  = to_tune(1, 60)
)

add_tuning_space(
  id = "classif.rpart.rbv1",
  values = vals,
  tags = c("rbv1", "classification"),
  learner = "classif.rpart",
  package = "mlr3learners",
  label = "Classification Rpart with RandomBot"
)

add_tuning_space(
  id = "regr.rpart.rbv1",
  values = vals,
  tags = c("rbv1", "regression"),
  learner = "regr.rpart",
  package = "mlr3learners",
  label = "Regression Rpart with RandomBot"
)

# svm
vals = list(
  kernel    = to_tune(c("linear", "polynomial", "radial")),
  cost      =  to_tune(1e-4, 1e3, logscale = TRUE),
  gamma     = to_tune(1e-4, 1e3, logscale = TRUE),
  degree    = to_tune(2, 5)
)

add_tuning_space(
  id = "classif.svm.rbv1",
  values = vals,
  tags = c("rbv1", "classification"),
  learner = "classif.svm",
  package = "mlr3learners",
  label = "Classification SVM with RandomBot"
)

add_tuning_space(
  id = "regr.svm.rbv1",
  values = vals,
  tags = c("rbv1", "regression"),
  learner = "regr.svm",
  package = "mlr3learners",
  label = "Regression SVM with RandomBot"
)

# xgboost
vals = list(
  nrounds           = to_tune(1, 5000),
  eta               = to_tune(1e-4, 1, logscale = TRUE),
  subsample         = to_tune(0, 1),
  booster           = to_tune(c("gblinear", "gbtree", "dart")),
  max_depth         = to_tune(1, 15),
  min_child_weight  = to_tune(1, 1e2, logscale = TRUE),
  colsample_bytree  = to_tune(0, 1),
  colsample_bylevel = to_tune(0, 1),
  lambda            = to_tune(1e-4, 1e3, logscale = TRUE),
  alpha             = to_tune(1e-4, 1e3, logscale = TRUE)
)

add_tuning_space(
  id = "classif.xgboost.rbv1",
  values = vals,
  tags = c("rbv1", "classification"),
  learner = "classif.xgboost",
  package = "mlr3learners",
  label = "Classification XGBoost with RandomBot"
)

add_tuning_space(
  id = "regr.xgboost.rbv1",
  values = vals,
  tags = c("rbv1", "regression"),
  learner = "regr.xgboost",
  package = "mlr3learners",
  label = "Regression XGBoost with RandomBot"
)
