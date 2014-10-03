#' @title Function to import Emfit JSON data into R dataframe
#' 
#' @description Function imports Emfit JSON data into R dataframe. The data frame contains columns for heart rate,
#' breathing rate, activity, timestamp and information about quality of each measured quantity.
#' 
#' @param filename String containing the path and filename of JSON data file.
#' @param timezone The timezone of recorded data.
#' 
#' @export
importEmfitJSON <- function(filename, timezone) {
  dataAll <- fromJSON(filename)
  
  calc_data <- as.data.frame(dataAll[["calc_data"]])
  colnames(calc_data) <- c("timestamp","heart_rate","heart_rate_quality","breathing_rate", "breathing_rate_quality","activity")
  
  calc_data[,"timestamp"] <- as.POSIXct(origin="1970-01-01", tz="GMT", x=calc_data[,"timestamp"])
  head(calc_data)
  # transform times to local format (Ljubljana)
  calc_data[,"timestamp"] <- as.POSIXct(format(calc_data[,"timestamp"], tz=timezone))
  
  return(calc_data)
  
}
