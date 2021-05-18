#' @title Tuning Space for the xgboost Learner
#' 
#' @name mlr_tuning_spaces_classif_xgboost
#' @include mlr_tuning_spaces.R
#' 
#' @description 
#' A tuning space for the [mlr3learners::LearnerClassifXgboost].
#' 
#' @section Meta Information:
#' `r rd_info(lts("classif.xgboost.default"))`
#'
#' @source
#' `r format_bib("bischl_2021")`
#' 
NULL

set = list(
  eta = to_tune(1e-4, 1, logscale = TRUE),
  nrounds = to_tune(1, 5000),
  max_depth = to_tune(1, 20),
  colsample_bytree = to_tune(0.1, 1),
  colsample_bylevel = to_tune(0.1, 1),
  lambda = to_tune(0.1, 1),
  gamma = to_tune(1e-4, 1e3, logscale = TRUE),
  alpha = to_tune(1e-4, 1e3, logscale = TRUE),
  subsample = to_tune(1e-1, 1, logscale = TRUE)
)

add_tuning_space("classif.xgboost.default", set, "classification", "classif.xgboost")
