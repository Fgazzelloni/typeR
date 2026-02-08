# Changelog

## typeR 0.2.1

### Bug fixes

- Fixed print method for statistical test objects (htest, anova, etc.)
  to display formatted output instead of raw list structure when using
  [`typeRun()`](https://Fgazzelloni.github.io/typeR/reference/typeRun.md)

### Documentation

- Added vignette example demonstrating statistical test display

------------------------------------------------------------------------

## typeR 0.2.0

CRAN release: 2026-02-04

\[Your previous 0.2.0 changes here…\]

### New Features

- [`typeRun()`](https://Fgazzelloni.github.io/typeR/reference/typeRun.md) -
  Enhanced version of
  [`typeR()`](https://Fgazzelloni.github.io/typeR/reference/typeR.md)
  with live code evaluation
  - Executes R code in real-time as it types
  - Interactive pause/resume control (press ESC)
  - Smart output handling with truncation
  - Full support for . R, .Rmd, and .qmd files
  - Customizable output limits with `max_print` parameter
  - Isolated environment evaluation

### Internal Changes

- Reorganized internal helper functions into separate files
- Added comprehensive documentation for
  [`typeRun()`](https://Fgazzelloni.github.io/typeR/reference/typeRun.md)
- Improved code organization with `utils-typing.R` and `utils-typerun.R`

------------------------------------------------------------------------

## typeR 0.1.0

- Initial CRAN release
- [`typeR()`](https://Fgazzelloni.github.io/typeR/reference/typeR.md)
  function for typing animation of R scripts and Quarto/RMarkdown files
