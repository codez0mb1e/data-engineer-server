
#'
#' Install R packages
#'


# Execute script: 
#$ Rscript install_packages.R > install_packages.logs



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
  
  packages.missing <- x[!(x %in% installed.packages()[, 1])]
  if (length(packages.missing) != 0)
  {
    install.packages(packages.missing, repos = repos)
    print(paste("Successfully installed packages:", paste(packages.missing, collapse = ", ")))
  } else {
    print("All packages have already installed")
  }
}



local({
  # packages list
  packages <- c("data.table", "dplyr", "purrr", "tidyr", # data transform
                "microbenchmark", "config", "curl", "RCurl", "httr", "devtools", "reticulate", "roxygen2", # tools
                "scales", "stringr", "lubridate", # data processing
                "ggplot2", # vizualization
                "zoo", "xts", "Quandl", # time-series and finacial
                "foreach", "doParallel", # parallel computing
                "PRROC", "caret", "keras" # ML algos
  )
  
  # install packages
  # for install CRAN version package
  # packages.install("lubridate", "https://cran.r-project.org/")
  # for install MRAN version package
  packages.install(packages) 
})
