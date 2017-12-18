
### deploy model 
suppressPackageStartupMessages({
  library(RevoScaleR)
  library(mrsdeploy)
  library(config)
  library(microbenchmark)
})


# prepare
predictBitcoinPrice <- function(dt) {
  require(MicrosoftML)
  require(RevoScaleR)
  
  rxPredict(model, dt, writeModelVars = F)
}


# login to remote server
remoteLogin(job.config$RServer$Endpoint,
            username = job.config$RServer$Username,
            password = job.config$RServer$Password,
            session = T)

pause()


# deploy model as service
serviceName <- "BitcoinPricePrediction"
serviceVersion <- "v0.2018"

api <- publishService(
  serviceName,
  v = serviceVersion,
  code = predictBitcoinPrice,
  model = model,
  inputs = list(dt = "data.frame"),
  outputs = list(response = "data.frame")
)

swagger <- api$swagger()
cat(swagger, file = "swagger.json", append = F)


# consume service
proxy <- getService(serviceName, v = serviceVersion)

dt.request <- dt %>% filter(Time >= splitByTime) %>% select(-Time)
microbenchmark({
  req <- dt.request %>% sample_n(1)
  resp <- proxy$consume(req)
  
  print(sprintf("Actual: %.2f. Predicted: %.2f", req$Close1H, resp$outputParameters$response$Score[[1]]))
}, times = 1e2)


# -------------------
# bonus :)
last <- tail(dt, 1)
View(last %>% select(-Close1H))

proxy$consume(last)$outputParameters$response$Score[[1]]
last$Close1H


# GC
deleteService(serviceName, v = serviceVersion)
remoteLogout()

