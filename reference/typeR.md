# Simulate Typing of an R Script File

Simulates typing out the content of an R script file, line by line,
character by character, to create an animation effect for live coding
presentations or educational demonstrations.

## Usage

``` r
typeR(file, delay = 0.05)
```

## Arguments

- file:

  Path to the R script file to simulate typing.

- delay:

  The delay (in seconds) between typing each character (default: 0.05).

## Value

Invisibly returns NULL. Called for the side effect of displaying typed
content in the console with animation.

## Examples

``` r
# Create a temporary R script for demonstration
tmp <- tempfile(fileext = ".R")
writeLines(c(
  "# Example R script",
  "x <- 1:10",
  "mean(x)"
), tmp)

# Simulate typing the script (fast for testing)
typeR(tmp, delay = 0.01)
#> # Example R script
#> x <- 1:10
#> mean(x)

# Clean up
unlink(tmp)

# Longer example with realistic typing speed
# \donttest{
  tmp2 <- tempfile(fileext = ".R")
  writeLines(c(
    "# Data analysis example",
    "data <- mtcars",
    "model <- lm(mpg ~ wt, data = data)",
    "summary(model)"
  ), tmp2)
  typeR(tmp2, delay = 0.08)
#> # Data analysis example
#> data <- mtcars
#> model <- lm(mpg ~ wt, data = data)
#> summary(model)
  unlink(tmp2)
# }
```
