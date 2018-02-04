# Set global options
options(max.print = 1000, scipen = 999, width = 100)



#' Install packages if its not installed yet
#' @param x A character vector of installing packages
#' @return The result of installation
packages.install <- function(x) {
  stopifnot(is.vector(x), is.character(x))
  
  packages.missing <- x[!(x %in% installed.packages()[, 1])]
  if (length(packages.missing) != 0)
  {
    install.packages(packages.missing)
    print(paste("Successfully installed packages:", 
                paste(packages.missing, collapse = ", ")))
  } else {
    print("All packages have already installed")
  }
}



#' Check daily trades
#'
#' @param dt Trades aggregated by day
#' @param .from 
#' @param .to 
#' @param uniqueIndex 
checkDailyTrades <- function(dt, .from, .to, uniqueIndex = T) {
  require(lubridate)
  require(purrr)
  require(xts)
  stopifnot(
    is.list(dt),
    is.POSIXt(.from),
    is.POSIXt(.to) && .to > .from
  )

  stopifnot(
    every(dt, ~ is.xts(.x) && (!uniqueIndex | is.index.unique(.x))),
    every(dt, ~ length(.x) > 0),
    every(dt, ~ length(.x[sprintf("/%s", format(.from - days(1), "%F"))]) == 0),
    every(dt, ~ length(.x[sprintf("%s/", format(.to + days(1), "%F"))]) == 0)
  )
}


