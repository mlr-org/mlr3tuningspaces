#' @title Syntactic Sugar for Tuning Space Construction
#'
#' @description
#' This function complements [mlr_tuning_spaces] with functions in the spirit
#' of [mlr3::mlr_sugar].
#'
#' @param x (`character()` | [mlr3::Learner])\cr
#' If `character`, key passed the dictionary to retrieve the tuning space.
#' If [mlr3::Learner], default tuning space is added to the learner.
#'
#' @return
#' * [TuningSpace] for `lts()`
#' * list of [TuningSpace] for `ltss()`
#' @export
#' @examples
#' lts("classif.ranger.default")
lts = function(x) {
  UseMethod("lts")
}

#' @rdname lts
#' @export
lts.character = function(x) {
  dictionary_sugar_get(mlr_tuning_spaces, x)
}

#' @rdname lts
#' @export
lts.Learner = function(x) {
  tuning_space = dictionary_sugar_get(mlr_tuning_spaces, paste0(x$id, ".default"))
  browser()
  x$param_set$values = insert_named(x$param_set$values, tuning_space$values)
  x
}

#' @rdname lts
#' @export
ltss = function(x) {
  map(x, function(key) {
    lts(key)
  })
}
