# ==============================================================================
# typeR Package - Development Setup
# ==============================================================================
# Run once when setting up development environment

# Install development tools
install.packages(c(
  "devtools",
  "usethis",
  "pkgdown",
  "testthat",
  "roxygen2",
  "spelling",
  "urlchecker",
  "desc",
  "fs"
))

# Set up package infrastructure
usethis::use_mit_license()
usethis::use_readme_rmd()
usethis::use_news_md()
usethis::use_testthat()
usethis::use_pkgdown()
usethis::use_github_action("check-standard")
usethis::use_github_action("pkgdown")

# Set up Git
usethis::use_git()
usethis::use_github()

# Build ignore files
usethis::use_build_ignore("dev")
usethis::use_build_ignore("^.*\\.Rproj$")
usethis::use_build_ignore("^\\.Rproj\\.user$")


---

## Build and Check Vignettes

# Build vignettes
devtools::build_vignettes()

# Check they render correctly
devtools::build()

# View locally
browseVignettes("typeR")

# Include in pkgdown site
pkgdown::build_site()

