## Using sqldf package
library(sqldf)

## Set Working Directory
setwd("C:/Users/Shin/Documents/R")

## load the data
dataframe <- read.table("household_power_consumption.txt", header = T,sep = ";", na.strings = "?")

## Converting the date column into date
dataframe$Date <- as.Date(dataframe$Date, format = "%d/%m/%Y")

## Converting the date column into character so the sqldf can read it as a date...whattt
dataframe$Date <- as.character(dataframe$Date)

## using sqldf query to filter the data only to specified dates
data <- sqldf("select dataframe.Global_active_power,dataframe.Sub_metering_1,dataframe.Sub_metering_2,dataframe.Sub_metering_3,dataframe.Voltage,dataframe.Global_reactive_power,dataframe.Date || ' ' || dataframe.Time as Datetime from dataframe where dataframe.Date between '2007-02-01' and '2007-02-02'")

## Converting the Datetime column to POSIXct class
data$Datetime <- as.POSIXct(data$Datetime)

## Setting Graphical Parameters
par(mfrow=c(2,2))
## Plotting the data 1
plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Plotting the data 2
plot(data$Datetime, data$Voltage, type = "l", xlab="datetime", ylab="Voltage")

## Plotting the data 3

plot(data$Datetime, data$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")
lines(data$Datetime, data$Sub_metering_2, col = "Red")
lines(data$Datetime, data$Sub_metering_3, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plotting the data 4
plot(data$Datetime, data$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
	   
## Saving to png file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

