#' @title Tuning Spaces
#' 
#' @description 
#' This is the abstract base class for tuning spaces which define a search space
#' for hyperparameter tuning. `TuningSpace` objects store a list of 
#' [paradox::TuneToken] which can assigned to the values slot of learner's 
#' [paradox::ParamSet]. 
#' 
#' @export
#' @examples
#' library(mlr3tuning)
#' 
#' # get default tuning space of rpart learner
#' tuning_space = mlr_tuning_spaces$get("classif.rpart.default")
#' 
#' # get learner and set tuning space
#' learner = lrn("classif.rpart")
#' learner$param_set$values = tuning_space$values
#' 
#' # tune learner 
#' instance = tune(
#'  method = "random_search",
#'  task = tsk("pima"),
#'  learner = learner,
#'  resampling = rsmp ("holdout"),
#'  measure = msr("classif.ce"),
#'  term_evals = 10)
#' 
#' instance$result
TuningSpace = R6Class("TuningSpace",
  public = list(
    #' @field id (`character(1)`).
    id = NULL,

    #' @field values (`list()`).
    values = NULL,

    #' @field tags (`character()`).
    tags = NULL,

    #' @field learner (`character(1)`).
    learner = NULL,

    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    #'
    #' @param id (`character(1)`)\cr
    #'   Identifier for the new instance.
    #' @param values (`list()`)\cr
    #'   List of [paradox::TuneToken] and parameter values.
    #' @param tags (`character()`)\cr
    #'   Tags to group tuning spaces.
    #' @param learner (`character(1)`)\cr
    #'   [mlr3::Learner] id.
    initialize = function(id, values, tags, learner) {
      self$id = assert_string(id, min.chars = 1L) 
      self$learner = assert_string(learner, min.chars = 1L)
      self$values = assert_list(values)
      self$tags = assert_character(tags)
    },

    #' @description
    #' Returns a learner with [TuneToken] set in parameter set.
    #'
    #' @param ... (named ‘list()’)\cr
    #'   Passed to `mlr3::lrn()`. Named arguments passed to the constructor, to
    #'   be set as parameters in the [paradox::ParamSet], or to be set as public
    #'   field. See `mlr3misc::dictionary_sugar_get()` for more details.
    get_learner = function(...) {
      learner = lrn(self$learner, ...)
      learner$param_set$values = lts(self$id)$values
      learner
    }
  )
)

#' @include mlr_tuning_spaces.R
add_tuning_space = function(id, values, tags, learner) { # nolint
  tuning_space = TuningSpace$new(id, values, tags, learner)
  mlr_tuning_spaces$add(id, tuning_space)
}

#' @export
rd_info.TuningSpace = function(obj) { # nolint
  ps = lrn(obj$learner)$param_set
  c("",
    sprintf("* Learner: %s", rd_format_string(obj$learner)),
    "* Tuning Space:",
    imap_chr(obj$values, function(space, name) {
        if (ps$params[[name]]$class %in% c("ParamFct", "ParamLgl")) {
          sprintf("* %s \\[%s\\]", name, as_short_string(space$content$param$levels))
        } else {
          sprintf("* %s %s", name, rd_format_range(space$content$lower, space$content$upper))
        }
    })
  )
}
