
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


# params
toTime <- Sys.time()
fromTime <- toTime - years(2)
splitTime <- toTime - days(7)

# load config
job.config <- config::get()