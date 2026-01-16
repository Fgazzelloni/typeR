#' Internal Helper: Type Out Lines
#'
#' An internal function that simulates typing out a vector of strings.
#'
#' @param lines A character vector of script lines to simulate typing.
#' @param delay The delay (in seconds) between typing each character (default: 0.05).
#' @keywords internal
.simulate_typing <- function(lines, delay = 0.05) {
  for (line in lines) {
    cat("")
    for (char in strsplit(line, NULL)[[1]]) {
      cat(char)
      Sys.sleep(delay)  # Adjust the delay for typing speed
    }
    cat("\n")
  }
}
