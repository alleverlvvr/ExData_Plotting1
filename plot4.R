#Loading data
file <- unz("household_power_consumption.zip", "household_power_consumption.txt")
rawdata <- read.table(file, sep=";", header=T, dec=".", nrows=100000)
rawdata <- subset(rawdata, Date == "1/2/2007" | Date == "2/2/2007")
data <- rawdata

#Preprocessing
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$t <- paste(data$Date, data$Time)
data$t <- strptime(data$t, "%m/%e/%Y %H:%M:%S")
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))

## Saving image as PNG to avoid truncation
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

x=seq(as.POSIXct("2007-02-01 00:00:00"),by="min",length.out=24*60*2)
Sys.setlocale("LC_TIME", 'English')
par(lab=c(3, 3, 1))
plot(x, data$Global_active_power, type = "l", ann = FALSE)
title(ylab = "Global Active Power")

par(lab=c(3, 8, 1))
plot(x, data$Voltage, type = "l", ann = FALSE)
title(xlab = "datetime", ylab = "Voltage")

x=seq(as.POSIXct("2007-02-01 00:00:00"),by="min",length.out=24*60*2)
Sys.setlocale("LC_TIME", 'English')
par(lab=c(3, 3, 1))
ylim = range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))
plot(x, data$Sub_metering_1, type = "l", col = "black", ann = FALSE, ylim = ylim)
lines(x, data$Sub_metering_2, type = "l", col = "red", ann = FALSE)
lines(x, data$Sub_metering_3, type = "l", col = "blue", ann = FALSE)
title(ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n")
## Plotting
par(lab=c(3, 6, 1))
plot(x, data$Global_reactive_power, type = "l", ann = FALSE)
title(xlab = "datetime", ylab = "Global_reactive_power")

##closing
dev.off()