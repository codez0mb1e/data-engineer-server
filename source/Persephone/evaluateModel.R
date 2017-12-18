

#' 
#'
#' @param .model 
#' @param .actual 
#' @param .predicted 
printReport <- function(.model, .actual, .predicted) {
  require(Metrics)
  require(dplyr)
  stopifnot(
    any(class(model) %in% "mlModel"),
    is.vector(.actual) && is.numeric(.actual),
    is.vector(.predicted) && is.numeric(.predicted),
    length(.predicted) > 0 && length(.predicted) == length(.actual)
  )
  
  
  print(
    head(data.frame(.actual, .predicted) %>% mutate(residuals = .actual - .predicted), 10)
  )
  
  print(.model)
  
  cat(
    sprintf(
      "\nMean Absolute Error: %.2f \nMean Squared Error: %.2f \nMean Squared Log Error: %.4f \nRoot Mean Squared Error: %.2f \nRoot Mean Squared Log Error: %.4f",
      mae(.actual, .predicted),
      mse(.actual, .predicted),
      msle(.actual, .predicted),
      rmse(.actual, .predicted),
      rmsle(.actual, .predicted)
    )
  )
}