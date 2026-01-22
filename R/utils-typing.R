# Shared utility functions used across the typeR package
# Internal helper - not exported

#' Simulate typing animation
#'
#' Internal helper used by typeR() and typeRun()
#' @noRd
#' @keywords internal
.simulate_typing <- function(text, delay = 0.05, jitter = 0.9, newline = TRUE) {
  # Accept a single string or a character vector of lines
  if (length(text) == 0) return(invisible(NULL))
  lines <- as.character(text)

  for (line in lines) {
    chars <- strsplit(line, "", fixed = TRUE)[[1]]
    for (ch in chars) {
      cat(ch)
      flush.console()
      Sys.sleep(max(0, delay + stats:: rnorm(1, 0, jitter)))
    }
    if (isTRUE(newline)) cat("\n")
  }
  invisible(NULL)
}
