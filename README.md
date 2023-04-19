
# mlr3tuningspaces <img src="man/figures/logo.png" align="right" width = "120" />

Package website: [release](https://mlr3tuningspaces.mlr-org.com/) |
[dev](https://mlr3tuningspaces.mlr-org.com/dev/)

<!-- badges: start -->

[![r-cmd-check](https://github.com/mlr-org/mlr3tuningspaces/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/mlr-org/mlr3tuningspaces/actions/workflows/r-cmd-check.yml)
[![CRAN
Status](https://www.r-pkg.org/badges/version-ago/mlr3tuningspaces)](https://cran.r-project.org/package=mlr3tuningspaces)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
[![Mattermost](https://img.shields.io/badge/chat-mattermost-orange.svg)](https://lmmisld-lmu-stats-slds.srv.mwn.de/mlr_invite/)
<!-- badges: end -->

*mlr3tuningspaces* is a collection of search spaces for hyperparameter
optimization in the [mlr3](https://github.com/mlr-org/mlr3/) ecosystem.
It features ready-to-use search spaces for many popular machine learning
algorithms. The search spaces are from scientific articles and work for
a wide range of data sets. Currently, we offer tuning spaces from three
publications.

| Publication                          | Learner | n Hyperparameter |
| ------------------------------------ | ------- | ---------------- |
| Bischl et al. (2021)                 | glmnet  | 2                |
|                                      | kknn    | 3                |
|                                      | ranger  | 4                |
|                                      | rpart   | 3                |
|                                      | svm     | 4                |
|                                      | xgboost | 8                |
| Kuehn et al. (2018)                  | glmnet  | 2                |
|                                      | kknn    | 1                |
|                                      | ranger  | 8                |
|                                      | rpart   | 4                |
|                                      | svm     | 5                |
|                                      | xgboost | 13               |
| Binder, Pfisterer, and Bischl (2020) | glmnet  | 2                |
|                                      | kknn    | 1                |
|                                      | ranger  | 6                |
|                                      | rpart   | 4                |
|                                      | svm     | 4                |
|                                      | xgboost | 10               |

## Resources

There are several sections about hyperparameter optimization in the
[mlr3book](https://mlr3book.mlr-org.com).

  - Getting started with the
    [book](https://mlr3book.mlr-org.com/optimization.html#sec-tuning-spaces)
    section on mlr3tuningspaces.
  - Learn about [search
    space](https://mlr3book.mlr-org.com/optimization.html#sec-learner-search-space)

The [gallery](https://mlr-org.com/gallery-all-optimization.html)
features a collection of case studies and demos about optimization.

  - [Tune](https://mlr-org.com/gallery/optimization/2021-07-06-introduction-to-mlr3tuningspaces/)
    a classification tree with the default tuning space from Bischl et
    al. (2021).

## Installation

Install the last release from CRAN:

``` r
install.packages("mlr3tuningspaces")
```

Install the development version from GitHub:

``` r
remotes::install_github("mlr-org/mlr3tuningspaces")
```

## Example

### Quick Tuning

A learner passed to the `lts()` function arguments the learner with the
default tuning space from Bischl et al. (2021).

``` r
library(mlr3tuningspaces)

learner = lts(lrn("classif.rpart"))

# tune learner on pima data set
instance = tune(
  tnr("random_search"),
  task = tsk("pima"),
  learner = learner,
  resampling = rsmp("holdout"),
  measure = msr("classif.ce"),
  term_evals = 10
)

# best performing hyperparameter configuration
instance$result
```

    ##    minsplit minbucket        cp learner_param_vals  x_domain classif.ce
    ## 1: 1.966882  3.038246 -4.376785          <list[4]> <list[3]>  0.2265625

### Tuning Search Spaces

The `mlr_tuning_spaces` dictionary contains all tuning spaces.

``` r
library("data.table")

# print keys and tuning spaces
as.data.table(mlr_tuning_spaces)
```

A key passed to the `lts()` function returns the `TuningSpace`.

``` r
tuning_space = lts("classif.rpart.rbv2")
tuning_space
```

    ## <TuningSpace:classif.rpart.rbv2>: Classification Rpart with RandomBot
    ##           id lower upper levels logscale
    ## 1:        cp 1e-04     1            TRUE
    ## 2:  maxdepth 1e+00    30           FALSE
    ## 3: minbucket 1e+00   100           FALSE
    ## 4:  minsplit 1e+00   100           FALSE

Get the learner with tuning space.

``` r
tuning_space$get_learner()
```

    ## <LearnerClassifRpart:classif.rpart>: Classification Tree
    ## * Model: -
    ## * Parameters: xval=0, cp=<RangeTuneToken>, maxdepth=<RangeTuneToken>,
    ##   minbucket=<RangeTuneToken>, minsplit=<RangeTuneToken>
    ## * Packages: mlr3, rpart
    ## * Predict Types:  [response], prob
    ## * Feature Types: logical, integer, numeric, factor, ordered
    ## * Properties: importance, missings, multiclass, selected_features, twoclass, weights

### Adding New Tuning Spaces

We are looking forward to new collections of tuning spaces from
peer-reviewed articles. You can suggest new tuning spaces in an issue or
contribute a new collection yourself in a pull request. Take a look at
an already implemented collection e.g. our [default tuning
spaces](https://github.com/mlr-org/mlr3tuningspaces/blob/main/R/tuning_spaces_default.R)
from Bischl et al. (2021). A `TuningSpace` is added to the
`mlr_tuning_spaces` dictionary with the `add_tuning_space()` function.
Create a tuning space for each variant of the learner e.g. for
`LearnerClassifRpart` and `LearnerRegrRpart`.

``` r
vals = list(
  minsplit  = to_tune(2, 64, logscale = TRUE),
  cp        = to_tune(1e-04, 1e-1, logscale = TRUE)
)

add_tuning_space(
  id = "classif.rpart.example",
  values = vals,
  tags = c("default", "classification"),
  learner = "classif.rpart",
  label = "Classification Tree Example"
)
```

Choose a name that is related to the publication and adjust the
documentation.

The reference is added to the `bibentries.R` file

``` r
bischl_2021 = bibentry("misc",
  key           = "bischl_2021",
  title         = "Hyperparameter Optimization: Foundations, Algorithms, Best Practices and Open Challenges",
  author        = "Bernd Bischl and Martin Binder and Michel Lang and Tobias Pielok and Jakob Richter and Stefan Coors and Janek Thomas and Theresa Ullmann and Marc Becker and Anne-Laure Boulesteix and Difan Deng and Marius Lindauer",
  year          = "2021",
  eprint        = "2107.05847",
  archivePrefix = "arXiv",
  primaryClass  = "stat.ML",
  url           = "https://arxiv.org/abs/2107.05847"
)
```

We are happy to help you with the pull request if you have any
questions.

## References

<div id="refs" class="references hanging-indent">

<div id="ref-binder_2020">

Binder, Martin, Florian Pfisterer, and Bernd Bischl. 2020. “Collecting
Empirical Data About Hyperparameters for Data Driven Automl.”
<https://www.automl.org/wp-content/uploads/2020/07/AutoML_2020_paper_63.pdf>.

</div>

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
