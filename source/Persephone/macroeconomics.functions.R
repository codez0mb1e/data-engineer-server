

#! summary: Macroeconomics functions


#' List of available GDPs
macroeconomics.Countries.GDP <- c("FRED/GDP", "ODA/CHN_NGDPD")
names(macroeconomics.Countries.GDP) <- c("USAGDP", "CHNGDP")



#' Load GDPs values
#'
#' @param GDPs 
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' @param apiKey API key
#'
#' @return Dataframe w/ GDP values
macroeconomics.loadGDP <- function(GDPs, .from, .to, apiKey = NULL) {
  require(purrr)
  require(Quandl)
  stopifnot(
    is.vector(GDPs) && is.character(GDPs),
    is.POSIXt(.from),
    is.POSIXt(.to) && .to > .from,
    is.null(apiKey) || is.character(apiKey)
  )
  
  Quandl.api_key(apiKey)
  r <- map(GDPs, 
           ~ Quandl(.x, type = "xts")[sprintf("%s/%s", format(.from, "%F"), format(.to, "%F"))])
  
  checkDailyTrades(r, .from, .to)
  
  
  r
}


