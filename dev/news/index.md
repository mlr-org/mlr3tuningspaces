# Changelog

## mlr3tuningspaces (development version)

- feat: Added tuning spaces for deep neural networks from the Gorishniy,
  Rubachev, Khrulkov, Babenko (2021) article.

## mlr3tuningspaces 0.6.0

CRAN release: 2025-05-16

- BREAKING CHANGE: The `kknn` package was removed from CRAN. The `kknn`
  tuning spaces are removed from the package.
- feat: Print with `cli` package.

## mlr3tuningspaces 0.5.2

CRAN release: 2024-11-22

- compatibility: mlr3learners 0.9.0

## mlr3tuningspaces 0.5.1

CRAN release: 2024-06-21

- compatibility: Work with new mlr3tuning version 1.0.0

## mlr3tuningspaces 0.5.0

CRAN release: 2024-03-05

- fix: Reduce levels of `respect.unordered.factors` of search space
  `ranger.rbv1` to `"ignore"` and `"order"`.
- compatibility: Work with new paradox version 1.0.0

## mlr3tuningspaces 0.4.0

CRAN release: 2023-04-20

- fix: The source of the `rbv2` search spaces was wrong. The source is
  Binder, Pfisterer, and Bischl (2020). Thanks to
  [@markus-schaffer](https://github.com/markus-schaffer).
- feat: Add `rbv1` search spaces from the Kühn (2018) paper.

## mlr3tuningspaces 0.3.5

CRAN release: 2023-03-08

- fix: Add missing `...` parameter to `rd_info.TuningSpace()`.

## mlr3tuningspaces 0.3.4

CRAN release: 2023-03-02

- docs: Remove deprecated `method` argument of
  [`mlr3tuning::tune()`](https://mlr3tuning.mlr-org.com/reference/tune.html).
- docs: Update resources.

## mlr3tuningspaces 0.3.3

CRAN release: 2022-12-07

- fix: Extra
  [`paradox::TuneToken`](https://paradox.mlr-org.com/reference/to_tune.html)
  in
  [`lts()`](https://mlr3tuningspaces.mlr-org.com/dev/reference/lts.md)
  were not passed to learners created with `$get_learner()`.
- docs: Add
  [`lts()`](https://mlr3tuningspaces.mlr-org.com/dev/reference/lts.md)
  return.

## mlr3tuningspaces 0.3.2

CRAN release: 2022-11-27

- docs: Add `mlr_tuning_spaces` prefix to aliases.

## mlr3tuningspaces 0.3.1

CRAN release: 2022-10-24

- docs: Add glmnet description.

## mlr3tuningspaces 0.3.0

CRAN release: 2022-06-28

- feat: Pass
  [`paradox::TuneToken`](https://paradox.mlr-org.com/reference/to_tune.html)
  to
  [`lts()`](https://mlr3tuningspaces.mlr-org.com/dev/reference/lts.md)
  to add, remove or overwrite parameters in tuning spaces and learners.
- fix: Remove debugging from
  [`lts()`](https://mlr3tuningspaces.mlr-org.com/dev/reference/lts.md).

## mlr3tuningspaces 0.2.0

CRAN release: 2022-04-12

- feat: Add a `as.data.table.TuningSpace()` function.
- feat: `TuningSpace` objects have the optional field `$label` now.
- feat: New `$help()` method which opens the manual page of a
  `TuningSpace`.
- feat: Add search space for `glmnet` and `kknn` to default collection.
- feat: New
  [`as_search_space()`](https://mlr3tuning.mlr-org.com/reference/as_search_space.html)
  function to create search spaces from `TuningSpace` objects.

## mlr3tuningspaces 0.1.1

CRAN release: 2022-01-19

- fix: The `subsample` hyperparameter is tuned on a logarithmic scale
  now. The lower bound of `alpha` is reduced from `1e-4` to `1e-3`. The
  tuning range of the `lambda` hyperparameter was 0.1 to 1. From now on,
  `lambda` is tuned from `1e-3` to `1e3` on a logarithmic scale.

## mlr3tuningspaces 0.1.0

CRAN release: 2022-01-03

- refactor: update citations.
- feat: Add `mtry.ratio` hyperparameter to tuning spaces of the ranger
  learner.
- feat: Add `$print()` method to `TuningSpace` objects.

## mlr3tuningspaces 0.0.1

CRAN release: 2021-07-16

- First release of the tuning spaces package.
