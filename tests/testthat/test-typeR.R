test_that("typeR works correctly", {
  temp_file <- tempfile(fileext = ".R")
  writeLines(c(
    "# A simple test script",
    "x <- 1:10",
    "y <- mean(x)",
    "plot(x, y)"
  ), temp_file)

  # Expect output (the specific lines of the script)
  expect_output(typeR(temp_file, delay = 0.01), "# A simple test script")

  unlink(temp_file) # Clean up after the test
})

