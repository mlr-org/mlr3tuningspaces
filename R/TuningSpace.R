#' @title Tuning Spaces
#'
#' @description
#' This is the abstract base class for tuning spaces which define a search space
#' for hyperparameter tuning.
#'
#' `TuningSpace` objects store a list of [paradox::TuneToken] and additional
#' meta information. These tokens can be assigned to the `$values` slot of
#' a learner's [paradox::ParamSet].
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
      self$package = union("mlr3tuningspaces", assert_character(package, any.missing = FALSE, min.chars = 1L))
    },

    #' @description
    #' Returns a learner with [TuneToken] set in parameter set.
    #'
    #' @param ... (named ‘list()’)\cr
    #'   Passed to `mlr3::lrn()`. Named arguments passed to the constructor, to
    #'   be set as parameters in the [paradox::ParamSet], or to be set as public
    #'   field. See `mlr3misc::dictionary_sugar_get()` for more details.
    #' @return [mlr3::Learner]
    get_learner = function(...) {
      learner = lrn(self$learner, ...)
      learner$param_set$values = insert_named(learner$param_set$values, lts(self$id)$values)
      learner
    },

    format = function(...) {
       sprintf("<%s:%s>", class(self)[1L], self$id)
    },

    print = function(...) {
      tab = imap_dtr(self$values, function(value, name) {
        data.table(
            id = name,
            lower = value$content$lower,
            upper = value$content$upper,
            levels = list(value$content$param$levels),
            logscale = isTRUE(value$content$logscale)
          )
        }, .fill = TRUE)
      setcolorder(tab, c("id", "lower", "upper", "levels", "logscale"))
      cat(format(self), sep = "\n")
      print(tab)
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
    imap_chr(obj$values, function(space, name) {

      switch(ps$params[[name]]$class,
        "ParamLgl" = sprintf("* %s \\[%s\\]", name, as_short_string(space$content$param$levels)),
        "ParamFct" = sprintf("* %s \\[%s\\]", name, rd_format_string(space$content$param$levels)),
        {lower = c(space$content$param$lower, space$content$lower) # one is NULL
        upper = c(space$content$upper, space$content$param$upper)
        sprintf("* %s %s", name, rd_format_range(lower, upper))}
      )
    })
  )
}
