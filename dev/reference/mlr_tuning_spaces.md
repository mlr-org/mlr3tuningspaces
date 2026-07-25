# Dictionary of Tuning Spaces

A simple
[mlr3misc::Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
storing objects of class
[TuningSpace](https://mlr3tuningspaces.mlr-org.com/dev/reference/TuningSpace.md).
Each tuning space has an associated help page, see
`mlr_tuning_spaces_[id]`.

## Format

[R6::R6Class](https://r6.r-lib.org/reference/R6Class.html) object
inheriting from
[mlr3misc::Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html).

## Methods

See
[mlr3misc::Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html).

## S3 methods

- `as.data.table(dict, ..., objects = FALSE)`  
  [mlr3misc::Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
  -\>
  [`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)  
  Returns a
  [`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)
  with fields "key", "label", "learner", and "n_values" as columns. If
  `objects` is set to `TRUE`, the constructed objects are returned in
  the list column named `object`.

## Examples

``` r
as.data.table(mlr_tuning_spaces)
#> Key: <key>
#>                             key                                   label
#>                          <char>                                  <char>
#>  1: classif.ft_transformer.rtdl Classification FT-Transformer with RTDL
#>  2:      classif.glmnet.default         Classification GLM with Default
#>  3:         classif.glmnet.rbv1       Classification GLM with RandomBot
#>  4:         classif.glmnet.rbv2       Classification GLM with RandomBot
#>  5:            classif.mlp.rtdl            Classification MLP with RTDL
#>  6:      classif.ranger.default      Classification Ranger with Default
#>  7:         classif.ranger.rbv1    Classification Ranger with RandomBot
#>  8:         classif.ranger.rbv2    Classification Ranger with RandomBot
#>  9:       classif.rpart.default       Classification Rpart with Default
#> 10:          classif.rpart.rbv1     Classification Rpart with RandomBot
#> 11:          classif.rpart.rbv2     Classification Rpart with RandomBot
#> 12:         classif.svm.default         Classification SVM with Default
#> 13:            classif.svm.rbv1       Classification SVM with RandomBot
#> 14:            classif.svm.rbv2       Classification SVM with RandomBot
#> 15:     classif.tab_resnet.rtdl Classification Tabular ResNet with RTDL
#> 16:     classif.xgboost.default     Classification XGBoost with Default
#> 17:        classif.xgboost.rbv1   Classification XGBoost with RandomBot
#> 18:        classif.xgboost.rbv2   Classification XGBoost with RandomBot
#> 19:    regr.ft_transformer.rtdl     Regression FT-Transformer with RTDL
#> 20:         regr.glmnet.default             Regression GLM with Default
#> 21:            regr.glmnet.rbv1           Regression GLM with RandomBot
#> 22:            regr.glmnet.rbv2           Regression GLM with RandomBot
#> 23:               regr.mlp.rtdl                Regression MLP with RTDL
#> 24:         regr.ranger.default          Regression Ranger with Default
#> 25:            regr.ranger.rbv1        Regression Ranger with RandomBot
#> 26:            regr.ranger.rbv2        Regression Ranger with RandomBot
#> 27:          regr.rpart.default           Regression Rpart with Default
#> 28:             regr.rpart.rbv1         Regression Rpart with RandomBot
#> 29:             regr.rpart.rbv2         Regression Rpart with RandomBot
#> 30:            regr.svm.default             Regression SVM with Default
#> 31:               regr.svm.rbv1           Regression SVM with RandomBot
#> 32:               regr.svm.rbv2           Regression SVM with RandomBot
#> 33:        regr.tab_resnet.rtdl     Regression Tabular ResNet with RTDL
#> 34:        regr.xgboost.default         Regression XGBoost with Default
#> 35:           regr.xgboost.rbv1       Regression XGBoost with RandomBot
#> 36:           regr.xgboost.rbv2       Regression XGBoost with RandomBot
#>                             key                                   label
#>                          <char>                                  <char>
#>                    learner n_values
#>                     <char>    <int>
#>  1: classif.ft_transformer       12
#>  2:         classif.glmnet        2
#>  3:         classif.glmnet        2
#>  4:         classif.glmnet        2
#>  5:            classif.mlp        7
#>  6:         classif.ranger        4
#>  7:         classif.ranger        6
#>  8:         classif.ranger        8
#>  9:          classif.rpart        3
#> 10:          classif.rpart        4
#> 11:          classif.rpart        4
#> 12:            classif.svm        4
#> 13:            classif.svm        4
#> 14:            classif.svm        5
#> 15:     classif.tab_resnet        9
#> 16:        classif.xgboost        8
#> 17:        classif.xgboost       10
#> 18:        classif.xgboost       13
#> 19:    regr.ft_transformer       12
#> 20:            regr.glmnet        2
#> 21:            regr.glmnet        2
#> 22:            regr.glmnet        2
#> 23:               regr.mlp        7
#> 24:            regr.ranger        4
#> 25:            regr.ranger        6
#> 26:            regr.ranger        7
#> 27:             regr.rpart        3
#> 28:             regr.rpart        4
#> 29:             regr.rpart        4
#> 30:               regr.svm        4
#> 31:               regr.svm        4
#> 32:               regr.svm        5
#> 33:        regr.tab_resnet        9
#> 34:           regr.xgboost        8
#> 35:           regr.xgboost       10
#> 36:           regr.xgboost       13
#>                    learner n_values
#>                     <char>    <int>
mlr_tuning_spaces$get("classif.ranger.default")
#> 
#> ── <TuningSpace> (classif.ranger.default): Classification Ranger with Default ──
#>                 id lower upper levels logscale
#>             <char> <num> <num> <list>   <lgcl>
#> 1:      mtry.ratio   0.0     1 [NULL]    FALSE
#> 2:         replace    NA    NA [NULL]    FALSE
#> 3: sample.fraction   0.1     1 [NULL]    FALSE
#> 4:       num.trees   1.0  2000 [NULL]    FALSE
lts("classif.ranger.default")
#> 
#> ── <TuningSpace> (classif.ranger.default): Classification Ranger with Default ──
#>                 id lower upper levels logscale
#>             <char> <num> <num> <list>   <lgcl>
#> 1:      mtry.ratio   0.0     1 [NULL]    FALSE
#> 2:         replace    NA    NA [NULL]    FALSE
#> 3: sample.fraction   0.1     1 [NULL]    FALSE
#> 4:       num.trees   1.0  2000 [NULL]    FALSE
```
