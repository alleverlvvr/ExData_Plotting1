## Loading package in RStudio.
library(sqldf)
library(datasets)

## Selecting data ranging from date 01/02/2007 to 02/02/2007
householdpower <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep=";", header=TRUE)
closeAllConnections() ## Closing connections

## Changing date and time columns from character to POSIXct type and combining them into one
datetime <- as.POSIXct(paste(householdpower$Date, householdpower$Time),format = "%d/%m/%Y %H:%M:%S")
householdpower <- cbind(datetime, householdpower) ## Combining datetime column into householdpower data frame
## Saving image as PNG to avoid truncation
png("plot3.png", width=480, height=480)

## Plotting
plot(householdpower$datetime, householdpower$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(householdpower$datetime, householdpower$Sub_metering_2, col="red")
lines(householdpower$datetime, householdpower$Sub_metering_3, col="blue")
legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() ## Closing