#' @title Tuning Space for the rpart Learner
#' 
#' @name mlr_tuning_spaces_classif_rpart
#' @include mlr_tuning_spaces.R
#' 
#' @description 
#' A tuning space for the [mlr3::LearnerClassifRpart].
#' 
#' @section Meta Information:
#' `r rd_info(lts("classif.rpart.default"))`
#' 
NULL

# source: Bischl et al. (2021) A Practical Introduction into Hyperparameter Optimization
set = list(
    minsplit = to_tune(2, 128, logscale = TRUE),
    minbucket = to_tune(1, 64, logscale = TRUE),
    cp = to_tune(1e-04, 1e-1, logscale = TRUE)
)

add_tuning_space("classif.rpart.default", set, "classification", "classif.rpart")
