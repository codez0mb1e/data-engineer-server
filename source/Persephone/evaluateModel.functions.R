

#! summary: Evaluate model functions



#' Score model perfomance metrics
#'
#' @param .actual Vector of actual values
#' @param .predicted Vector of predicted values
#' @param .index Vector of indexes
#' 
#' @return List of resudals and metrics
#' @example model.scoreMetrics(rnorm(100, mean = 10), rnorm(100, mean = 10))
model.scoreMetrics <- function(.actual, .predicted, .index) {
  require(dplyr)
  require(purrr)
  require(Metrics)
  stopifnot(
    is.vector(.actual) && is.numeric(.actual),
    is.vector(.predicted) && is.numeric(.predicted),
    length(.predicted) > 0 && length(.predicted) == length(.actual),
    is_vector(.index) && length(.index) == length(.actual)
  )
  
  
  # calc residuals
  dt <- data.frame(
    Time = .index, 
    Actual = .actual, 
    Prediced = .predicted, 
    Residuals = .actual - .predicted
  )
  
  print(tail(dt, 5))
  
  
  # calc metrics
  m <- c(
    mae(.actual, .predicted),
    mse(.actual, .predicted),
    msle(.actual, .predicted),
    rmse(.actual, .predicted),
    rmsle(.actual, .predicted)
  )
  names(m) <- c("MAE", "MSE", "MSLE", "RMSE", "RMSLE")
  
  write(
    sprintf(
      "\nMean Absolute Error: %.2f \nMean Squared Error: %.2f \nMean Squared Log Error: %.4f \nRoot Mean Squared Error: %.2f \nRoot Mean Squared Log Error: %.4f\n",
      m[["MAE"]], m[["MSE"]], m[["MSLE"]], m[["RMSE"]], m[["RMSLE"]]
    ),
    stdout()
  )
  
  
  # return result
  list("Data" = residuals, "Metrics" = m)
}


