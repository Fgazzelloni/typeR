#!/usr/bin/env Rscript
# Manual test script for Quarto presentation support
# This script should be run manually to verify the implementation

library(typeR)

cat("Testing Quarto Presentation Support for typeR\n")
cat("==============================================\n\n")

# Test 1: Check that example files exist
cat("Test 1: Checking example files exist...\n")
demo_file <- system.file("examples/demo-presentation.qmd", package = "typeR")
simple_file <- system.file("examples/simple-presentation.qmd", package = "typeR")
readme_file <- system.file("examples/README.md", package = "typeR")

if (file.exists(demo_file)) {
  cat("  ✓ demo-presentation.qmd found\n")
} else {
  cat("  ✗ demo-presentation.qmd NOT FOUND\n")
}

if (file.exists(simple_file)) {
  cat("  ✓ simple-presentation.qmd found\n")
} else {
  cat("  ✗ simple-presentation.qmd NOT FOUND\n")
}

if (file.exists(readme_file)) {
  cat("  ✓ README.md found\n")
} else {
  cat("  ✗ README.md NOT FOUND\n")
}

# Test 2: Verify files are readable
cat("\nTest 2: Verifying files are readable...\n")
tryCatch({
  demo_content <- readLines(demo_file, warn = FALSE)
  cat("  ✓ demo-presentation.qmd is readable (", length(demo_content), "lines)\n", sep = "")
}, error = function(e) {
  cat("  ✗ Error reading demo-presentation.qmd:", e$message, "\n")
})

tryCatch({
  simple_content <- readLines(simple_file, warn = FALSE)
  cat("  ✓ simple-presentation.qmd is readable (", length(simple_content), "lines)\n", sep = "")
}, error = function(e) {
  cat("  ✗ Error reading simple-presentation.qmd:", e$message, "\n")
})

# Test 3: Check that files have proper Quarto YAML
cat("\nTest 3: Checking Quarto YAML headers...\n")
demo_content <- readLines(demo_file, warn = FALSE)
if (any(grepl("format:\\s*$", demo_content)) && any(grepl("revealjs:", demo_content))) {
  cat("  ✓ demo-presentation.qmd has valid Quarto reveal.js format\n")
} else {
  cat("  ✗ demo-presentation.qmd missing proper Quarto format\n")
}

simple_content <- readLines(simple_file, warn = FALSE)
if (any(grepl("format:\\s*$", simple_content)) && any(grepl("revealjs:", simple_content))) {
  cat("  ✓ simple-presentation.qmd has valid Quarto reveal.js format\n")
} else {
  cat("  ✗ simple-presentation.qmd missing proper Quarto format\n")
}

# Test 4: Check that files have R code chunks
cat("\nTest 4: Checking for R code chunks...\n")
if (any(grepl("```\\{r\\}", demo_content))) {
  cat("  ✓ demo-presentation.qmd contains R code chunks\n")
} else {
  cat("  ✗ demo-presentation.qmd missing R code chunks\n")
}

if (any(grepl("```\\{r\\}", simple_content))) {
  cat("  ✓ simple-presentation.qmd contains R code chunks\n")
} else {
  cat("  ✗ simple-presentation.qmd missing R code chunks\n")
}

# Test 5: Try to run typeRun on the simple example (if user wants to test interactively)
cat("\nTest 5: Interactive test (optional)\n")
cat("To manually test typeRun with the simple presentation, run:\n")
cat("  typeRun(system.file('examples/simple-presentation.qmd', package = 'typeR'))\n\n")

cat("\nTest 6: Interactive test (optional)\n")
cat("To manually test typeRun with the demo presentation, run:\n")
cat("  typeRun(system.file('examples/demo-presentation.qmd', package = 'typeR'))\n\n")

cat("==============================================\n")
cat("Basic validation complete!\n")
cat("For full testing, manually run the interactive tests above.\n")
