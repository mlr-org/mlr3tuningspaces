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

    #' @field package (`character()`).
    package = NULL,

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
    #'   Tags to group and filter tuning spaces.
    #' @param learner (`character(1)`)\cr
    #'   [mlr3::Learner] identifier in [mlr3::mlr_learners].
    #' @param package (`character()`)\cr
    #'   Packages which provide the [Learner], e.g. \CRANpkg{mlr3learners} for the learner
    #'   [mlr3learners::LearnerClassifRanger] which interfaces the \CRANpkg{ranger} package.
    initialize = function(id, values, tags, learner, package = character()) {
      self$id = assert_string(id, min.chars = 1L)
      self$learner = assert_string(learner, min.chars = 1L)
      self$values = assert_list(values, names = "unique")
      self$tags = assert_character(tags, any.missing = FALSE)
      self$package = assert_character(package, any.missing = FALSE)
    }
  )
)

#' @include mlr_tuning_spaces.R
add_tuning_space = function(id, values, tags, learner, package = character()) { # nolint
  tuning_space = TuningSpace$new(id, values, tags, learner, package)
  mlr_tuning_spaces$add(id, tuning_space)
}

#' @export
rd_info.TuningSpace = function(obj) { # nolint
  require_namespaces(obj$package)
  ps = lrn(obj$learner)$param_set
  c("",
    sprintf("* Learner: %s", rd_format_string(obj$learner)),
    "* Tuning Space:",
    imap_chr(obj$values, function(space, name) {
      switch(ps$params[[name]]$class,
        "ParamLgl" = sprintf("* %s (%s)", name, as_short_string(space$content$param$levels)),
        "ParamFct" = sprintf("* %s (%s)", name, rd_format_string(space$content$param$levels)),
        sprintf("* %s %s", name, rd_format_range(space$content$lower, space$content$upper))
      )
    })
  )
}
