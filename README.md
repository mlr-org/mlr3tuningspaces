
# mlr3tuningspaces

Package website: [release](https://mlr3tuningspaces.mlr-org.com/)

<!-- badges: start -->

[![tic](https://github.com/mlr-org/mlr3tuningspaces/workflows/tic/badge.svg?branch=main)](https://github.com/mlr-org/mlr3tuningspaces/actions)
[![CRAN
Status](https://www.r-pkg.org/badges/version-ago/mlr3tuningspaces)](https://cran.r-project.org/package=mlr3tuningspaces)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
[![Mattermost](https://img.shields.io/badge/chat-mattermost-orange.svg)](https://lmmisld-lmu-stats-slds.srv.mwn.de/mlr_invite/)
<!-- badges: end -->

Collection of search spaces for hyperparameter tuning. Includes various
search spaces that can be directly applied to an `mlr3` learner.
Additionally, meta information about the search space can be queried.

## Installation

Install the development version from GitHub:

``` r
remotes::install_github("mlr-org/mlr3tuningspaces")
```

## Example

### Quick tuning

``` r
library(mlr3tuningspaces)

# tune learner with default search space
instance = tune(
  method = "random_search",
  task = tsk("pima"),
  learner = lts(lrn("classif.rpart")),
  resampling = rsmp ("holdout"),
  measure = msr("classif.ce"),
  term_evals = 10
)

# best performing hyperparameter configuration
instance$result
```

    ##    minsplit minbucket        cp learner_param_vals  x_domain classif.ce
    ## 1: 4.174471 0.5070691 -4.542023          <list[4]> <list[3]>  0.1953125

### Tuning search spaces

``` r
library("data.table")

# print keys and learners
as.data.table(mlr_tuning_spaces)
```

    ##                         key         learner n_values
    ##  1:     classif.glmnet.rbv2  classif.glmnet        2
    ##  2:       classif.kknn.rbv2    classif.kknn        1
    ##  3:  classif.ranger.default  classif.ranger        3
    ##  4:     classif.ranger.rbv2  classif.ranger        7
    ##  5:   classif.rpart.default   classif.rpart        3
    ##  6:      classif.rpart.rbv2   classif.rpart        4
    ##  7:     classif.svm.default     classif.svm        4
    ##  8:        classif.svm.rbv2     classif.svm        5
    ##  9: classif.xgboost.default classif.xgboost        9
    ## 10:    classif.xgboost.rbv2 classif.xgboost       13
    ## 11:        regr.glmnet.rbv2     regr.glmnet        2
    ## 12:          regr.kknn.rbv2       regr.kknn        1
    ## 13:     regr.ranger.default     regr.ranger        3
    ## 14:        regr.ranger.rbv2     regr.ranger        6
    ## 15:      regr.rpart.default      regr.rpart        3
    ## 16:         regr.rpart.rbv2      regr.rpart        4
    ## 17:        regr.svm.default        regr.svm        4
    ## 18:           regr.svm.rbv2        regr.svm        5
    ## 19:    regr.xgboost.default    regr.xgboost        9
    ## 20:       regr.xgboost.rbv2    regr.xgboost       13

``` r
# get tuning space and view tune token
tuning_space = lts("classif.rpart.default")
tuning_space$values
```

    ## $minsplit
    ## Tuning over:
    ## range [2, 128] (log scale)
    ## 
    ## 
    ## $minbucket
    ## Tuning over:
    ## range [1, 64] (log scale)
    ## 
    ## 
    ## $cp
    ## Tuning over:
    ## range [1e-04, 0.1] (log scale)

``` r
# get learner with tuning space
learner = tuning_space$get_learner()

# tune learner
instance = tune(
  method = "random_search",
  task = tsk("pima"),
  learner = learner,
  resampling = rsmp ("holdout"),
  measure = msr("classif.ce"),
  term_evals = 10)

instance$result
```

    ##    minsplit minbucket        cp learner_param_vals  x_domain classif.ce
    ## 1: 3.009338  2.506336 -8.291878          <list[4]> <list[3]>  0.2421875
