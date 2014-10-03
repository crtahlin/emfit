library(jsonlite)

importEmfitJSON <- function(filename, timezone) {
  dataAll <- fromJSON(filename)
  
  calc_data <- as.data.frame(dataAll[["calc_data"]])
  colnames(calc_data) <- c("timestamp","heart_rate","heart_rate_quality","breathing_rate", "breathing_rate_quality","activity")
  
  calc_data[,"timestamp"] <- as.POSIXct(origin="1970-01-01", tz="GMT", x=calc_data[,"timestamp"])
  head(calc_data)
  # transform times to local format (e.g. Ljubljana timezone)
  calc_data[,"timestamp"] <- as.POSIXct(format(calc_data[,"timestamp"], tz=timezone))
  
  return(calc_data)
  
}