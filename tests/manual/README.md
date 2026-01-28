# Manual Tests

This directory contains tests that require manual execution and visual verification.

## test-quarto-presentations.R

Tests the Quarto presentation support implementation.

**To run:**

```r
# Install the package from source
devtools::install()

# Run the test script
source("tests/manual/test-quarto-presentations.R")
```

The script will:
1. Verify that example files are installed correctly
2. Check that Quarto YAML headers are valid
3. Confirm R code chunks are present
4. Provide instructions for interactive testing

**Interactive testing:**

After running the automated checks, manually test the typing effect:

```r
library(typeR)

# Test simple presentation
typeRun(system.file("examples/simple-presentation.qmd", package = "typeR"))

# Test full demo presentation with custom settings
typeRun(
  system.file("examples/demo-presentation.qmd", package = "typeR"),
  delay = 0.08,
  jitter = 0.02,
  max_print = 6
)
```

**What to verify:**
- Code types out character by character
- YAML headers are skipped
- Slide dividers (##) appear
- Only R code chunks execute
- Narrative text types but doesn't execute
- Press ESC to pause, then enter 1 to resume or 2 to stop
