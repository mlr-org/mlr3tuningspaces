# RandomBot V2 Tuning Spaces

Tuning spaces from the Binder (2020) article.

## Source

Binder M, Pfisterer F, Bischl B (2020). “Collecting Empirical Data About
Hyperparameters for Data Driven AutoML.”
<https://www.automl.org/wp-content/uploads/2020/07/AutoML_2020_paper_63.pdf>.

## glmnet tuning space

- alpha \\\[0, 1\]\\

- s \\\[1e-04, 1000\]\\ Logscale

## ranger tuning space

- num.trees \\\[1, 2000\]\\

- replace \[TRUE,FALSE\]

- sample.fraction \\\[0.1, 1\]\\

- mtry.ratio \\\[0, 1\]\\

- respect.unordered.factors \[“ignore”, “order”, “partition”\]

- min.node.size \\\[1, 100\]\\

- splitrule \[“gini”, “extratrees”\]

- num.random.splits \\\[1, 100\]\\

`mtry.power` is replaced by `mtry.ratio`.

## rpart tuning space

- cp \\\[1e-04, 1\]\\ Logscale

- maxdepth \\\[1, 30\]\\

- minbucket \\\[1, 100\]\\

- minsplit \\\[1, 100\]\\

## svm tuning space

- kernel \[“linear”, “polynomial”, “radial”\]

- cost \\\[1e-04, 1000\]\\ Logscale

- gamma \\\[1e-04, 1000\]\\ Logscale

- tolerance \\\[1e-04, 2\]\\ Logscale

- degree \\\[2, 5\]\\

## xgboost tuning space

- booster \[“gblinear”, “gbtree”, “dart”\]

- nrounds \\\[7, 2981\]\\ Logscale

- eta \\\[1e-04, 1\]\\ Logscale

- gamma \\\[1e-05, 7\]\\ Logscale

- lambda \\\[1e-04, 1000\]\\ Logscale

- alpha \\\[1e-04, 1000\]\\ Logscale

- subsample \\\[0.1, 1\]\\

- max_depth \\\[1, 15\]\\

- min_child_weight \\\[1, 100\]\\ Logscale

- colsample_bytree \\\[0.01, 1\]\\

- colsample_bylevel \\\[0.01, 1\]\\

- rate_drop \\\[0, 1\]\\

- skip_drop \\\[0, 1\]\\
