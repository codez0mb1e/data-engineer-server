
## dependecies 
suppressPackageStartupMessages({
  library(lubridate)
  library(config)
})

## params
toTime <- Sys.time()
fromTime <- toTime - years(2)
splitByTime <- toTime - days(7)
  
## load config
job.config <- config::get()