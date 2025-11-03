# R Frameworks and Libraries

- [Packages Management](#packages-management)
  - [Package Management Frameworks](#package-management-frameworks)
  - [Loading Packages](#loading-packages)
  - [Reproducible Environments](#reproducible-environments)
- [Assertions and Testing](#assertions-and-testing)


## Packages Management

### Package Management Frameworks

- **renv**: A dependency management toolkit for R that helps you create reproducible environments. It allows you to isolate project-specific package libraries.
- **librarian**: A package that simplifies the process of loading and installing R packages, making it easier to manage dependencies.
- **checkpoint**: A package that allows you to install packages from a specific date, ensuring that your project uses the same package versions over time.

### Loading Packages

You can use the `librarian` package to load and install packages easily. Here's an example:

```R
install.packages("librarian")

# Add librarian to default list of packages that load on session start
librarian::lib_startup(librarian, lib = .libPaths()[1], global = F)

# Load and install packages as needed
librarian::shelf(
  dplyr,
  ggplot2,
  tidyr,
  readr
)
``` 

### Reproducible Environments

Use `renv` to manage R package dependencies for your projects. This ensures that your code runs consistently across different systems.

```R
shelf(renv) # or install.packages("renv")

renv::init() # Initialize a new renv environment
renv::snapshot() # Save the current state of your project's R packages
renv::restore() # Restore the project's R packages to the saved state
renv::status() # Check the status of your renv environment
```

## Assertions and Testing

- **checkmate**: A package that provides functions for argument checking and validation, making it easier to ensure that your functions receive the correct types of inputs.
- **ensurer**: A package that allows you to create validation rules for your data, helping you ensure that your data meets specific criteria.
- **validate**: A package for data validation that allows you to define and apply validation rules to your datasets.

```R
librarian::shelf(
  checkmate,
  ensurer,
  validate
)

# Example usage of checkmate
checkmate::assert_numeric(x, lower = 0, upper = 100)
checkmate::assert_character(name, pattern = "^[a-zA-Z]+$")
checkmate::assert_data_frame(df, min.rows = 1)

# Example usage of ensurer
safe_sqrt <- function(x) {
  sqrt(x)
} %>%
  ensures_that(x >= 0, err_desc = "Input must be non-negative") %>%
  ensures_that(. >= 0, err_desc = "Output must be non-negative")

# Example usage of validate
rules <- validator(
  age >= 0,
  income >= 0
)
validation_results <- confront(data, rules)
summary(validation_results)
```
