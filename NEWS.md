# mlr3tuningspaces 0.3.4

* docs: Remove deprecated `method` argument of `mlr3tuning::tune()`.
* docs: Update resources.

# mlr3tuningspaces 0.3.3

* fix: Extra `paradox::TuneToken` in `lts()` were not passed to learners created with `$get_learner()`.
* docs: Add `lts()` return.

# mlr3tuningspaces 0.3.2

* docs: Add `mlr_tuning_spaces` prefix to aliases.

# mlr3tuningspaces 0.3.1

* docs: Add glmnet description.

# mlr3tuningspaces 0.3.0

* feat: Pass `paradox::TuneToken` to `lts()` to add, remove or overwrite parameters in tuning spaces and learners.
* fix: Remove debugging from `lts()`.

# mlr3tuningspaces 0.2.0

* feat: Add a `as.data.table.TuningSpace()` function.
* feat: `TuningSpace` objects have the optional field `$label` now.
* feat: New `$help()` method which opens the manual page of a `TuningSpace`.
* feat: Add search space for `glmnet` and `kknn` to default collection.
* feat: New `as_search_space()` function to create search spaces from `TuningSpace` objects.

# mlr3tuningspaces 0.1.1

* fix: The `subsample` hyperparameter is tuned on a logarithmic scale now.
  The lower bound of `alpha` is reduced from `1e-4` to `1e-3`.
  The tuning range of the `lambda` hyperparameter was 0.1 to 1.
  From now on, `lambda` is tuned from `1e-3` to `1e3` on a logarithmic scale.

# mlr3tuningspaces 0.1.0

* refactor: update citations.
* feat: Add `mtry.ratio` hyperparameter to tuning spaces of the ranger learner.
* feat: Add `$print()` method to `TuningSpace` objects.

# mlr3tuningspaces 0.0.1

* First release of the tuning spaces package.
