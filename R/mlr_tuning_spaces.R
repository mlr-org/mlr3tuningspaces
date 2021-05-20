#' @title Dictionary of Tuning Spaces
#'
#' @usage NULL
#' @format [R6::R6Class] object inheriting from [mlr3misc::Dictionary].
#'
#' @description
#' A simple [mlr3misc::Dictionary] storing objects of class [TuningSpace].
#' Each tuning space has an associated help page, see `mlr_tuning_spaces_[id]`.
#'
#' @section Methods:
#' See [mlr3misc::Dictionary].
#'
#' @section S3 methods:
#' * `as.data.table(dict)`\cr
#'   [mlr3misc::Dictionary] -> [data.table::data.table()]\cr
#'   Returns a [data.table::data.table()] with columns `"key"`, `"learner"` and
#'   `"n_values"`.
#'
#' @family Dictionary
#' @family TuningSpace
#' @export
#' @examples
#' library(data.table)
#' as.data.table(mlr_tuning_spaces)
#' mlr_tuning_spaces$get("classif.ranger.default")
mlr_tuning_spaces = R6Class("DictionaryTuningSpaces",
  inherit = Dictionary,
  cloneable = FALSE,
)$new()

#' @export
as.data.table.DictionaryTuningSpaces = function(x, ...) { # nolint
  setkeyv(map_dtr(x$keys(), function(key) {
    l = withCallingHandlers(x$get(key),
      packageNotFoundWarning = function(w) invokeRestart("muffleWarning"))
    list(
      key = key,
      learner = list(l$learner),
      n_values = length(l$values)
    )
  }), "key")[]
}
