
### Train model

library(MicrosoftML)
source("evaluateModel.R")


labelField <- "Close1H"
extraVars <- "Time"

stopifnot(
  nrow(grid.all) > 0,
  !anyNA(grid.all)
)

dt <- grid.all %>% 
  select(one_of(c(labelField, extraVars)), starts_with("Close1H"), ends_with("_lag1H"))
  #mutate_at(
  #  vars(starts_with("OpenCloseDiff1H_lag"), starts_with("HighLowDiff1H_lag")),
  #  funs(log(abs(.) + 1))
  #) %>% 
  #mutate_at(
  #  vars(starts_with("Close1H_lag"), starts_with("Volume1H_lag")),
  #  funs(log(.) - log(lag(.)))
  #) %>% 
  #na.omit

View(dt)


formula <- sprintf("%s ~ %s", 
                   labelField, 
                   paste(names(dt %>% select(-one_of(c(labelField, extraVars)))), collapse = " + "))
formula


dt.train <- dt %>% 
  filter(Time < splitByTime) %>% 
  select(-one_of(extraVars))

model <- rxNeuralNet(formula, 
                     dt.train, 
                     type = "regression", 
                     normalize = "no")
summary(model)



## score model
dt.test <- dt %>% filter(Time >= splitByTime) %>% select(-Time)
dt.test <- rxPredict(model, dt.test, writeModelVars = T)


## eval model
printReport(model, dt.test$Close1H, dt.test$Score)

View(
  dt.test %>% transmute(Close1H, Score, Residuals = Close1H - Score)
)



