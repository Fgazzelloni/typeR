#' Simulate Typing of R Scripts
#'
#' Simulates typing out the contents of an R script file, character by character,
#' to create a "typing" animation effect.
#'
#' @param file Path to the R script file to simulate typing.
#' @param delay The delay (in seconds) between typing each character. Default is 0.05 seconds.
#' @export
#'
#' @examples
#' # Simulate typing of a script
#' # typeR("example_script.R", delay = 0.1)
typeR <- function(file, delay = 0.05) {
  # Read the R script file into a vector of lines
  lines <- readLines(file)

  # Function to simulate typing with a delay
  for (line in lines) {
    cat("", sep = "")
    for (char in strsplit(line, NULL)[[1]]) {
      cat(char)
      Sys.sleep(delay)  # Adjust the delay for typing speed
    }
    cat("\n")
  }

}
