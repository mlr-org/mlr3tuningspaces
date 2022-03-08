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
#' * `as.data.table(dict, ..., objects = FALSE)`\cr
#'   [mlr3misc::Dictionary] -> [data.table::data.table()]\cr
#'   Returns a [data.table::data.table()] with fields "key", "label", "learner", and "n_values" as columns.
#'   If `objects` is set to `TRUE`, the constructed objects are returned in the list column named `object`.
#'
#' @family Dictionary
#' @family TuningSpace
#' @export
#' @examples
#' as.data.table(mlr_tuning_spaces)
#' mlr_tuning_spaces$get("classif.ranger.default")
#' lts("classif.ranger.default")
mlr_tuning_spaces = R6Class("DictionaryTuningSpaces",
  inherit = Dictionary,
  cloneable = FALSE,
)$new()

#' @export
as.data.table.DictionaryTuningSpaces = function(x, ..., objects = FALSE) {
  assert_flag(objects)

  setkeyv(map_dtr(x$keys(), function(key) {
    t = withCallingHandlers(x$get(key),
      packageNotFoundWarning = function(w) invokeRestart("muffleWarning"))
    insert_named(
      list(key = key, label = t$label, learner = t$learner, n_values = length(t$values)),
      if (objects) list(object = list(t))
    )
  }, .fill = TRUE), "key")[]
}
