#
# Plotting Assignment 1 for Exploratory Data Analysis
#
# Plot 4
#
# This script expects the unpacked dataset "Electric Power Consumption" which can be downloaded
# from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip to
# be available in a sub folder data with the name household_power_consumption.txt
#

# read the data
data <- read.table("data/household_power_consumption.txt", 
                   sep=";", header=TRUE, na.strings = "?", 
                   colClasses=c(rep("character", 2), rep("numeric", 7)))

# convert the character date and time columns into a real date/time column
data <- within(data, date.time <- as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# remove the now obsolete date and time columns
data <- data[!names(data) %in% c("Date", "Time")]

# clean up the column names
names(data) <- tolower(gsub("_", ".", names(data)))

# only select the data for the dates 2007-02-01 and 2007-02-02
data <- data[!is.na(data$date.time) & 
        data$date.time >= strptime("2007-02-01", "%Y-%m-%d") & 
        data$date.time < strptime("2007-02-03", "%Y-%m-%d"),]

# open a png file to plot to
png(filename="plot4.png", bg="transparent")

# create a grid of 4 graphs
par(mfcol=c(2, 2))

# plot the first graph
plot(data$date.time, data$global.active.power, type="l", xlab="", ylab="Global Active Power")

# plot the second graph
plot(data$date.time, data$sub.metering.1, type="l", xlab="", ylab="Energy sub metering")
lines(data$date.time, data$sub.metering.2, col="red")
lines(data$date.time, data$sub.metering.3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty="solid",
       bty="n")

# plot the third graph
plot(data$date.time, data$voltage, type="l", xlab="datetime", ylab="Voltage")

# plot the fourth graph
plot(data$date.time, data$global.reactive.power, type="l", xlab="datetime", ylab="Global_reactive_power")

# close the png file
dev.off()
