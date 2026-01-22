# typeR 0.2.0

## New Features

* `typeRun()` - Enhanced version of `typeR()` with live code evaluation
  - Executes R code in real-time as it types
  - Interactive pause/resume control (press ESC)
  - Smart output handling with truncation
  - Full support for . R, .Rmd, and .qmd files
  - Customizable output limits with `max_print` parameter
  - Isolated environment evaluation

## Internal Changes

* Reorganized internal helper functions into separate files
* Added comprehensive documentation for `typeRun()`
* Improved code organization with `utils-typing.R` and `utils-typerun.R`

---

# typeR 0.1.0

* Initial CRAN release
* `typeR()` function for typing animation of R scripts and Quarto/RMarkdown files
