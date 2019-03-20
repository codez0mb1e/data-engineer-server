
#'
#' Install R packages
#'


# Execute script: 
#$ Rscript install_packages.R > logs/install_r_packages.logs


#' Install packages if its not installed yet
#'
#' @param x A character vector of installing packages
#' @param repos A repositories to use
#' @return The result of installation
packages.install <- function(x, repos = getOption("repos")) {
  stopifnot(
    is.character(x),
    is.character(repos) && 
      ("https://mran.microsoft.com/snapshot/2018-08-01" %in% repos | "https://cran.r-project.org/" %in% repos)
  )
  
  packages.missing <- x[!(x %in% installed.packages()[, "Package"])]
  if (length(packages.missing))
  {
    install.packages(packages.missing, repos = repos)
    print(paste("Successfully installed packages:", paste(packages.missing, collapse = ", ")))
  } else {
    print("All packages have already installed")
  }
}


local({
  # packages list
  packages <- c("odbc", # data retrive
                "data.table", "dplyr", "purrr", "tidyr", "reshape2", # data transform
                "scales", "stringr", "lubridate", # data processing
                "recipes", # feature engineering
                "microbenchmark", "testthat", # tests and benchmarks
                "glimpse", "skimr", # descriptive stats
                "ggplot2", "knitr", # vizualization and reports
                "zoo", "xts", "Quandl", # time-series and finacial
                "foreach", "doParallel", # parallel computing
                "PRROC", "caret", # ML algos
                "config", "curl", "RCurl", "httr", "devtools", "reticulate", "roxygen2" # tools
  )
  
  # install packages
  # for install CRAN version package print:
  # > packages.install("lubridate", "https://cran.r-project.org/")
  # for install MRAN version package
  packages.install(packages) 
})
