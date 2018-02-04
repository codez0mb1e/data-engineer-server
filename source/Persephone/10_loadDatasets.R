
#! summary: Load datasets

### Import dependecies ----
source("00_common.R")
source("cryptocurrency.functions.R")
source("securities.functions.R")
source("macroeconomics.functions.R")

suppressPackageStartupMessages({
})



### Load datasets ----
# load securities
securities.candles.1D <- securities.loadCandles(securities.Symbols, job.settings$FromTime, job.settings$ToTime)

# load BTCUSD & market stats
coins.btcusd.trades <- cryptocurrency.loadTradesFromMarkets(cryptocurrency.Markets[1:2], cryptocurrency.Symbols, job.settings$FromTime, job.settings$ToTime)
coins.market.stats <- cryptocurrency.loadMarketStats(cryptocurrency.Codes, job.settings$FromTime, job.settings$ToTime)

# load GDPs
economics.GDPs <- macroeconomics.loadGDP(macroeconomics.Countries.GDP, job.settings$FromTime, job.settings$ToTime, job.config$QuandlApiKey)


