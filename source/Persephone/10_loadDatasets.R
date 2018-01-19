
#! summary: Load datasets

### Import dependecies ----
source("00_common.R")
source("cryptocurrency.functions.R")
source("securities.functions.R")
source("macroeconomics.functions.R")

suppressPackageStartupMessages({
  library(Quandl)
})



### Load datasets ----
Quandl.api_key(job.config$QuandlApiKey)

# load securities
securities.candles.1D <- securities.getCandles(securities.Symbols, fromTime, toTime)

# load BTCUSD & market stats
coins.btcusd.trades <- cryptocurrency.getTradesFromMarkets(cryptocurrency.Markets[1:2], cryptocurrency.Symbols, fromTime, toTime)
coins.market.stats <- cryptocurrency.getMarketStats(cryptocurrency.Codes, fromTime, toTime)

# load GDPs
economics.GDPs <- macroeconomics.getGDP(macroeconomics.Countries.GDP, fromTime, toTime)


