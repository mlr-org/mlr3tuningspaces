#' @title Tuning Space for the svm Learner
#'
#' @name mlr_tuning_spaces_classif.svm
#' @include mlr_tuning_spaces.R
#'
#' @description
#' A tuning space for [mlr3learners::LearnerClassifSVM].
#'
#' @section Meta Information:
#' `r rd_info(lts("classif.svm.default"))`
#'
#' @source
#' `r format_bib("bischl_2021")`
NULL

add_tuning_space(
  id = "classif.svm.default",
  values = list(
    cost = to_tune(1e-4, 1e4, logscale = TRUE),
    kernel = to_tune(c("polynomial", "radial", "sigmoid", "linear")),
    degree = to_tune(2, 5),
    gamma = to_tune(1e-4, 1e4, logscale = TRUE)
  ),
  tags = c("default", "classification"),
  learner = "classif.svm"
)
