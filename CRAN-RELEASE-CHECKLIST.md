# CRAN-RELEASE-CHECKLIST

## Pre-submission Steps

### 1. Update version number

Update `Version:` in DESCRIPTION

Follow semantic versioning (Major.Minor.Patch)

### 2. Update documentation

Update NEWS.md with changes

Update cran-comments.md

Run `devtools::document()`

### 3. Run checks

``` r
# Local check
devtools::check()

# Windows
devtools::check_win_devel()
devtools::check_win_release()

# Multiple platforms
rhub::rhub_check()

# Spell check
spelling::spell_check_package()
spelling::update_wordlist()

# URL check
urlchecker::url_check()
```

### 4. Build and submit

``` r
# Build package
devtools::build()

# Submit to CRAN
devtools::release()
```

### 5. Post-acceptance

``` r
# Tag release
usethis::use_github_release()
```
