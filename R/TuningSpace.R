#' @title Tuning Spaces
#' 
#' @description 
#' This is the abstract base class for tuning spaces.
#' 
#' @export
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
    }
  )
)

#' @include mlr_tuning_spaces.R
add_tuning_space = function(id, values, tags, learner) {
  tuning_space = TuningSpace$new(id, values, tags, learner)
  mlr_tuning_spaces$add(id, tuning_space)
}