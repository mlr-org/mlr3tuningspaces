
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
Tuning spaces by Bischl et al. (2021) and Kuehn et al. (2018).

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

    ##                         key
    ##  1:  classif.glmnet.default
    ##  2:     classif.glmnet.rbv2
    ##  3:    classif.kknn.default
    ##  4:       classif.kknn.rbv2
    ##  5:  classif.ranger.default
    ##  6:     classif.ranger.rbv2
    ##  7:   classif.rpart.default
    ##  8:      classif.rpart.rbv2
    ##  9:     classif.svm.default
    ## 10:        classif.svm.rbv2
    ## 11: classif.xgboost.default
    ## 12:    classif.xgboost.rbv2
    ## 13:     regr.glmnet.default
    ## 14:        regr.glmnet.rbv2
    ## 15:       regr.kknn.default
    ## 16:          regr.kknn.rbv2
    ## 17:     regr.ranger.default
    ## 18:        regr.ranger.rbv2
    ## 19:      regr.rpart.default
    ## 20:         regr.rpart.rbv2
    ## 21:        regr.svm.default
    ## 22:           regr.svm.rbv2
    ## 23:    regr.xgboost.default
    ## 24:       regr.xgboost.rbv2
    ##                         key
    ##                                                            label
    ##  1:   Default GLM with Elastic Net Regularization Classification
    ##  2: RandomBot GLM with Elastic Net Regularization Classification
    ##  3:                    Default k-Nearest-Neighbor Classification
    ##  4:                  RandomBot k-Nearest-Neighbor Classification
    ##  5:                                Default Ranger Classification
    ##  6:                              RandomBot Ranger Classification
    ##  7:                                  Default Classification Tree
    ##  8:                                RandomBot Classification Tree
    ##  9:                Default Support Vector Machine Classification
    ## 10:              RandomBot Support Vector Machine Classification
    ## 11:             Default Extreme Gradient Boosting Classification
    ## 12:           RandomBot Extreme Gradient Boosting Classification
    ## 13:       Default GLM with Elastic Net Regularization Regression
    ## 14:     RandomBot GLM with Elastic Net Regularization Regression
    ## 15:                        Default k-Nearest-Neighbor Regression
    ## 16:                      RandomBot k-Nearest-Neighbor Regression
    ## 17:                                    Default Ranger Regression
    ## 18:                                  RandomBot Ranger Regression
    ## 19:                                      Default Regression Tree
    ## 20:                                    RandomBot Regression Tree
    ## 21:                    Default Support Vector Machine Regression
    ## 22:                  RandomBot Support Vector Machine Regression
    ## 23:                 Default Extreme Gradient Boosting Regression
    ## 24:               RandomBot Extreme Gradient Boosting Regression
    ##                                                            label
    ##             learner n_values
    ##  1:  classif.glmnet        2
    ##  2:  classif.glmnet        2
    ##  3:    classif.kknn        3
    ##  4:    classif.kknn        1
    ##  5:  classif.ranger        4
    ##  6:  classif.ranger        8
    ##  7:   classif.rpart        3
    ##  8:   classif.rpart        4
    ##  9:     classif.svm        4
    ## 10:     classif.svm        5
    ## 11: classif.xgboost        8
    ## 12: classif.xgboost       13
    ## 13:     regr.glmnet        2
    ## 14:     regr.glmnet        2
    ## 15:       regr.kknn        3
    ## 16:       regr.kknn        1
    ## 17:     regr.ranger        4
    ## 18:     regr.ranger        7
    ## 19:      regr.rpart        3
    ## 20:      regr.rpart        4
    ## 21:        regr.svm        4
    ## 22:        regr.svm        5
    ## 23:    regr.xgboost        8
    ## 24:    regr.xgboost       13
    ##             learner n_values

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

# References

<div id="refs" class="references hanging-indent">

<div id="ref-bischl_2021">

Bischl, Bernd, Martin Binder, Michel Lang, Tobias Pielok, Jakob Richter,
Stefan Coors, Janek Thomas, et al. 2021. “Hyperparameter Optimization:
Foundations, Algorithms, Best Practices and Open Challenges.”
<https://arxiv.org/abs/2107.05847>.

</div>

<div id="ref-kuehn_2018">

Kuehn, Daniel, Philipp Probst, Janek Thomas, and Bernd Bischl. 2018.
“Automatic Exploration of Machine Learning Experiments on Openml.”
<https://arxiv.org/abs/1806.10961>.

</div>

</div>
