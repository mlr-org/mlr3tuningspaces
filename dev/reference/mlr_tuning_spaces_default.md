# Default Tuning Spaces

Tuning spaces from the Bischl (2023) article.

## Source

Bischl B, Binder M, Lang M, Pielok T, Richter J, Coors S, Thomas J,
Ullmann T, Becker M, Boulesteix A, Deng D, Lindauer M (2023).
“Hyperparameter Optimization: Foundations, Algorithms, Best Practices
and Open Challenges.”

## glmnet tuning space

- s \\\[1e-04, 10000\]\\ Logscale

- alpha \\\[0, 1\]\\

## ranger tuning space

- mtry.ratio \\\[0, 1\]\\

- replace \[TRUE,FALSE\]

- sample.fraction \\\[0.1, 1\]\\

- num.trees \\\[1, 2000\]\\

## rpart tuning space

- minsplit \\\[2, 128\]\\ Logscale

- minbucket \\\[1, 64\]\\ Logscale

- cp \\\[1e-04, 0.1\]\\ Logscale

## svm tuning space

- cost \\\[1e-04, 10000\]\\ Logscale

- kernel \[“polynomial”, “radial”, “sigmoid”, “linear”\]

- degree \\\[2, 5\]\\

- gamma \\\[1e-04, 10000\]\\ Logscale

## xgboost tuning space

- eta \\\[1e-04, 1\]\\ Logscale

- nrounds \\\[1, 5000\]\\

- max_depth \\\[1, 20\]\\

- colsample_bytree \\\[0.1, 1\]\\

- colsample_bylevel \\\[0.1, 1\]\\

- lambda \\\[0.001, 1000\]\\ Logscale

- alpha \\\[0.001, 1000\]\\ Logscale

- subsample \\\[0.1, 1\]\\
