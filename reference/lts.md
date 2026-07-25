# Syntactic Sugar for Tuning Space Construction

Function to retrieve
[TuningSpace](https://mlr3tuningspaces.mlr-org.com/reference/TuningSpace.md)
objects from
[mlr_tuning_spaces](https://mlr3tuningspaces.mlr-org.com/reference/mlr_tuning_spaces.md)
and further, allows a
[mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html) to be
directly configured with a search space. This function belongs to
[mlr3::mlr_sugar](https://mlr3.mlr-org.com/reference/mlr_sugar.html)
family.

## Usage

``` r
lts(x, ...)

# S3 method for class 'missing'
lts(x, ...)

# S3 method for class 'character'
lts(x, ...)

# S3 method for class 'Learner'
lts(x, ...)

ltss(x)
```

## Arguments

- x:

  ([`character()`](https://rdrr.io/r/base/character.html) \|
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html))  
  If `character`, key passed the dictionary to retrieve the tuning
  space. If
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html),
  default tuning space is added to the learner.

- ...:

  (named list of
  [paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)
  \| `NULL`)  
  Pass
  [paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)
  to add or overwrite parameters in the tuning space. Use `NULL` to
  remove parameters (see examples).

## Value

[TuningSpace](https://mlr3tuningspaces.mlr-org.com/reference/TuningSpace.md)
if `x` is [`character()`](https://rdrr.io/r/base/character.html).
[mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html) if `x`
is [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html). Or
a list of objects for the `ltss()` function.

missing,
[mlr_tuning_spaces](https://mlr3tuningspaces.mlr-org.com/reference/mlr_tuning_spaces.md)
dictionary

a `character`,
[TuningSpace](https://mlr3tuningspaces.mlr-org.com/reference/TuningSpace.md)

a [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html),
[mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html) with
[paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)

a [`list()`](https://rdrr.io/r/base/list.html), list of
[TuningSpace](https://mlr3tuningspaces.mlr-org.com/reference/TuningSpace.md)
or [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)

## Examples

``` r
# load tuning space
lts("classif.rpart.default")
#> 
#> ── <TuningSpace> (classif.rpart.default): Classification Rpart with Default ────
#>           id lower upper levels logscale
#>       <char> <num> <num> <list>   <lgcl>
#> 1:  minsplit 2e+00 128.0 [NULL]     TRUE
#> 2: minbucket 1e+00  64.0 [NULL]     TRUE
#> 3:        cp 1e-04   0.1 [NULL]     TRUE

# load tuning space and add parameter
lts("classif.rpart.default", maxdepth = to_tune(1, 15))
#> 
#> ── <TuningSpace> (classif.rpart.default): Classification Rpart with Default ────
#>           id lower upper levels logscale
#>       <char> <num> <num> <list>   <lgcl>
#> 1:  minsplit 2e+00 128.0 [NULL]     TRUE
#> 2: minbucket 1e+00  64.0 [NULL]     TRUE
#> 3:        cp 1e-04   0.1 [NULL]     TRUE
#> 4:  maxdepth 1e+00  15.0 [NULL]    FALSE

# load tuning space and remove parameter
lts("classif.rpart.default", minsplit = NULL)
#> 
#> ── <TuningSpace> (classif.rpart.default): Classification Rpart with Default ────
#>           id lower upper levels logscale
#>       <char> <num> <num> <list>   <lgcl>
#> 1: minbucket 1e+00  64.0 [NULL]     TRUE
#> 2:        cp 1e-04   0.1 [NULL]     TRUE

# load tuning space and overwrite parameter
lts("classif.rpart.default", minsplit = to_tune(32, 128))
#> 
#> ── <TuningSpace> (classif.rpart.default): Classification Rpart with Default ────
#>           id   lower upper levels logscale
#>       <char>   <num> <num> <list>   <lgcl>
#> 1:  minsplit 32.0000 128.0 [NULL]    FALSE
#> 2: minbucket  1.0000  64.0 [NULL]     TRUE
#> 3:        cp  0.0001   0.1 [NULL]     TRUE

# load learner and apply tuning space in one go
lts(lrn("classif.rpart"))
#> 
#> ── <LearnerClassifRpart> (classif.rpart): Classification Tree ──────────────────
#> • Model: -
#> • Parameters: cp=<RangeTuneToken>, minbucket=<RangeTuneToken>,
#> minsplit=<RangeTuneToken>, xval=0
#> • Packages: mlr3 and rpart
#> • Predict Types: [response] and prob
#> • Feature Types: logical, integer, numeric, factor, and ordered
#> • Encapsulation: none (fallback: -)
#> • Properties: importance, missings, multiclass, selected_features, twoclass,
#> and weights
#> • Other settings: use_weights = 'use', predict_raw = 'FALSE'

# load learner, overwrite parameter and apply tuning space
lts(lrn("classif.rpart"), minsplit = to_tune(32, 128))
#> 
#> ── <LearnerClassifRpart> (classif.rpart): Classification Tree ──────────────────
#> • Model: -
#> • Parameters: cp=<RangeTuneToken>, minbucket=<RangeTuneToken>,
#> minsplit=<RangeTuneToken>, xval=0
#> • Packages: mlr3 and rpart
#> • Predict Types: [response] and prob
#> • Feature Types: logical, integer, numeric, factor, and ordered
#> • Encapsulation: none (fallback: -)
#> • Properties: importance, missings, multiclass, selected_features, twoclass,
#> and weights
#> • Other settings: use_weights = 'use', predict_raw = 'FALSE'

# load multiple tuning spaces
ltss(c("classif.rpart.default", "classif.ranger.default"))
#> [[1]]
#> 
#> ── <TuningSpace> (classif.rpart.default): Classification Rpart with Default ────
#>           id lower upper levels logscale
#>       <char> <num> <num> <list>   <lgcl>
#> 1:  minsplit 2e+00 128.0 [NULL]     TRUE
#> 2: minbucket 1e+00  64.0 [NULL]     TRUE
#> 3:        cp 1e-04   0.1 [NULL]     TRUE
#> 
#> [[2]]
#> 
#> ── <TuningSpace> (classif.ranger.default): Classification Ranger with Default ──
#>                 id lower upper levels logscale
#>             <char> <num> <num> <list>   <lgcl>
#> 1:      mtry.ratio   0.0     1 [NULL]    FALSE
#> 2:         replace    NA    NA [NULL]    FALSE
#> 3: sample.fraction   0.1     1 [NULL]    FALSE
#> 4:       num.trees   1.0  2000 [NULL]    FALSE
#> 
```
