# Internal helper functions specific to typeRun()
# These are NOT exported and should not be used directly by users

#' Determine if expression output should be skipped
#' @noRd
#' @keywords internal
.skip_output <- function(expr, in_chunk) {
  is_call <- inherits(expr, "call")
  fun <- if (is_call) as.character(expr[[1]]) else ""
  plotting_funs <- c(
    "plot", "hist", "boxplot", "pairs", "curve", "lines", "points", "barplot",
    "image", "contour", "qqnorm", "qqline", "qqplot", "abline", "rug", "segments",
    "arrows", "text", "title", "legend", "par", "layout", "ggplot", "qplot", "print"
  )
  is_call && (identical(expr[[1]], as.name("<-")) || fun %in% plotting_funs)
}

#' Print truncated output for long objects
#' @noRd
#' @keywords internal
.print_truncated <- function(val, max_print = 10) {
  if (inherits(val, "lm") && !inherits(val, "summary.lm")) {
    cat("<lm model fitted>\n")
    return(invisible(NULL))
  }

  if (inherits(val, "summary.lm")) {
    cat("Model Summary (truncated):\n")
    print(coef(val))
    cat(sprintf("R-squared:  %.4f\n", val$r.squared))
    return(invisible(NULL))
  }

  trunc_msg <- function(msg) { cat(msg, "\n"); invisible(NULL) }

  if (is.matrix(val)) {
    print(val[1:min(nrow(val), max_print), 1:min(ncol(val), max_print), drop = FALSE])
    if (nrow(val) > max_print || ncol(val) > max_print)
      return(trunc_msg(sprintf("... [matrix %d x %d truncated]", nrow(val), ncol(val))))
  } else if (is.data.frame(val)) {
    print(utils::head(val, max_print))
    if (nrow(val) > max_print)
      return(trunc_msg(sprintf("... [data.frame %d rows truncated]", nrow(val))))
  } else if (is.atomic(val) && length(val) > 1) {
    print(utils::head(val, max_print))
    if (length(val) > max_print)
      return(trunc_msg(sprintf("...  [%d elements truncated]", length(val))))
  } else if (is.list(val) && length(val) > 0) {
    print(utils:: head(val, max_print))
    if (length(val) > max_print)
      return(trunc_msg(sprintf("... [%d items truncated]", length(val))))
  } else {
    print(val)
  }
  invisible(NULL)
}

#' Parse and evaluate R code from text buffer
#' @noRd
#' @keywords internal
.parse_text <- function(buffer, envir, max_print, in_chunk) {
  parsed <- try(parse(text = buffer), silent = TRUE)
  if (inherits(parsed, "try-error")) return(FALSE)

  plotting_funs <- c(
    "plot", "hist", "boxplot", "pairs", "curve", "lines", "points", "barplot",
    "image", "contour", "qqnorm", "qqline", "qqplot", "abline", "rug", "segments",
    "arrows", "text", "title", "legend", "par", "layout", "ggplot", "qplot", "print"
  )

  for (expr in parsed) {
    is_call <- inherits(expr, "call")
    fun <- if (is_call) as.character(expr[[1]]) else ""
    is_plot <- is_call && fun %in% plotting_funs

    if (is_plot || .skip_output(expr, in_chunk)) {
      try(eval(expr, envir = envir), silent = TRUE)
      next
    }

    vis <- try(withVisible(eval(expr, envir = envir)), silent = TRUE)
    if (inherits(vis, "try-error")) {
      cat("Error: ", conditionMessage(attr(vis, "condition")), "\n", sep = "")
      next
    }
    if (isTRUE(vis$visible)) .print_truncated(vis$value, max_print = max_print)
  }
  TRUE
}

#' Detect code fence lines in markdown
#' @noRd
#' @keywords internal
.grep_text <- function(line) {
  grepl("^\\s*```", line)
}

#' Extract fence information from markdown line
#' @noRd
#' @keywords internal
.extract_text <- function(line) {
  x <- trimws(line)
  if (grepl("^```\\s*$", x)) return(list(is_closing = TRUE, is_opening = FALSE, is_r = FALSE))
  if (!grepl("^```", x))    return(list(is_closing = FALSE, is_opening = FALSE, is_r = FALSE))
  is_r <- grepl("^```\\s*\\{\\s*r\\b|^```\\s*r\\b", x, ignore.case = TRUE)
  list(is_closing = FALSE, is_opening = TRUE, is_r = is_r)
}

#' Flush code buffer and evaluate
#' @noRd
#' @keywords internal
.flush_buffer <- function(buffer, envir, max_print) {
  if (!nzchar(trimws(buffer))) return(list(buffer = "", ok = TRUE))
  ok <- .parse_text(buffer, envir, max_print, in_chunk = TRUE)
  list(buffer = if (isTRUE(ok)) "" else buffer, ok = ok)
}
