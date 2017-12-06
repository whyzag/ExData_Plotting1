
#download file
library("reshape2")
library("lubridate")
#find the directory you are in
path <- getwd()

#download the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "projectexplore.zip")

#complete absolute path to file
unzip(paste0(path, "/projectexplore.zip"))
explore_data <-read.table(paste0(path, "/household_power_consumption.txt"),
                                 sep=";", 
                                 header=TRUE, 
                                 stringsAsFactors=FALSE,
                                 na.strings="?")

explore_data$Date <- as.Date(explore_data$Date, format="%d/%m/%Y")
key_data <- subset(explore_data, Date > "2007-01-31" & Date < "2007-02-03")

png(file=paste0(path, "/Plot1.png"), width=480, height=480)
hist(as.numeric(key_data$Global_active_power), 
     col="red", ylim=c(0,1200), 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")
dev.off()
