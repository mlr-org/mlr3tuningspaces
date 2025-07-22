#' @title Deep Learning Tuning Spaces from Yandex's RTDL
#'
#' @name mlr_tuning_spaces_rtdl
#'
#' @description
#' Tuning spaces for deep neural network architectures from the `r cite_bib("gorishniy2021revisiting")` article.
#'
#' These tuning spaces require optimizers that have a `weight_decay` parameter, such as AdamW or any of the other optimizers built into `mlr3torch`.
#'
#' When the article suggests multiple ranges for a given hyperparameter, these tuning spaces choose the widest range.
#' 
#' The FT-Transformer tuning space disables weight decay for all bias parameters, matching the implementation provided by the authors in the rtdl-revisiting-models package. 
#' However, this differs from the experiments described in the article, which states that the
#' 
#' For the FT-Transformer, if training is unstable, consider a combination of standardizing features, using an adaptive optimizer (e.g. Adam), reducing the learning rate,
#' and using a learning rate scheduler.
#'
#' @source
#' `r format_bib("gorishniy2021revisiting")`
#'
#' @aliases
#' mlr_tuning_spaces_classif.mlp.rtdl
#' mlr_tuning_spaces_classif.tab_resnet.rtdl
#' mlr_tuning_spaces_classif.ft_transformer.rtdl
#' mlr_tuning_spaces_regr.mlp.rtdl
#' mlr_tuning_spaces_regr.tab_resnet.rtdl
#' mlr_tuning_spaces_regr.ft_transformer.rtdl
#' 
#' @section MLP tuning space:
#' `r rd_info(lts("classif.mlp.rtdl"))`
#' 
#' @section Tabular ResNet tuning space:
#' `r rd_info(lts("classif.tab_resnet.rtdl"))`
#' 
#' @section FT-Transformer tuning space:
#' `r rd_info(lts("classif.ft_transformer.rtdl"))`
#' 
#' In the FT-Transformer, the validation-related parameters must still be set manually, via e.g. `lts("regr.ft_transformer.rtdl")$get_learner(validate = 0.2, measures_valid = msr("regr.rmse"))`.
#'
#' @include mlr_tuning_spaces.R
NULL

# mlp
vals = list(
  n_layers          = to_tune(1, 16),
  neurons           = to_tune(levels = 1:1024),
  p                 = to_tune(0, 0.5),
  opt.lr            = to_tune(1e-5, 1e-2, logscale = TRUE),
  opt.weight_decay  = to_tune(1e-6, 1e-3, logscale = TRUE),
  epochs            = to_tune(lower = 1L, upper = 100L, internal = TRUE),
  patience          = 17L
)

add_tuning_space(
  id = "classif.mlp.rtdl",
  values = vals,
  tags = c("gorishniy2021", "classification"),
  learner = "classif.mlp",
  package = "mlr3torch",
  label = "Classification MLP with RTDL"
)

add_tuning_space(
  id = "regr.mlp.rtdl",
  values = vals,
  tags = c("gorishniy2021", "regression"),
  learner = "regr.mlp",
  package = "mlr3torch",
  label = "Regression MLP with RTDL"
)

# resnet
vals = list(
  n_blocks            = to_tune(1, 16),
  d_block             = to_tune(64, 1024),
  d_hidden_multiplier = to_tune(1, 4),
  dropout1            = to_tune(0, 0.5),
  dropout2            = to_tune(0, 0.5),
  opt.lr              = to_tune(1e-5, 1e-2, logscale = TRUE),
  opt.weight_decay    = to_tune(1e-6, 1e-3, logscale = TRUE),
  epochs              = to_tune(lower = 1L, upper = 100L, internal = TRUE),
  patience            = 17L
)

add_tuning_space(
  id = "classif.tab_resnet.rtdl",
  values = vals,
  tags = c("gorishniy2021", "classification"),
  learner = "classif.tab_resnet",
  package = "mlr3torch",
  label = "Classification Tabular ResNet with RTDL"
)

add_tuning_space(
  id = "regr.tab_resnet.rtdl",
  values = vals,
  tags = c("gorishniy2021", "regression"),
  learner = "regr.tab_resnet",
  package = "mlr3torch",
  label = "Regression Tabular ResNet with RTDL"
)

no_wd = function(name) {
  # this will also disable weight decay for the input projection bias of the attention heads
  no_wd_params = c("_normalization", "bias")

  return(any(map_lgl(no_wd_params, function(pattern) grepl(pattern, name, fixed = TRUE))))
}

rtdl_param_groups = function(parameters) {
  ffn_norm_idx = grepl("ffn_normalization", names(parameters), fixed = TRUE)
  ffn_norm_num_in_module_list = as.integer(strsplit(names(parameters)[ffn_norm_idx][1], ".", fixed = TRUE)[[1]][2])
  cls_num_in_module_list = ffn_norm_num_in_module_list - 1
  nums_in_module_list = sapply(strsplit(names(parameters), ".", fixed = TRUE), function(x) as.integer(x[2]))
  tokenizer_idx = nums_in_module_list < cls_num_in_module_list

  no_wd_idx = map_lgl(names(parameters), no_wd) | tokenizer_idx
  no_wd_group = parameters[no_wd_idx]

  main_group = parameters[!no_wd_idx]

  list(
    list(params = main_group),
    list(params = no_wd_group, weight_decay = 0)
  )
}

# ft_transformer
vals = list(
  n_blocks                = to_tune(1, 6),
  d_token                 = to_tune(p_int(8L, 64L, trafo = function(x) 8L * x)),
  attention_n_heads       = 8L,
  residual_dropout        = to_tune(0, 0.2),
  attention_dropout       = to_tune(0, 0.5),
  ffn_dropout             = to_tune(0, 0.5),
  ffn_d_hidden_multiplier = to_tune(2 / 3, 8 / 3),
  opt.lr                  = to_tune(1e-5, 1e-4, logscale = TRUE),
  opt.weight_decay        = to_tune(1e-6, 1e-3, logscale = TRUE),
  opt.param_groups        = rtdl_param_groups,
  epochs                  = to_tune(lower = 1L, upper = 100L, internal = TRUE),
  patience                = 17L
)

add_tuning_space(
  id = "classif.ft_transformer.rtdl",
  values = vals,
  tags = c("gorishniy2021", "classification"),
  learner = "classif.ft_transformer",
  package = "mlr3torch",
  label = "Classification FT-Transformer with RTDL"
)

add_tuning_space(
  id = "regr.ft_transformer.rtdl",
  values = vals,
  tags = c("gorishniy2021", "regression"),
  learner = "regr.ft_transformer",
  package = "mlr3torch",
  label = "Regression FT-Transformer with RTDL"
)