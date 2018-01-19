

#! summary: Securities functions


#' Available securities
securities.Symbols <- c("AAPL", "MSFT", "NDAQ", "GOOG")
names(securities.Symbols) <- securities.Symbols



#' Get Trades Candles
#'
#' @param symbols Vector of Symbols
#' @param candleType Type of candle (data source support onle 1D candles)
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' 
#' @return List of xts's
securities.getCandles <- function(symbols, .from, .to, candleType = "1D") {
  require(purrr)
  require(quantmod)
  require(lubridate)
  stopifnot(
    is.vector(symbols) && is.character(symbols),
    is.character(candleType) && candleType == "1D"
  )
  
  r <- map(symbols, 
           ~ getSymbols(.x, src = "yahoo", from = .from - days(1), to = .to, auto.assign = F))
  
  checkDailyTrades(r, .from, .to)
  
  
  r
}


  