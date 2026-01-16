#' Simulate Typing of an R Script File
#'
#' Simulates typing out the content of an R script file, line by line,
#' character by character, to create an animation effect for live coding
#' presentations or educational demonstrations.
#'
#' @param file Path to the R script file to simulate typing.
#' @param delay The delay (in seconds) between typing each character (default: 0.05).
#' @export
#'
#' @examples
#' # Simulate typing of a script
#' # typeR("example_script.R", delay = 0.1)
typeR <- function(file, delay = 0.05) {
  if (!file.exists(file)) {
    stop("The file does not exist. Please provide a valid file path.")
  }

  # Read file contents
  lines <- readLines(file)

  # Call the internal function to simulate typing
  .simulate_typing(lines, delay)
}

