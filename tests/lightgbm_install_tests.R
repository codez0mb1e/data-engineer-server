
#'
#' LightGBM installation test
#'


library(lightgbm)
data(agaricus.train, package = "lightgbm")

train <- agaricus.train
dtrain <- lgb.Dataset(train$data, label = train$label)

model <- lgb.cv(list(objective = "regression", metric = "l2"), 
                dtrain, 
                nfold = 5, 
                min_data = 1, 
                learning_rate = .1, 
                nrounds = 100, 
                early_stopping_rounds = 20,
                verbose = 1)
