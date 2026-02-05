# Type and Run R Code with Live Evaluation

An enhanced version of
[`typeR`](https://Fgazzelloni.github.io/typeR/reference/typeR.md) that
not only simulates typing but also evaluates R code in real-time.
Supports interactive pause/resume control and handles both Quarto/R
Markdown documents and plain R scripts.

## Usage

``` r
typeRun(
  file,
  delay = 0.05,
  jitter = 0.01,
  max_print = 10,
  envir = new.env(parent = .GlobalEnv)
)
```

## Arguments

- file:

  Character string. Path to an R script (.R), R Markdown (.Rmd), or
  Quarto (.qmd) file to type and execute.

- delay:

  Numeric. Base delay in seconds between typing each character. Default
  is 0.05 (50 milliseconds).

- jitter:

  Numeric. Standard deviation for random variation in typing speed,
  adding natural typing rhythm. Default is 0.01.

- max_print:

  Integer. Maximum number of elements to print for long outputs
  (vectors, data frames, matrices, lists). Default is 10.

- envir:

  Environment. The environment in which to evaluate R code. Default is a
  new environment with the global environment as parent.

## Value

Invisibly returns `NULL`. Called for side effects (typing animation and
code evaluation).

## Details

`typeRun()` extends the basic
[`typeR()`](https://Fgazzelloni.github.io/typeR/reference/typeR.md)
functionality by:

- **Live Code Evaluation:** Executes R code chunks as they are typed

- **Interactive Control:** Press ESC/Ctrl+C to pause, then choose to
  resume or stop

- **Smart Output:** Truncates long outputs and handles models
  intelligently

- **Format Support:** Handles .R, .Rmd, and .qmd files intelligently

For Quarto/R Markdown files, `typeRun()`:

- Skips YAML headers

- Only evaluates code in R code chunks

- Preserves narrative text without evaluation

For R scripts, it evaluates all non-comment, non-empty lines.

## Output Handling

- Assignments and plotting functions execute silently

- Long vectors/data frames are truncated to `max_print` elements

- Model summaries (lm, glm, etc.) display using R's standard print
  methods

- Raw model objects (without summary call) show a simple fitted message

- Package loading messages (library/require) are suppressed

- Errors are caught and displayed without stopping execution

## Interactive Control

During execution, you can:

1.  Press **ESC** (or Ctrl+C on some systems) to pause

2.  Enter **1** to resume from where you paused

3.  Enter **2** to stop completely

## See also

[`typeR`](https://Fgazzelloni.github.io/typeR/reference/typeR.md) for
typing without evaluation

## Examples

``` r
# Create a temporary R script for demonstration
tmp <- tempfile(fileext = ".R")
writeLines(c(
  "# Simple calculation",
  "x <- 1:5",
  "print(mean(x))",
  "y <- x^2",
  "print(sum(y))"
), tmp)

# Type and run with fast animation (for quick testing)
# \donttest{
  typeRun(tmp, delay = 0.01, max_print = 5)
#> 
#> typeRun press ESC to pause.. .
#> 
#> # Simple calculation
#> x <- 1:5
#> print(mean(x))
#> [1] 3
#> y <- x^2
#> print(sum(y))
#> [1] 55
#> 
#> typeRun completed!
# }

# Clean up
unlink(tmp)

# Interactive examples with real files
if (interactive()) {
  # Type and run a simple R script
  typeRun("analysis.R")

  # Type and run with slower, more dramatic effect
  typeRun("demo.R", delay = 0.1, jitter = 0.02)

  # Type and run a Quarto document with limited output
  typeRun("report.qmd", max_print = 5)
}
```
