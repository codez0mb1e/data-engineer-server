

#! summary: Macroeconomics functions


#' List of available GDPs
macroeconomics.Countries.GDP <- c("FRED/GDP", "ODA/CHN_NGDPD")
names(macroeconomics.Countries.GDP) <- c("USAGDP", "CHNGDP")



#' Get GDP values
#'
#' @param GDPs 
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#'
#' @return Dataframe w/ GDP values
macroeconomics.getGDP <- function(GDPs, .from, .to) {
  require(purrr)
  require(Quandl)
  stopifnot(
    is.vector(GDPs) && is.character(GDPs),
    is.POSIXt(.from),
    is.POSIXt(.to) && .to > .from
  )
  
  r <- map(GDPs, 
           ~ Quandl(.x, type = "xts")[sprintf("%s/%s", format(.from, "%F"), format(.to, "%F"))])
  
  checkDailyTrades(r, .from, .to)
  
  
  r
}


