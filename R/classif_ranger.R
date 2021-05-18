#' @title Tuning Space for the ranger Learner
#' 
#' @name mlr_tuning_spaces_classif_ranger
#' @include mlr_tuning_spaces.R
#' 
#' @description 
#' A tuning space for the [mlr3learners::LearnerClassifRanger].
#' 
#' @section Meta Information:
#' `r rd_info(lts("classif.ranger.default"))`
#' 
#' @source
#' `r format_bib("bischl_2021")`
#' 
NULL

set = list(
  replace = to_tune(p_lgl()),
  sample.fraction = to_tune(0.1, 1),
  num.trees = to_tune(1, 2000)
)

add_tuning_space("classif.ranger.default", set, "classification", "classif.ranger")
