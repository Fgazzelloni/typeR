#' Type and Run R Code with Live Evaluation
#'
#' @description
#' An enhanced version of \code{\link{typeR}} that not only simulates typing but also
#' evaluates R code in real-time.  Supports interactive pause/resume control and handles
#' both Quarto/R Markdown documents and plain R scripts.
#'
#' @param file Character string. Path to an R script (. R), R Markdown (. Rmd), or
#'   Quarto (.qmd) file to type and execute.
#' @param delay Numeric. Base delay in seconds between typing each character.
#'   Default is 0.05 (50 milliseconds).
#' @param jitter Numeric. Standard deviation for random variation in typing speed,
#'   adding natural typing rhythm. Default is 0.01.
#' @param max_print Integer. Maximum number of elements to print for long outputs
#'   (vectors, data frames, matrices, lists). Default is 10.
#' @param envir Environment.  The environment in which to evaluate R code.
#'   Default is a new environment with the global environment as parent.
#'
#' @details
#' \code{typeRun()} extends the basic \code{typeR()} functionality by:
#' \itemize{
#'   \item \strong{Live Code Evaluation: } Executes R code chunks as they are typed
#'   \item \strong{Interactive Control:} Press ESC/Ctrl+C to pause, then choose to resume or stop
#'   \item \strong{Smart Output:} Truncates long outputs and provides summaries for models
#'   \item \strong{Format Support:} Handles .R, .Rmd, and .qmd files intelligently
#' }
#'
#' For Quarto/R Markdown files, \code{typeRun()}:
#' \itemize{
#'   \item Skips YAML headers
#'   \item Only evaluates code in R code chunks
#'   \item Preserves narrative text without evaluation
#' }
#'
#' For R scripts, it evaluates all non-comment, non-empty lines.
#'
#' @section Output Handling:
#' \itemize{
#'   \item Assignments and plotting functions execute silently
#'   \item Long vectors/data frames are truncated to \code{max_print} elements
#'   \item Linear models show a compact summary instead of full output
#'   \item Errors are caught and displayed without stopping execution
#' }
#'
#' @section Interactive Control:
#' During execution, you can:
#' \enumerate{
#'   \item Press \strong{ESC} (or Ctrl+C on some systems) to pause
#'   \item Enter \strong{1} to resume from where you paused
#'   \item Enter \strong{2} to stop completely
#' }
#'
#' @return Invisibly returns \code{NULL}. Called for side effects (typing animation
#'   and code evaluation).
#'
#' @seealso \code{\link{typeR}} for typing without evaluation
#'
#' @examples
#' \dontrun{
#' # Type and run a simple R script
#' typeRun("analysis.R")
#'
#' # Type and run with slower, more dramatic effect
#' typeRun("demo.R", delay = 0.1, jitter = 0.02)
#'
#' # Type and run a Quarto document with limited output
#' typeRun("report.qmd", max_print = 5)
#'
#' # Use a specific environment for evaluation
#' my_env <- new.env()
#' typeRun("script.R", envir = my_env)
#' ls(my_env)  # See what was created
#'
#' # Create a demo file and run it
#' cat("# Simple Demo\nx <- 1:10\nmean(x)\nplot(x)\n", file = "demo.R")
#' typeRun("demo.R")
#' }
#'
#' @export
typeRun <- function(file, delay = 0.05, jitter = 0.01, max_print = 10,
                    envir = new.env(parent = .GlobalEnv)) {
  if (! file.exists(file)) stop("The file does not exist.  Please provide a valid file path.")

  is_quarto <- tolower(tools::file_ext(file)) %in% c("qmd", "rmd")
  lines <- readLines(file, warn = FALSE)

  # State variables
  in_yaml <- in_fence <- fence_is_r <- FALSE
  buffer <- ""
  line_index <- 1
  should_stop <- FALSE

  cat("\ntypeRun press ESC to pause.. .\n\n")

  # Main typing loop with interrupt handling
  type_lines <- function() {
    tryCatch({
      while (line_index <= length(lines) && !should_stop) {
        line <- lines[line_index]
        .simulate_typing(line, delay = delay, jitter = jitter, newline = TRUE)

        if (is_quarto) {
          if (! in_fence && grepl("^\\s*---\\s*$", line)) {
            in_yaml <<- !in_yaml
            if (nzchar(trimws(buffer))) {
              result <- .flush_buffer(buffer, envir, max_print)
              buffer <<- result$buffer
            }
            line_index <<- line_index + 1
            next
          }
          if (in_yaml) { line_index <<- line_index + 1; next }

          if (.grep_text(line)) {
            info <- .extract_text(line)
            if (info$is_opening) {
              in_fence <<- TRUE; fence_is_r <<- isTRUE(info$is_r)
              if (nzchar(trimws(buffer))) {
                result <- .flush_buffer(buffer, envir, max_print)
                buffer <<- result$buffer
              }
              line_index <<- line_index + 1
              next
            }
            if (info$is_closing) {
              if (in_fence && fence_is_r && nzchar(trimws(buffer))) {
                result <- .flush_buffer(buffer, envir, max_print)
                buffer <<- result$buffer
              }
              in_fence <<- fence_is_r <<- FALSE
              line_index <<- line_index + 1
              next
            }
          }

          if (!(in_fence && fence_is_r) || grepl("^\\s*#", line)) {
            line_index <<- line_index + 1
            next
          }
          if (trimws(line) == "") {
            if (nzchar(trimws(buffer))) {
              result <- .flush_buffer(buffer, envir, max_print)
              buffer <<- result$buffer
            }
            buffer <<- ""
            line_index <<- line_index + 1
            next
          }

          buffer <<- paste0(buffer, if (nzchar(buffer)) "\n" else "", line)
          if (isTRUE(.parse_text(buffer, envir, max_print, TRUE))) buffer <<- ""
          line_index <<- line_index + 1
          next
        }

        # Non-Quarto R script processing
        if (grepl("^\\s*#", line) || grepl("^\\s*(['\"]).*\\1\\s*$", line)) {
          line_index <<- line_index + 1
          next
        }
        if (trimws(line) == "") {
          if (nzchar(trimws(buffer))) .parse_text(buffer, envir, max_print, TRUE)
          buffer <<- ""
          line_index <<- line_index + 1
          next
        }

        buffer <<- paste0(buffer, if (nzchar(buffer)) "\n" else "", line)
        if (isTRUE(.parse_text(buffer, envir, max_print, TRUE))) buffer <<- ""
        line_index <<- line_index + 1
      }

      # Check if stopped or completed
      if (should_stop) {
        cat("\ntypeRun stopped by user\n")
        return(invisible(NULL))
      }

      # Final buffer flush
      if (nzchar(trimws(buffer)) && (! is_quarto || (in_fence && fence_is_r)))
        .parse_text(buffer, envir, max_print, TRUE)

      cat("\ntypeRun completed!\n")

    }, interrupt = function(e) {
      choice <- readline(prompt = "Enter choice (1 resume or 2 stop): ")

      if (trimws(choice) == "1") {
        cat("\n.. .\n\n")
        type_lines()  # Resume recursively
      } else {
        should_stop <<- TRUE
        cat("\n... typeRun OFF\n")
      }
    })
  }

  # Start typing
  type_lines()

  invisible(NULL)
}
