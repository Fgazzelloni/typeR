#' Simulate Typing of an R Script File
#'
#' Simulates typing out the content of an R script file, line by line,
#' character by character, to create an animation effect for live coding
#' presentations or educational demonstrations.
#'
#' @param file Path to the R script file to simulate typing.
#' @param delay The delay (in seconds) between typing each character (default: 0.05).
#'
#' @return Invisibly returns NULL. Called for the side effect of displaying
#'   typed content in the console with animation.
#'
#' @export
#'
#' @examples
#' # Create a temporary R script for demonstration
#' tmp <- tempfile(fileext = ".R")
#' writeLines(c(
#'   "# Example R script",
#'   "x <- 1:10",
#'   "mean(x)"
#' ), tmp)
#'
#' # Simulate typing the script (fast for testing)
#' typeR(tmp, delay = 0.01)
#'
#' # Clean up
#' unlink(tmp)
#'
#' # Longer example with realistic typing speed
#' \donttest{
#'   tmp2 <- tempfile(fileext = ".R")
#'   writeLines(c(
#'     "# Data analysis example",
#'     "data <- mtcars",
#'     "model <- lm(mpg ~ wt, data = data)",
#'     "summary(model)"
#'   ), tmp2)
#'   typeR(tmp2, delay = 0.08)
#'   unlink(tmp2)
#' }
typeR <- function(file, delay = 0.05) {
  if (!file.exists(file)) {
    stop("The file does not exist. Please provide a valid file path.")
  }

  # Read file contents
  lines <- readLines(file)

  # Call the internal function to simulate typing
  .simulate_typing(lines, delay)

  invisible(NULL)
}
