# RandomBot Tuning Spaces

Tuning spaces from the Kuehn (2018) article.

## Source

Kuehn D, Probst P, Thomas J, Bischl B (2018). “Automatic Exploration of
Machine Learning Experiments on OpenML.” 1806.10961,
<https://arxiv.org/abs/1806.10961>.

## glmnet tuning space

- alpha \\\[0, 1\]\\

- s \\\[1e-04, 1000\]\\ Logscale

## ranger tuning space

- num.trees \\\[1, 2000\]\\

- replace \[TRUE,FALSE\]

- sample.fraction \\\[0.1, 1\]\\

- mtry.ratio \\\[0, 1\]\\

- respect.unordered.factors \[“ignore”, “order”\]

- min.node.size \\\[1, 100\]\\

The tuning space of the ranger learner is slightly different from the
original paper. The hyperparameter `mtry.power` is replaced by
`mtry.ratio` and `min.node.size` is explored in a range from 1 to 100.

## rpart tuning space

- cp \\\[0, 1\]\\

- maxdepth \\\[1, 30\]\\

- minbucket \\\[1, 60\]\\

- minsplit \\\[1, 60\]\\

## svm tuning space

- kernel \[“linear”, “polynomial”, “radial”\]

- cost \\\[1e-04, 1000\]\\ Logscale

- gamma \\\[1e-04, 1000\]\\ Logscale

- degree \\\[2, 5\]\\

## xgboost tuning space

- nrounds \\\[1, 5000\]\\

- eta \\\[1e-04, 1\]\\ Logscale

- subsample \\\[0, 1\]\\

- booster \[“gblinear”, “gbtree”, “dart”\]

- max_depth \\\[1, 15\]\\

- min_child_weight \\\[1, 100\]\\ Logscale

- colsample_bytree \\\[0, 1\]\\

- colsample_bylevel \\\[0, 1\]\\

- lambda \\\[1e-04, 1000\]\\ Logscale

- alpha \\\[1e-04, 1000\]\\ Logscale
