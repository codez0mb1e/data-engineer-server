
#'
#' Install R packages
#'



#' Install packages if its not installed yet
#'
#' @param x A character vector of installing packages
#' @param repos A repositories to use
#' 
#' @return The result of installation
#' 
packages_install <- function(x, repos = getOption("repos")) {
  stopifnot(is.character(x))
  
  missing_packages <- x[!(x %in% installed.packages()[, "Package"])]
  
  if (length(missing_packages) > 0)
  {
    install.packages(missing_packages, repos = repos)
    print(paste("Successfully installed packages:", paste(missing_packages, collapse = ", ")))
  } else {
    print("All packages have already installed.")
  }
}


local({
  # packages list
  packages <- c(
    "odbc", # data retrieve
    "data.table", "dplyr", "tidyr", "purrr", "magrittr", # data transform
    "scales", "stringr", "lubridate", # data processing
    "microbenchmark", "tictoc", "testthat", "checkmate", # validates, tests, and benchmarks
    "skimr", "inspectdf", "DataExplorer", # descriptive stats and EDA
    "ggplot2", "ggsci", "corrplot", # visualization
    "knitr", "gt",  # markdown and documentations
    "tensorflow", "keras", # DL frameworks
    "PRROC", "Metrics", # ML metrics
    "foreach", "doParallel", "furrr", # parallel computing
    "config", "curl", "RCurl", "httr", "devtools", "reticulate", "roxygen2", "jsonlite", # tools
    "zoo", "xts", "forecast", "TTR", "tseries", "tsibble", "timetk", # time-series and forecast
    "Quandl", "quantmod", "quadprog", "DEoptim", "PerformanceAnalytics", "PortfolioAnalytics", "tidyquant", # financial
    # PortfolioAnalytics dependencies: "pso", "GenSA", "Rglpk", "ROI", "ROI.plugin.glpk", "ROI.plugin.quadprog", "corpcor" 
    "R6" # OOP
  )
  
  # view packages repository 
  print(getOption("repos"))
  
  # install packages
  packages_install(packages)
  devtools::install_github("r-dbi/odbc")

  # set python version for reticulate 
  reticulate::use_python(python = Sys.which("python3"), required = TRUE)
  reticulate::py_config()
  
  # install Facebook Prophet
  install.packages("prophet", type = "source")
})


gc()
print("Completed.")
