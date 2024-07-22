#' @title Burk (2024) Survival Tuning Spaces
#'
#' @name mlr_tuning_spaces_sbb
#'
#' @description
#' Tuning spaces from the `r cite_bib("burk_2024")` article.
#'
#' @source
#' `r format_bib("burk_2024")`
#'
#' @aliases
#' mlr_tuning_spaces_surv.akritas.sbb
#' mlr_tuning_spaces_surv.glmnet.sbb
#' mlr_tuning_spaces_surv.penalized.sbb
#' mlr_tuning_spaces_surv.parametric.sbb
#' mlr_tuning_spaces_surv.flexsurv.sbb
#' mlr_tuning_spaces_surv.rfsrc.sbb
#' mlr_tuning_spaces_surv.ranger.sbb
#' mlr_tuning_spaces_surv.cforest.sbb
#' mlr_tuning_spaces_surv.aorsf.sbb
#' mlr_tuning_spaces_surv.rpart.sbb
#' mlr_tuning_spaces_surv.mboost.sbb
#' mlr_tuning_spaces_surv.cv_coxboost.sbb
#' mlr_tuning_spaces_surv.xgboost.cox.sbb
#' mlr_tuning_spaces_surv.xgboost.aft.sbb
#' mlr_tuning_spaces_surv.svm.sbb
#'
#' @section akritas tuning space:
#' `r rd_info(lts("surv.akritas.sbb"))`
#'
#' @section cv_glmnet tuning space:
#' `r rd_info(lts("surv.cv_glmnet.sbb"))`
#'
#' @section penalized tuning space:
#' `r rd_info(lts("surv.penalized.sbb"))`
#'
#' @section parametric tuning space:
#' `r rd_info(lts("surv.parametric.sbb"))`
#'
#' @section flexsurv tuning space:
#' `r rd_info(lts("surv.flexible.sbb"))`
#'
#' @section rfsrc tuning space:
#' `r rd_info(lts("surv.rfsrc.sbb"))`
#'
#' @section ranger tuning space:
#' `r rd_info(lts("surv.ranger.sbb"))`
#'
#' @section cforest tuning space:
#' `r rd_info(lts("surv.cforest.sbb"))`
#'
#' @section aorsf tuning space:
#' `r rd_info(lts("surv.aorsf.sbb"))`
#'
#' @section rpart tuning space:
#' `r rd_info(lts("surv.rpart.sbb"))`
#'
#' @section mboost tuning space:
#' `r rd_info(lts("surv.mboost.sbb"))`
#'
#' @section cv_coxboost tuning space:
#' `r rd_info(lts("surv.cv_coxboost.sbb"))`
#'
#' @section xgboost.cox tuning space:
#' `r rd_info(lts("surv.xgboost.cox.sbb"))`
#'
#' @section xgboost.aft tuning space:
#' `r rd_info(lts("surv.xgboost.aft.sbb"))`
#'
#' @section ssvm tuning space:
#' `r rd_info(lts("surv.svm.sbb"))`
#'
#' @include mlr_tuning_spaces.R
NULL

# Akritas -------------------------------------------------------------------------------------


# survivalmodels::akritas
# https://raphaels1.github.io/survivalmodels/reference/akritas.html
vals = list(
  lambda = to_tune(0, 1)
)

add_tuning_space(
  id = "surv.akritas.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.akritas",
  package = "mlr3extralearners",
  label = "Akritas Estimator (SBB)"
)


# glmnet --------------------------------------------------------------------------------------

vals = list(
  alpha = to_tune(0, 1)
)

add_tuning_space(
  id = "surv.cv_glmnet.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.cv_glmnet",
  package = "mlr3extralearners",
  label = "Survival CV Elastic Net (SBB)"
)


# Penalized -----------------------------------------------------------------------------------

vals = list(
  lambda1 = to_tune(p_dbl(-10, 10, trafo = function(x) 2^x)),
  lambda2 = to_tune(p_dbl(-10, 10, trafo = function(x) 2^x))
)

add_tuning_space(
  id = "surv.penalized.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.penalized",
  package = "mlr3extralearners",
  label = "Survival Penalized Regression (SBB)"
)


# Parametric / AFT ----------------------------------------------------------------------------


# Use grid search due to small + finite search space
# AFT version needs
# - to pass .form to bl() for distrcompositor
# - Tune distributions within range of what's sensible/discussed with RS
vals = list(
  type = "aft",
  # discrete = TRUE, # required at predict time, not sure if needed here?
  dist = to_tune(c("weibull", "exponential", "lognormal",  "loglogistic"))
)

add_tuning_space(
  id = "surv.parametric.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.parametric",
  package = "mlr3extralearners",
  label = "Parametric AFT (SBB)"
)


# FlexSurv ------------------------------------------------------------------------------------

# Use grid search due to small + finite search space
vals = list(
  k = to_tune(p_int(1, 10))
)

add_tuning_space(
  id = "surv.flexible.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.flexible",
  package = "mlr3extralearners",
  label = "Survival Flexible Parametric Splines (SBB)"
)


# RFSRC ---------------------------------------------------------------------------------------

vals = list(
  # Fixing ntime = 150 (current default) just to be explicit, as ranger's time.interest
  # is set to a non-default value and we ensure both use 150 time points for evaluation
  ntree = 1000,
  ntime = 150,
  splitrule = to_tune(c("bs.gradient", "logrank")),
  mtry.ratio = to_tune(0, 1),
  nodesize = to_tune(p_int(1, 50)),
  samptype = to_tune(c("swr", "swor")),
  sampsize.ratio = to_tune(0, 1)
)

add_tuning_space(
  id = "surv.rfsrc.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.rfsrc",
  package = "mlr3extralearners",
  label = "RSF (rfsrc) (SBB)"
)


# ranger' -------------------------------------------------------------------------------------

vals = list(
  # Adjusting time.interest (new as of 0.16.0) to 150, same as current RFSRC default
  num.trees = 1000,
  time.interest = 150,
  splitrule = to_tune(c("C", "maxstat", "logrank")),
  mtry.ratio = to_tune(0, 1),
  min.node.size = to_tune(p_int(1, 50)),
  replace = to_tune(),
  sample.fraction = to_tune(0, 1)
)

add_tuning_space(
  id = "surv.ranger.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.ranger",
  package = "mlr3extralearners",
  label = "RSF (ranger) (SBB)"
)


# CIF -----------------------------------------------------------------------------------------


vals = list(
  ntree = 1000,
  mtryratio = to_tune(0, 1),
  minsplit = to_tune(p_int(1, 50)),
  mincriterion = to_tune(0, 1),
  replace = to_tune(p_lgl()),
  fraction = to_tune(0, 1)
)

add_tuning_space(
  id = "surv.cforest.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.cforest",
  package = "mlr3extralearners",
  label = "Conditional Inference RSF (SBB)"
)


# aorsf ---------------------------------------------------------------------------------------

vals = list(
  n_tree = 1000,
  control_type = "fast",
  mtry_ratio = to_tune(0, 1),
  leaf_min_events = to_tune(p_int(5, 50)),
  .extra_trafo = function(x, param_set) {
    x$split_min_obs = x$leaf_min_events + 5L
    x
  }
)

add_tuning_space(
  id = "surv.aorsf.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.aorsf",
  package = "mlr3extralearners",
  label = "Oblique RSF (SBB)"
)


# rpart RRT -----------------------------------------------------------------------------------

vals = list(
  minbucket = to_tune(p_int(5, 50))
)

add_tuning_space(
  id = "surv.rpart.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.rpart",
  package = "mlr3extralearners",
  label = "Relative Risk Tree (SBB)"
)

# mboost --------------------------------------------------------------------------------------

vals = list(
  family = to_tune(c("gehan", "cindex", "coxph", "weibull")),
  mstop = to_tune(p_int(10, 5000)),
  nu = to_tune(0, 0.1),
  baselearner = to_tune(c("bols", "btree"))
)

add_tuning_space(
  id = "surv.mboost.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.mboost",
  package = "mlr3extralearners",
  label = "Model-Based Boosting (SBB)"
)

# CoxBoost ------------------------------------------------------------------------------------
# We don't tune this explicitly but let it tune itself

vals = list(
  penalty = "optimCoxBoostPenalty",
  maxstepno = 5000
)

add_tuning_space(
  id = "cv_coxboost.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "cv_coxboost",
  package = "mlr3extralearners",
  label = "CV CoxBoost (SBB)"
)


# XGB Cox -------------------------------------------------------------------------------------

vals = list(
  tree_method = "hist",
  booster = "gbtree",
  max_depth = to_tune(p_int(1, 20)),
  subsample = to_tune(0, 1),
  colsample_bytree = to_tune(0, 1),
  nrounds = to_tune(p_int(10, 5000)),
  eta = to_tune(0, 1),
  grow_policy = to_tune(c("depthwise", "lossguide"))
)

add_tuning_space(
  id = "surv.xgboost.cox.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.xgboost.cox",
  package = "mlr3extralearners",
  label = "Survival XGBoost (Cox) (SBB)"
)

# XGB AFT -------------------------------------------------------------------------------------

vals = list(
  tree_method = "hist",
  booster = "gbtree",
  max_depth = to_tune(p_int(1, 20)),
  subsample = to_tune(0, 1),
  colsample_bytree = to_tune(0, 1),
  nrounds = to_tune(p_int(10, 5000)),
  eta = to_tune(0, 1),
  grow_policy = to_tune(c("depthwise", "lossguide")),
  aft_loss_distribution = to_tune(c("normal", "logistic", "extreme")),
  aft_loss_distribution_scale = to_tune(0.5, 2.0)
)

add_tuning_space(
  id = "surv.xgboost.aft.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.xgboost.aft",
  package = "mlr3extralearners",
  label = "Survival XGBoost (AFT) (SBB)"
)

# SSVM ----------------------------------------------------------------------------------------

vals = list(
  type = "hybrid",
  gamma.mu = 0,
  diff.meth = "makediff3",
  kernel = to_tune(p_fct(c("lin_kernel", "rbf_kernel", "add_kernel"))),
  gamma = to_tune(p_dbl(-10, 10, trafo = function(x) 10^x)),
  mu = to_tune(p_dbl(-10, 10, trafo = function(x) 10^x)),
  kernel.pars = to_tune(p_dbl(-5, 5, trafo = function(x) 2^x)),
  .extra_trafo = function(x, param_set) {
    x$gamma.mu = c(x$gamma, x$mu)
    x$gamma = x$mu = NULL
    x
  }
)

add_tuning_space(
  id = "surv.svm.sbb",
  values = vals,
  tags = c("sbb", "survival"),
  learner = "surv.svm",
  package = "mlr3extralearners",
  label = "Survival SVM (SBB)"
)
