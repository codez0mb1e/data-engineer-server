
#'
#' Install R packages
#'



#' Install packages if its not installed yet
#'
#' @param x A character vector of installing packages
#' @param repos A repositories to use
#' @return The result of installation
packages_install <- function(x, repos = getOption("repos")) {
  stopifnot(is.character(x))
  
  packages.missing <- x[!(x %in% installed.packages()[, "Package"])]
  
  if (length(packages.missing) > 0)
  {
    install.packages(packages.missing, repos = repos)
    print(paste("Successfully installed packages:", paste(packages.missing, collapse = ", ")))
  } else {
    print("All packages have already installed.")
  }
}


local({
  # packages list
  packages <- c("odbc", # data retrive
                "data.table", "dplyr", "purrr", "tidyr", "magrittr", # data transform
                "scales", "stringr", "lubridate", # data processing
                "microbenchmark", "testthat", # tests and benchmarks
                "skimr", # descriptive stats
                "ggplot2", "corrplot", "knitr", # vizualization and reports
                "PRROC", "caret", # ML algos
                "tensorflow", "keras", # DL frameworks
                "foreach", "doParallel", # parallel computing
                "config", "curl", "RCurl", "httr", "devtools", "reticulate", "roxygen2", "jsonlite", # tools
                "zoo", "xts", "forecast", "TTR", # time-series
                "Quandl", "quantmod", "quadprog", "tseries", "DEoptim", "PerformanceAnalytics", "PortfolioAnalytics", # finacial
                # "pso", "GenSA", "Rglpk", "ROI", "ROI.plugin.glpk", "ROI.plugin.quadprog", "corpcor" # PortfolioAnalytics dependencies
  )
  
  # view packages repository 
  getOption("repos")
  
  # install packages
  packages_install(packages)
  
  # install Facebook Prophet
  install.packages("prophet", type = "source")
  
  # install H2O Open
  install.packages("h2o", type = "source", repos = "http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")
})


gc()

