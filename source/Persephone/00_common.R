
#! summary: job start script


### set enviroment ----
Sys.setenv(R_CONFIG_ACTIVE = "debug")

# set compute context
library(RevoScaleR)
rxSetComputeContext(RxLocalParallel())
rxOptions(reportProgress = 2)

# import dependencies
source("_core.R")
source("_dependencies.R")
suppressPackageStartupMessages({
  library(lubridate)
  library(config)
})


# set params
toTime <- Sys.time()
job.settings <- list(
  FromTime = toTime - years(2), 
  ToTime = toTime,
  SplitBy = toTime - days(7)
  )
rm(toTime)

# load config
job.config <- config::get()