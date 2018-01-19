
### Features engeneering

suppressPackageStartupMessages({
  library(tidyr)
  library(tidyverse)
  library(dplyr)
})



## build candles
BTCUSD.1H <- BTCUSD.ticks %>% 
  mutate(
    Time = as.POSIXct(floor(as.double(Time) / 3600) * 3600, origin = "1970-01-01")
  ) %>% 
  group_by(Time) %>% 
  summarise(
    Open = first(Price),
    High = max(Price),
    Low = min(Price),
    Close = last(Price),
    Volume = sum(Volume)
  )

BTCUSD.1D <- BTCUSD.ticks %>% 
  filter(year(Time) > 2014) %>% 
  mutate(
    Date = as.Date(Time)
  ) %>% 
  group_by(Date) %>% 
  summarise(
    Open = first(Price),
    High = max(Price),
    Low = min(Price),
    Close = last(Price),
    Volume = sum(Volume)
  )




## create one day grid
grid.1d <- expand.grid(
    Date = as.Date(date(fromTime - days(1)):date(toTime), origin = "1970-01-01")
  ) %>% 
  # BTCUSD candles
  left_join(
    BTCUSD.1D %>% transmute(Date, Close1D = Close, Volume1D = Volume),
    by = "Date"
  ) %>% 
  # markets quotes
  left_join(
    data.frame(Date = index(CBOE), CBOE$CBOE.Adjusted, CBOE$CBOE.Volume), 
    by = "Date"
  ) %>% 
  left_join(
    data.frame(Date = index(NVDA), NVDA$NVDA.Adjusted, NVDA$NVDA.Volume), 
    by = "Date"
  ) %>% 
  left_join(
    data.frame(Date = index(NDAQ),  NDAQ$NDAQ.Adjusted, NDAQ$NDAQ.Volume), 
    by = "Date"
  ) %>% 
  # GDPs
  left_join(
    USGDP %>% rename(USGDP = Value), by = "Date"
  ) %>% 
  left_join(
    CHNGDP %>% rename(CHNGDP = Value), by = "Date"
  ) %>% 
  # market stats
  left_join(
    BTC.cap %>% transmute(BTCCap = Value, Date = date(Time)), by = "Date"
  )

View(grid.1d %>% arrange(desc(Date)))



## create one hours grid
hours <- seq(min(fromTime), max(toTime), 3600)
hours <- as.POSIXct(floor(as.double(hours) / 3600) * 3600, origin = "1970-01-01")

grid.1h <- expand.grid(
    Time = hours
  ) %>%
  left_join(
    BTCUSD.1H %>% 
      transmute(
        Time, 
        Close1H = Close,
        Volume1H = Volume, 
        HighLowDiff1H = High - Low, 
        OpenCloseDiff1H = Close - Open
      ),
    by = "Time"
  )



## cals lags
grid.1d <- grid.1d %>% 
  mutate_if(is.numeric, lag)


lagNames <- names(grid.1h)[-1]
lagVars <- vars(one_of(lagNames))

grid.1h <- grid.1h %>% 
  mutate_at(lagVars, funs("lag1H" = lag(., 1))) %>% 
  mutate_at(lagVars, funs("lag2H" = lag(., 2))) %>% 
  mutate_at(lagVars, funs("lag3H" = lag(., 3))) %>% 
  select(-one_of(lagNames[-1])) %>% 
  na.omit

View(grid.1h %>% select(Time, starts_with("Close1H")))



## join alltogether
grid.all <- grid.1h %>% 
  mutate(TimeKey = format(Time, "%Y%m%d%H")) %>% 
  left_join(
    grid.1d %>% mutate(TimeKey = format(Date, "%Y%m%d%H")), 
    by = "TimeKey")

grid.all <- grid.all %>% 
  fill_(names(grid.all)[-1], .direction = "down") %>% 
  select(-Date, -TimeKey) %>% 
  na.omit


View(grid.all %>% arrange(desc(Time)))



