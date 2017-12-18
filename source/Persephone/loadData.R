## dependecies 
suppressPackageStartupMessages({
  library(lubridate)
  library(dplyr)
  library(tidyr)
  library(quantmod)
  library(Quandl)
})



#' 
#'
#' @param market 
BTCUSD.getTicks <- function(market) {
  require(httr)
  require(RCurl)
  require(dplyr)
  # set_config(config(ssl_verifypeer = 0L)) # note: if SSL cert verification failed
  stopifnot(
    is.character(market)
  )
  
  url <- sprintf("http://api.bitcoincharts.com/v1/csv/%sUSD.csv.gz", tolower(market))
  
  dt <- data.frame()
  
  temp <- tempfile()
  try({
    download.file(url, temp)
    dt <- read.table(temp, sep = ",", header = F, stringsAsFactors = F)
  })
  unlink(temp)
  
  if (nrow(dt) == 0)
  {
    stop("Empty dataset")
  } else {
    dt <- dt %>% 
      rename(
        Time = V1,
        Price = V2, 
        Volume = V3
      ) %>% 
      mutate(
        Time = as.POSIXct(Time, origin = "1970-01-01")
      )
  }
  
  
  dt
}



#' 
#'
#' @param fromTime From time (inclusive bound)
#' @param toTime To time (exclusive bound)
#' @param markets Vector of markets
loadTicksFor <- function(markets, fromTime, toTime) {
  require(dplyr)
  require(purrr)
  stopifnot(
    is.vector(markets) & is.character(markets)
  )
  
  dt <- map(markets, 
            ~ BTCUSD.getTicks(.x) %>% mutate(Market = .x))
  
  bind_rows(dt) %>% 
    mutate(Market = factor(Market)) %>% 
    filter(Time >= fromTime & Time < toTime)
}



#' 
#'
#' @param .fromTime 
#' @param .toTime 
BTCUSD.loadCap <- function(.fromTime, .toTime) {
  require(jsonlite)
  require(dplyr)
  
  dt <- tryCatch({
    fromJSON("http://coincap.io/history/BTC", simplifyVector = T)
  },
  error = function(e) {
    fromJSON("app_data/btc.cap.json", simplifyVector = T)
  })
  
  data.frame(
      Time = as.POSIXct(dt$market_cap[, 1]/1000, origin = "1970-01-01"), 
      Value = dt$market_cap[, 2]
    ) %>%
    filter(Time >= .fromTime & Time < .toTime)
}




### Load datasets ----
Quandl.api_key(job.config$QuandlApiKey)


## load BTC/USD datasets
# get cryptocurrency markets w/ largest capitalizations [source: https://coinmarketcap.com/exchanges/volume/24-hour/]
markets <- c("ITBIT", "KRAKEN", "Bitfinex", "HitBTC", "COINBASE", "BITSTAMP", "BTCE")
BTCUSD.ticks <- loadTicksFor(markets, fromTime, toTime) # load bitcoin quotes

# view stats by year
View(
  BTCUSD.ticks %>% 
    mutate(Year = year(Time)) %>% 
    group_by(Market, Year) %>% 
    summarise(
      TotalVolume = sum(Volume)
    ) %>% 
    spread(Market, TotalVolume)
)


## load BTC capitalization 
BTC.cap <- BTCUSD.loadCap(fromTime - days(1), toTime)


## load NVIDIA, NASDAQ, CBOE quotes
symbols <- c("NVDA", "CBOE", "NDAQ")
getSymbols(symbols, src = "yahoo", from = fromTime - days(1), to = toTime)

# draw charts
chartSeries(NVDA["/2017"], TA = c(addVo(), addBBands()))
addMACD() # add Moving Average Convergence Divergence indicator to char



## load macroeconomics metrics
USGDP <- Quandl("FRED/GDP")
CHNGDP <- Quandl("ODA/CHN_NGDPD")

