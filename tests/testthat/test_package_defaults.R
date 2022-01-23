test_that("prediction is equal", {
   tab = as.data.table(mlr_tuning_spaces)
   keys = tab[grep("kknn.*\\.package", tab$key), key]
   walk(keys, test_package_defaults)
})
