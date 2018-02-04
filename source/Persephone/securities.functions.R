

#! summary: Securities functions


#' Available securities
securities.Symbols <- c(
  "AAPL", "MSFT",  "RHT",
  "INTL", "AMD", "QCOM", "NVDA",
  "NDAQ", "CBOE", "MA", "V", "JPM"
  )
names(securities.Symbols) <- securities.Symbols



#' Load Trades Candles
#'
#' @param symbols Vector of Symbols
#' @param candleType Type of candle (data source support onle 1D candles)
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' @param apiKey API key
#' 
#' @return List of xts's
securities.loadCandles <- function(symbols, .from, .to, candleType = "1D", apiKey = NULL) {
  require(purrr)
  require(quantmod)
  require(lubridate)
  stopifnot(
    is.vector(symbols) && is.character(symbols),
    is.character(candleType) && candleType == "1D"
  )
  
  r <- map(symbols, 
           function(.x) {
             s <- getSymbols(.x, src = "yahoo", from = .from, to = .to, auto.assign = F)
             names(s) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
             
             s
           })
  
  checkDailyTrades(r, .from, .to)
  
  
  r
}


  