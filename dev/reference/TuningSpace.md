# Tuning Spaces

This class defines a tuning space for hyperparameter tuning.

For tuning, it is important to create a search space that defines the
range over which hyperparameters should be tuned. `TuningSpace` object
consists of search spaces from peer-reviewed articles which work well
for a wide range of data sets.

The `$values` field stores a list of
[paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)
which define the search space. These tokens can be assigned to the
`$values` slot of a learner's
[paradox::ParamSet](https://paradox.mlr-org.com/reference/ParamSet.html).
When the learner is tuned, the tokens are used to create the search
space.

## S3 Methods

- `as.data.table.TuningSpace(x)`  
  Returns a tabular view of the tuning space.  
  TuningSpace -\>
  [`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)  

  - `x` (TuningSpace)

## Public fields

- `id`:

  (`character(1)`)  
  Identifier of the object.

- `values`:

  ([`list()`](https://rdrr.io/r/base/list.html))  
  List of
  [paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)
  that describe the tuning space and fixed parameter values.

- `tags`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Arbitrary tags to group and filter tuning space e.g.
  `"classification"` or "`regression`".

- `learner`:

  (`character(1)`)  
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html) of
  the tuning space.

- `package`:

  (`character(1)`)  
  Packages which provide the
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html), e.g.
  [mlr3learners](https://CRAN.R-project.org/package=mlr3learners) for
  the learner
  [mlr3learners::LearnerClassifRanger](https://mlr3learners.mlr-org.com/reference/mlr_learners_classif.ranger.html)
  which interfaces the
  [ranger](https://CRAN.R-project.org/package=ranger) package.

- `label`:

  (`character(1)`)  
  Label for this object. Can be used in tables, plot and text output
  instead of the ID.

- `man`:

  (`character(1)`)  
  String in the format `[pkg]::[topic]` pointing to a manual page for
  this object. The referenced help package can be opened via method
  `$help()`.

## Methods

### Public methods

- [`TuningSpace$new()`](#method-TuningSpace-new)

- [`TuningSpace$get_learner()`](#method-TuningSpace-get_learner)

- [`TuningSpace$format()`](#method-TuningSpace-format)

- [`TuningSpace$help()`](#method-TuningSpace-help)

- [`TuningSpace$print()`](#method-TuningSpace-print)

- [`TuningSpace$clone()`](#method-TuningSpace-clone)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    TuningSpace$new(
      id,
      values,
      tags,
      learner,
      package = character(),
      label = NA_character_,
      man = NA_character_
    )

#### Arguments

- `id`:

  (`character(1)`)  
  Identifier for the new instance.

- `values`:

  ([`list()`](https://rdrr.io/r/base/list.html))  
  List of
  [paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)
  that describe the tuning space and fixed parameter values.

- `tags`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Tags to group and filter tuning spaces e.g. `"classification"` or
  "`regression`".

- `learner`:

  (`character(1)`)  
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html) of
  the tuning space.

- `package`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Packages which provide the
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html), e.g.
  [mlr3learners](https://CRAN.R-project.org/package=mlr3learners) for
  the learner
  [mlr3learners::LearnerClassifRanger](https://mlr3learners.mlr-org.com/reference/mlr_learners_classif.ranger.html)
  which interfaces the
  [ranger](https://CRAN.R-project.org/package=ranger) package.

- `label`:

  (`character(1)`)  
  Label for the new instance. Can be used in tables, plot and text
  output instead of the ID.

- `man`:

  (`character(1)`)  
  String in the format `[pkg]::[topic]` pointing to a manual page for
  for the new instance. The referenced help package can be opened via
  method `$help()`.

------------------------------------------------------------------------

### Method `get_learner()`

Returns a learner with
[paradox::TuneToken](https://paradox.mlr-org.com/reference/to_tune.html)
set in parameter set.

#### Usage

    TuningSpace$get_learner(...)

#### Arguments

- `...`:

  (named ‘list()’)  
  Passed to
  [`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html).
  Named arguments passed to the constructor, to be set as parameters in
  the
  [paradox::ParamSet](https://paradox.mlr-org.com/reference/ParamSet.html),
  or to be set as public field. See
  [`mlr3misc::dictionary_sugar_get()`](https://mlr3misc.mlr-org.com/reference/dictionary_sugar_get.html)
  for more details.

#### Returns

[mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)

------------------------------------------------------------------------

### Method [`format()`](https://rdrr.io/r/base/format.html)

Helper for print outputs.

#### Usage

    TuningSpace$format(...)

#### Arguments

- `...`:

  (ignored).

------------------------------------------------------------------------

### Method [`help()`](https://rdrr.io/r/utils/help.html)

Opens the corresponding help page referenced by field `$man`.

#### Usage

    TuningSpace$help()

------------------------------------------------------------------------

### Method [`print()`](https://rdrr.io/r/base/print.html)

Printer.

#### Usage

    TuningSpace$print(...)

#### Arguments

- `...`:

  (ignored).

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    TuningSpace$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
library(mlr3tuning)

# Get default tuning space of rpart learner
tuning_space = lts("classif.rpart.default")

# Set tuning space
learner = lrn("classif.rpart")
learner$param_set$values = tuning_space$values

# Tune learner
instance = tune(
  tnr("random_search"),
  task = tsk("sonar"),
  learner = learner,
  resampling = rsmp ("holdout"),
  measure = msr("classif.ce"),
  term_evals = 10)

instance$result
#>           cp minbucket minsplit learner_param_vals  x_domain classif.ce
#>        <num>     <num>    <num>             <list>    <list>      <num>
#> 1: -5.531511  2.282575 1.092841          <list[3]> <list[3]>  0.3478261

library(mlr3pipelines)

# Set tuning space in a pipeline
graph_learner = as_learner(po("subsample") %>>%
  lts(lrn("classif.rpart")))
```
