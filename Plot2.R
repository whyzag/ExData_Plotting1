
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
explore_data <-read.table(paste0(path, "/household_power_consumption.txt"),sep=";", 
                          stringsAsFactors=FALSE,
                          header=TRUE, 
                          na.strings="?")
explore_data$Date <- as.Date(explore_data$Date, format="%d/%m/%Y")
key_data <- subset(explore_data, Date > "2007-01-31" & Date < "2007-02-03")


#create a column with combined date and time
key_data$combinedDate <- paste(key_data$Date, key_data$Time, sep=" ")

key_data$combinedDate <- strptime(key_data$combinedDate, format="%Y-%m-%d %H:%M:%S")

png(file=paste0(path, "/Plot2.png"), width=480, height=480)
plot(key_data$combinedDate, key_data$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=""
     )
dev.off()
