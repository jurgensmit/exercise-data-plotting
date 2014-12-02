#
# Plotting Assignment 1 for Exploratory Data Analysis
#
# Plot 3
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
png(filename="plot3.png", bg="transparent")

# plot the sub metering 1 data
plot(data$date.time, data$sub.metering.1, type="l", xlab="", ylab="Energy sub metering")

# add the sub metering 2 data
lines(data$date.time, data$sub.metering.2, col="red")

# add the sub metering 3 data
lines(data$date.time, data$sub.metering.3, col="blue")

# add a legend
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty="solid")

# close the png file
dev.off()