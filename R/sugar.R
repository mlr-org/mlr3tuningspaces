#' @title Syntactic Sugar for Tuning Space Construction
#'
#' @description
#' Function to retrieve [TuningSpace] objects from [mlr_tuning_spaces] and further, allows a [mlr3::Learner] to be directly configured with a search space.
#' This function belongs to [mlr3::mlr_sugar] family.
#'
#' @param x (`character()` | [mlr3::Learner])\cr
#'   If `character`, key passed the dictionary to retrieve the tuning space.
#'   If [mlr3::Learner], default tuning space is added to the learner.
#' @param ... (named list of [paradox::TuneToken] | `NULL`)\cr
#'   Pass [paradox::TuneToken] to add or overwrite parameters in the tuning space.
#'   Use `NULL` to remove parameters (see examples).
#'
#' @return
#' If `x` is
#' @export
#' @examples
#' # load tuning space
#' lts("classif.rpart.default")
#'
#' # load tuning space and add parameter
#' lts("classif.rpart.default", maxdepth = to_tune(1, 15))
#'
#' # load tuning space and remove parameter
#' lts("classif.rpart.default", minsplit = NULL)
#'
#' # load tuning space and overwrite parameter
#' lts("classif.rpart.default", minsplit = to_tune(32, 128))
#'
#' # load learner and apply tuning space in one go
#' lts(lrn("classif.rpart"))
#'
#' # load learner, overwrite parameter and apply tuning space
#' lts(lrn("classif.rpart"), minsplit = to_tune(32, 128))
#'
#' # load multiple tuning spaces
#' ltss(c("classif.rpart.default", "classif.ranger.default"))
lts = function(x, ...) {
  if (missing(x)) return(lts.missing(x))
  UseMethod("lts")
}

#' @rdname lts
#' @return missing, [mlr_tuning_spaces] dictionary
#' @export
lts.missing = function(x, ...) {
  dictionary_sugar_get(mlr_tuning_spaces, x)
}

#' @rdname lts
#' @return a `character`, [TuningSpace]
#' @export
lts.character = function(x, ...) {
  tuning_space = dictionary_sugar_get(mlr_tuning_spaces, x)
  if (!...length()) return(tuning_space)
  dots = assert_list(list(...), types = c("TuneToken", "NULL"), names = "unique")
  tuning_space$values = insert_named(tuning_space$values, dots)
  tuning_space$values = discard(tuning_space$values, is.null)
  tuning_space
}

#' @rdname lts
#' @return a [mlr3::Learner], [mlr3::Learner] with [paradox::TuneToken]
#' @export
lts.Learner = function(x, ...) {
  tuning_space = lts(paste0(x$id, ".default"), ...)
  x$param_set$values = insert_named(x$param_set$values, tuning_space$values)
  x
}

#' @rdname lts
#' @return a `list()`, list of [TuningSpace] or [mlr3::Learner]
#' @export
ltss = function(x) {
  map(x, function(key) {
    lts(key)
  })
}
