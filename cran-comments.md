## R CMD check results

0 errors | 0 warnings | 0 notes

## Submission type

This is a patch release (bug fix) updating from version 0.2.0 to 0.2.1.

## Test environments

* local: macOS (R 4.5.0)
* win-builder: (devel and release)
* R-hub v2

## What's new in version 0.2.1

Bug fixes:

* Fixed print method for statistical test objects (htest, anova, aov, etc.) in `typeRun()`. These objects were displaying as raw list structures instead of using their proper formatted print methods. Objects with custom S3 print methods now display correctly.

Documentation:

* Added vignette example demonstrating proper display of statistical test results

## Previous versions

### Version 0.2.0
* New function: `typeRun()` for live code execution with typing animation
* Improved documentation and vignettes
* Added support for Quarto (.qmd) files
* Enhanced error handling and user feedback
* Fixed NAMESPACE to properly scope function exports

## Downstream dependencies

There are currently no downstream dependencies for this package.

## Additional notes

* All spelling exceptions are documented in inst/WORDLIST
* Package includes two vignettes demonstrating core functionality
* All examples are wrapped in \dontrun{} or \donttest{} as they require interactive sessions
