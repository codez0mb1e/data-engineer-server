
local({
  # check packages repository 
  stopifnot("https://mran.microsoft.com/snapshot/2017-09-01" %in% getOption("repos"))
  
  # packages list
  packages <- c("data.table", "tidyr", "dplyr", "purrr", # data manipulation
                "microbenchmark", "config", "lubridate", "jsonlite", # tools
                "xts", "zoo", "Quandl", "quantmod", # time series and financial analysis
                "ggplot2", # vizualization
                "foreach", "doParallel", # parallel computing
                "Metrics" # machine learning
  )
  
  # install packages
  packages.install(packages)
})


