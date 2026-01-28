# typeR Example Files

This directory contains example files for demonstrating the typeR package functionality.

## Quarto Presentations

### demo-presentation.qmd
A comprehensive Quarto reveal.js presentation demonstrating various R coding scenarios:
- Data analysis
- Visualization
- Statistical modeling
- Data manipulation

**Usage:**
```r
library(typeR)

# Type and execute the presentation code
typeRun(system.file("examples/demo-presentation.qmd", package = "typeR"))

# Or with custom settings
typeRun(
  system.file("examples/demo-presentation.qmd", package = "typeR"),
  delay = 0.08,
  jitter = 0.02,
  max_print = 6
)
```

### simple-presentation.qmd
A minimal Quarto reveal.js presentation for quick demonstrations.

**Usage:**
```r
library(typeR)
typeRun(system.file("examples/simple-presentation.qmd", package = "typeR"))
```

## How It Works

When you use `typeRun()` with a Quarto presentation file:

1. **YAML headers are skipped** - Quarto metadata doesn't interfere
2. **Slide dividers are typed** - Markdown formatting is preserved
3. **Only R code chunks execute** - Narrative text types but doesn't run
4. **Interactive control** - Press ESC to pause during typing

## Tips for Live Presentations

- **Adjust speed**: Use `delay = 0.08` for slower, more readable typing
- **Add variation**: Use `jitter = 0.02` for natural typing rhythm
- **Control output**: Set `max_print = 5` to avoid long output scrolling
- **Practice first**: Run through your demo before the actual presentation
- **Use ESC**: Pause anytime to answer questions, then resume

## Creating Your Own Presentation

1. Create a Quarto presentation file (`.qmd`)
2. Use reveal.js format: `format: revealjs`
3. Add R code chunks as normal
4. Use `typeRun("your-presentation.qmd")` to demonstrate live

The typing effect makes it appear as if you're coding live, perfect for:
- Teaching R programming
- Conference presentations
- Tutorial videos
- Workshops and bootcamps
