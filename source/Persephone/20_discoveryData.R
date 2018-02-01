
#! summary: Discovery datasets


### Import dependecies ----
source("00_common.R")
source("cryptocurrency.functions.R")
source("securities.functions.R")
source("macroeconomics.functions.R")

suppressPackageStartupMessages({

})



### Data preprocessing ----
coins.btcusd.candles.1D <- cryptocurrency.createCandles(coins.btcusd.trades, to.daily)



### Discovery data ----
## print datasets
printData <- function(dt) {
  require(purrr)
  stopifnot(is.list(dt))
  
  print(map(dt, ~ c(head(.x, 5), tail(.x, 5))))
  print(sprintf("%s", names(dt)))
}

printData(coins.btcusd.trades)
printData(coins.market.stats)
printData(economics.GDPs)
printData(securities.candles.1D)


## draw trades plot
drawTradesPlot <- function(dt, filter = "/2017-06") {
  require(quantmod)
  require(xts)
  stopifnot(is.xts(dt), is.character(filter))
  
  chartSeries(dt[filter], TA = c(addVo(), addBBands()))
  addMACD() # add Moving Average Convergence Divergence indicator to char
}

drawTradesPlot(securities.candles.1D$AAPL)
drawTradesPlot(coins.btcusd.candles.1D$ITBIT)



## Calculate market statistics
# returns: return(t) = (price(t) - price(t-1)) / price(t-1)
# logreturns: logreturn(t) = ln(price(t)/price(t-1))
# annualized volatility: sd(logreturns per x days) * sqrt(trading days=365)
# herfindahl: sum of squares of competitor market shares
financeDayCount <- 365
x <- coins.btcusd.candles.1D$ITBIT

periodicity(x)
x.return <- diff(x)/stats::lag(x)
x.logreturn <- diff(log(x))
x.volatility.1d <- rollapply(x.logreturn, 3, sd)*sqrt(financeDayCount/3)
x.volatility.7d <- rollapply(x.logreturn, 7, sd)*sqrt(financeDayCount/7)
x.volatility.30d <- rollapply(x.logreturn, 30, sd)*sqrt(financeDayCount/30)

plot(x.volatility.1d)
View(tail(x.volatility.1d))









