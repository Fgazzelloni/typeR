# typeR

[![CRAN
status](https://www.r-pkg.org/badges/version/typeR)](https://CRAN.R-project.org/package=typeR)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/grand-total/typeR)](https://CRAN.R-project.org/package=typeR)

`typeR` is an R package that simulates typing effects on R script files,
making it ideal for live coding presentations, interactive teaching, or
creating animations. It supports **R scripts**, **R Markdown**, and
**Quarto presentations** (including reveal.js slides).

## Installation

``` r
# Install from CRAN
install.packages("typeR")

# Or get development version

# Install devtools if you don't already have it
install.packages("devtools")

devtools::install_github("Fgazzelloni/typeR")
```

## Usage

### Basic R Scripts

Here’s an example of how to use the `typeR` package:

``` r
library(typeR)

# Create a test script for demonstration
writeLines(c(
  "# Testing typeR",
  "x <- 1:10",
  "y <- x*2",
  "plot(x, y)"
), "test_script.R")

# Simulate typing the script (display only)
typeR("test_script.R", delay = 0.05)

# Type AND execute the code
typeRun("test_script.R", delay = 0.05)
```

### Quarto Presentations

Perfect for live coding in presentations! Works seamlessly with Quarto
reveal.js slides:

``` r
# Use the included example presentation
demo_file <- system.file("examples/demo-presentation.qmd", package = "typeR")
typeRun(demo_file)

# Or create your own Quarto presentation
typeRun("my-presentation.qmd", delay = 0.08, max_print = 5)
```

See the [Quarto Presentations
vignette](https://fgazzelloni.github.io/typeR/articles/quarto-presentations.html)
for detailed examples and best practices.

## Features

- **Typing Animation**: Simulates realistic typing of R code character
  by character
- **Live Execution**:
  [`typeRun()`](https://Fgazzelloni.github.io/typeR/reference/typeRun.md)
  executes code in real-time as it types
- **Multiple Formats**: Supports `.R`, `.Rmd`, and `.qmd` (Quarto) files
- **Quarto Presentations**: Perfect for reveal.js slides and other
  Quarto formats
- **Interactive Control**: Press ESC to pause, then resume or stop
- **Smart Output**: Handles plots, models, and long outputs
  intelligently
- **Customizable Speed**: Adjust `delay` and `jitter` for natural typing
  rhythm
- **Teaching-Friendly**: Ideal for courses, workshops, and conference
  presentations

## Contributing

Contributions are welcome! Please open an issue or submit a pull
request.

## License

This package is licensed under the MIT License. See the
[LICENSE](https://Fgazzelloni.github.io/typeR/LICENSE) file for details.
