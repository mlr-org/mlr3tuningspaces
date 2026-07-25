# Deep Learning Tuning Spaces from Yandex's RTDL

Tuning spaces for deep neural network architectures from the Gorishniy
(2021) article.

These tuning spaces require optimizers that have a `weight_decay`
parameter, such as AdamW or any of the other optimizers built into
`mlr3torch`.

When the article suggests multiple ranges for a given hyperparameter,
these tuning spaces choose the widest range.

The FT-Transformer tuning space disables weight decay for all bias
parameters, matching the implementation provided by the authors in the
rtdl-revisiting-models package. However, this differs from the
experiments described in the article, which states that the

For the FT-Transformer, if training is unstable, consider a combination
of standardizing features, using an adaptive optimizer (e.g. Adam),
reducing the learning rate, and using a learning rate scheduler.

## Source

Gorishniy Y, Rubachev I, Khrulkov V, Babenko A (2021). “Revisiting Deep
Learning for Tabular Data.” *arXiv*, **2106.11959**.

## MLP tuning space

- n_layers \\\[1, 16\]\\

- neurons -

- p \\\[0, 0.5\]\\

- opt.lr \\\[1e-05, 0.01\]\\ Logscale

- opt.weight_decay \\\[1e-06, 0.001\]\\ Logscale

- epochs \\\[1, 100\]\\

- patience 17

## Tabular ResNet tuning space

- n_blocks \\\[1, 16\]\\

- d_block \\\[64, 1024\]\\

- d_hidden_multiplier \\\[1, 4\]\\

- dropout1 \\\[0, 0.5\]\\

- dropout2 \\\[0, 0.5\]\\

- opt.lr \\\[1e-05, 0.01\]\\ Logscale

- opt.weight_decay \\\[1e-06, 0.001\]\\ Logscale

- epochs \\\[1, 100\]\\

- patience 17

## FT-Transformer tuning space

- n_blocks \\\[1, 6\]\\

- d_token \\\[8, 64\]\\

- attention_n_heads 8

- residual_dropout \\\[0, 0.2\]\\

- attention_dropout \\\[0, 0.5\]\\

- ffn_dropout \\\[0, 0.5\]\\

- ffn_d_hidden_multiplier \\\[0.666666666666667, 2.66666666666667\]\\

- opt.lr \\\[1e-05, 1e-04\]\\ Logscale

- opt.weight_decay \\\[1e-06, 0.001\]\\ Logscale

- opt.param_groups -

- epochs \\\[1, 100\]\\

- patience 17

In the FT-Transformer, the validation-related parameters must still be
set manually, via e.g.
`lts("regr.ft_transformer.rtdl")$get_learner(validate = 0.2, measures_valid = msr("regr.rmse"))`.
