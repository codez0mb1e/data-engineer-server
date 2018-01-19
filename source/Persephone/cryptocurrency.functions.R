

#! summary: Cryptocurrencies functions


#' Available cryptocurrency markets
#' @seealso https://coinmarketcap.com/exchanges/volume/24-hour/
cryptocurrency.Markets <- c("ITBIT", "KRAKEN", "Bitfinex", "HitBTC", "COINBASE", "BITSTAMP", "BTCE")
names(cryptocurrency.Markets) <- cryptocurrency.Markets

#' Available cryptocurrency symbols
cryptocurrency.Symbols <- c("BTCUSD")
names(cryptocurrency.Symbols) <- cryptocurrency.Symbols

#' Available cryptocurrency codes
cryptocurrency.Codes <- c("BTC", "ETH")
names(cryptocurrency.Codes) <- cryptocurrency.Codes



#' Get Bitcoin/Currency pair trades
#'
#' @param market Market
#' @param symbol Symbol (support only BTCUSD)
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' @param dataSource Trades source (support only bitcoincharts API) 
#' 
#' @return Dataframe w/ Bitcoin/Currency pair trades
#' 
#' @example cryptocurrency.getTrades("ITBIT", "BTCUSD", fromTime, toTime)
#' @seealso http://api.bitcoincharts.com/v1/csv
cryptocurrency.getTrades <- function(market, symbol, .from, .to, dataSource = "api.bitcoincharts.com/v1") {
  require(dplyr)
  
  stopifnot(
    is.character(market),
    is.character(dataSource) && dataSource == "api.bitcoincharts.com/v1",
    is.character(symbol) && symbol %in% cryptocurrency.Symbols,
    is.POSIXt(.from),
    is.POSIXt(.to) && .to > .from
  )
  
  
  dt <- data.frame()
  
  temp <- tempfile()
  url <- sprintf("http://%s/csv/%sUSD.csv.gz", dataSource, tolower(market))
  try({
    # set_config(config(ssl_verifypeer = 0L)) # note: if SSL cert verification failed
    download.file(url, temp)
    dt <- read.table(temp, sep = ",", header = F, stringsAsFactors = F)
  })
  unlink(temp)
  

  if (nrow(dt) == 0) {
    stop("Empty dataset")
  } else {
    dt <- dt %>% 
      transmute(
        Time = as.POSIXct(V1, origin = "1970-01-01"),
        Price = V2, 
        Volume = V3
      ) %>% 
      filter(
        Time >= .from & Time < .to
      )
  }
  
  
  merge.xts(
    Price = xts(dt$Price, order.by = dt$Time),
    Volume = xts(dt$Volume, order.by = dt$Time),
    join = "inner"
  )
}



#' Get Bitcoin trades from passed markets
#' 
#' @param markets Vector of markets
#' @param symbol Symbol
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' 
#' @return Dataframe w/ Bitcoin trades
cryptocurrency.getTradesFromMarkets <- function(markets, symbol, .from, .to) {
  require(purrr)
  stopifnot(
    is.vector(markets) & is.character(markets)
  )
  
  r <- map(markets,
           ~ cryptocurrency.getTrades(.x, symbol, .from, .to))
  
  checkDailyTrades(r, .from, .to, uniqueIndex = F)
  
  
  r
}



#' Get market statistics
#'
#' @param symbol Symbol
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' @param dataSource Data source (support only coincap.io/history)
#' 
#' @return Dataframe w/ market statistics
#' @seealso https://github.com/CoinCapDev/CoinCap.io
cryptocurrency.getMarketStatsByCoin <- function(coinCode, .from, .to, dataSource = "coincap.io/history") {
  require(jsonlite)
  require(purrr)
  require(xts)
  
  stopifnot(
    is.character(coinCode),
    is.POSIXt(.from),
    is.POSIXt(.to) && .to > .from,
    is.character(dataSource)
  )

  
  dt <- map(fromJSON(sprintf("http://%s/%s", dataSource, coinCode), simplifyVector = T),
            ~ xts(.x[, 2], order.by = as.POSIXct(.x[, 1]/1000, origin = "1970-01-01")))
  
  merge.xts(
    MarketCapitalization = dt[[1]],
    Price = dt[[2]],
    Volume = dt[[3]]
  )[sprintf("%s/%s", format(.from, "%F"), format(.to, "%F"))]
}



#' Get market statistics
#'
#' @param coinCodes List of coin codes
#' @param .from From time (inclusive bound)
#' @param .to To time (exclusive bound)
#' 
#' @return Dataframe w/ market statistics
#' @example cryptocurrency.getMarketStats(cryptocurrency.Codes, fromTime, toTime)
cryptocurrency.getMarketStats <- function(coinCodes, .from, .to) {
  require(purrr)
  stopifnot(
    is.vector(coinCodes) && is.character(coinCodes)
  )
  
  r <- map(coinCodes,
           ~ cryptocurrency.getMarketStatsByCoin(.x, .from, .to))
  
  checkDailyTrades(r, .from, .to)
  
  
  r
}


