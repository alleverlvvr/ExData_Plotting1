## Reading data
dat<-read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.string="?")

## Extracting data from the dates 2007-02-01 and 2007-02-02
data<-dat[with(dat, Date=="1/2/2007"|Date=="2/2/2007"), ]
dateTime <- strptime( paste(data$Date,data$Time), format= "%d/%m/%Y %H:%M:%S") ##Change date, time format

with(data, plot(dateTime, Global_active_power
                , xlab = "", ylab = "Global Active Power (killowatts)", type="l")) 
dev.copy(png, file = "plot 2.png") ## Copying to a PNG file
dev.off() ## Closing