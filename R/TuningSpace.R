#' @title Tuning Spaces
#'
#' @description
#' This class defines a tuning space for hyperparameter tuning.
#'
#' For tuning, it is important to create a search space that defines the range over which hyperparameters should be tuned.
#' `TuningSpace` object consists of search spaces from peer-reviewed articles which work well for a wide range of data sets.
#'
#' The `$values` field stores a list of [paradox::TuneToken] which define the search space.
#' These tokens can be assigned to the `$values` slot of a learner's [paradox::ParamSet].
#' When the learner is tuned, the tokens are used to create the search space.
#'
#' @section S3 Methods:
#' * `as.data.table.TuningSpace(x)`\cr
#' Returns a tabular view of the tuning space.\cr
#' [TuningSpace] -> [data.table::data.table()]\cr
#'     * `x` ([TuningSpace])
#'
#' @export
#' @examples
#' library(mlr3tuning)
#'
#' # Get default tuning space of rpart learner
#' tuning_space = lts("classif.rpart.default")
#'
#' # Set tuning space
#' learner = lrn("classif.rpart")
#' learner$param_set$values = tuning_space$values
#'
#' # Tune learner
#' instance = tune(
#'   tnr("random_search"),
#'   task = tsk("pima"),
#'   learner = learner,
#'   resampling = rsmp ("holdout"),
#'   measure = msr("classif.ce"),
#'   term_evals = 10)
#'
#' instance$result
#'
#' library(mlr3pipelines)
#'
#' # Set tuning space in a pipeline
#' graph_learner = as_learner(po("subsample") %>>%
#'   lts(lrn("classif.rpart")))
TuningSpace = R6Class("TuningSpace",
  public = list(

    #' @field id (`character(1)`)\cr
    #'   Identifier of the object.
    id = NULL,

    #' @field values (`list()`)\cr
    #'   List of [paradox::TuneToken] that describe the tuning space and fixed parameter values.
    values = NULL,

    #' @field tags (`character()`)\cr
    #'   Arbitrary tags to group and filter tuning space e.g. `"classification"` or "`regression`".
    tags = NULL,

    #' @field learner (`character(1)`)\cr
    #'   [mlr3::Learner] of the tuning space.
    learner = NULL,

    #' @field package (`character(1)`)\cr
    #'   Packages which provide the [mlr3::Learner], e.g. \CRANpkg{mlr3learners} for the learner
    #'   [mlr3learners::LearnerClassifRanger] which interfaces the \CRANpkg{ranger} package.
    package = NULL,

    #' @field label (`character(1)`)\cr
    #'   Label for this object.
    #'   Can be used in tables, plot and text output instead of the ID.
    label = NULL,

    #' @field man (`character(1)`)\cr
    #'   String in the format `[pkg]::[topic]` pointing to a manual page for this object.
    #'   The referenced help package can be opened via method `$help()`.
    man = NULL,

    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    #'
    #' @param id (`character(1)`)\cr
    #'   Identifier for the new instance.
    #'
    #' @param values (`list()`)\cr
    #'    List of [paradox::TuneToken] that describe the tuning space and fixed parameter values.
    #'
    #' @param tags (`character()`)\cr
    #'   Tags to group and filter tuning spaces e.g. `"classification"` or "`regression`".
    #'
    #' @param learner (`character(1)`)\cr
    #'   [mlr3::Learner] of the tuning space.
    #'
    #' @param package (`character()`)\cr
    #'   Packages which provide the [mlr3::Learner], e.g. \CRANpkg{mlr3learners} for the learner
    #'   [mlr3learners::LearnerClassifRanger] which interfaces the \CRANpkg{ranger} package.
    #'
    #' @param label (`character(1)`)\cr
    #'   Label for the new instance.
    #'   Can be used in tables, plot and text output instead of the ID.
    #'
    #' @param man (`character(1)`)\cr
    #'   String in the format `[pkg]::[topic]` pointing to a manual page for for the new instance.
    #'   The referenced help package can be opened via method `$help()`.
    initialize = function(id, values, tags, learner, package = character(), label = NA_character_, man = NA_character_) {
      self$id = assert_string(id, min.chars = 1L)
      self$learner = assert_string(learner, min.chars = 1L)
      self$values = assert_list(values, names = "unique")
      self$tags = assert_character(tags, any.missing = FALSE)
      self$package = union("mlr3tuningspaces", assert_character(package, any.missing = FALSE, min.chars = 1L))
      self$label = assert_string(label, na.ok = TRUE)
      self$man = assert_string(man, na.ok = TRUE)
    },

    #' @description
    #' Returns a learner with [paradox::TuneToken] set in parameter set.
    #'
    #' @param ... (named ‘list()’)\cr
    #'   Passed to `mlr3::lrn()`. Named arguments passed to the constructor, to
    #'   be set as parameters in the [paradox::ParamSet], or to be set as public
    #'   field. See `mlr3misc::dictionary_sugar_get()` for more details.
    #' @return [mlr3::Learner]
    get_learner = function(...) {
      learner = lrn(self$learner, ...)
      learner$param_set$values = insert_named(learner$param_set$values, self$values)
      learner
    },

    #' @description
    #' Helper for print outputs.
    #' @param ... (ignored).
    format = function(...) {
       sprintf("<%s:%s>", class(self)[1L], self$id)
    },

    #' @description
    #' Opens the corresponding help page referenced by field `$man`.
    help = function() {
      open_help(self$man)
    },

    #' @description
    #' Printer.
    #'
    #' @param ... (ignored).
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
      catn(format(self), if (is.na(self$label)) "" else paste0(": ", self$label))
      print(tab)
    }
  )
)

#' @include mlr_tuning_spaces.R
add_tuning_space = function(id, values, tags, learner, package = character(), label = NA_character_, man = NA_character_) { # nolint
  tuning_space = TuningSpace$new(id, values, tags, learner, package, label = label, man = paste0("mlr3tuningspaces::", id))
  mlr_tuning_spaces$add(id, tuning_space)
}

#' @export
rd_info.TuningSpace = function(obj, ...) { # nolint
  require_namespaces(obj$package)
  ps = lrn(obj$learner)$param_set
  x = c("",
    imap_chr(obj$values, function(space, name) {
      switch(ps$params[name, , on = "id"]$cls,
        "ParamLgl" = sprintf("* %s \\[%s\\]", name, as_short_string(space$content$levels[[1]])),
        "ParamFct" = sprintf("* %s \\[%s\\]", name, rd_format_string(space$content$levels[[1]])),
        {lower = c(space$content$param$lower, space$content$lower) # one is NULL
        upper = c(space$content$upper, space$content$param$upper)
        logscale = if (is.null(space$content$logscale) || !space$content$logscale) character(1) else "Logscale"
        sprintf("* %s %s %s", name, rd_format_range(lower, upper), logscale)}
      )
    })
  )
  paste(x, collapse = "\n")
}

#' @export
as_search_space.TuningSpace = function(x, ...) { # nolint
  x$get_learner()$param_set$search_space()
}

#' @export
as.data.table.TuningSpace = function(x, ...) {
  tab = map_dtr(x$values, function(value) {
    if (test_class(value, "ObjectTuneToken")) {
      # old paradox: value$content$param
      as.data.table(value$content$param %??% value$content)[, c("lower", "upper", "levels")]
    } else {
      as.data.table(value$content)
    }
  }, .fill = TRUE)
  tab[, "id" := names(x$values)]
  setcolorder(tab, intersect(c("id", "lower", "upper", "levels", "logscale"), names(tab)))
  if ("logscale" %in% names(tab)) tab[is.na(get("logscale")), "logscale" := FALSE]
  tab[]
}
