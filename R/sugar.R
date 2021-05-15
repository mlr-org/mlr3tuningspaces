#' @title Syntactic Sugar for Tuning Space Construction
#'
#' @description
#' This function complements [mlr_tuning_spaces] with functions in the spirit
#' of [mlr3::mlr_sugar].
#'
#' @inheritParams mlr3::mlr_sugar
#' @return
#' * [TuningSpace] for `lts()`
#' * list of [TuningSpace] for `ltss()`
#' @export
#' @examples
#' lts("classif.ranger.default")
lts = function(.key, ...) {
  dictionary_sugar(mlr_tuning_spaces, .key, ...)
}

#' @rdname lts
#' @export
ltss = function(.keys, ...) {
  dictionary_sugar_mget(mlr_tuning_spaces, .keys, ...)
}