library(jsonlite)

importEmfitJSON <- function(filename, timezone) {
  dataAll <- fromJSON(filename)
  
  calc_data <- as.data.frame(dataAll[["calc_data"]])
  colnames(calc_data) <- c("timestamp","heart_rate","activity","breathing_rate", "sleep_phase","activity2")
  
  calc_data[,"timestamp"] <- as.POSIXct(origin="1970-01-01", tz="GMT", x=calc_data[,"timestamp"])
  head(calc_data)
  # transform times to local format (Ljubljana)
  calc_data[,"timestamp"] <- as.POSIXct(format(calc_data[,"timestamp"], tz=timezone))
  
  return(calc_data)
  
}




filename <- "~/Dropbox/DataSets/Emfit/device-10-presence-report-1019.json"
temp <- importEmfitJSON(filename, timezone="Europe/Ljubljana")
head(temp)

library(ggplot2)
plot <- ggplot(data = temp) + geom_point(aes(x=timestamp, y=heart_rate), color="black") + theme_bw()
plot <- plot + geom_point(aes(x=timestamp, y=breathing_rate), color="blue")
plot <- plot + scale_x_datetime() + guide_legend()
plot
attributes(temp)
class(temp[,"timestamp"])
# TODO: reshape the dataset with melt() to have "values" and "groups"
