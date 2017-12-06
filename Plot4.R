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

png(file=paste0(path, "/Plot4.png"), width=480, height=480)
par(mfrow=c(2,2))

plot(key_data$combinedDate, key_data$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=""
)

plot(key_data$combinedDate, key_data$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime"
)


plot(key_data$combinedDate, key_data$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering",
     xlab=""
)
lines(key_data$combinedDate, key_data$Sub_metering_2, type="l", col="red")
lines(key_data$combinedDate, key_data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"), 
       col=c("black", "red", "blue"), 
       lwd=1:3)

plot(key_data$combinedDate, key_data$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime"
)



dev.off()
