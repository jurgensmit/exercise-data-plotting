#
# Plotting Assignment 1 for Exploratory Data Analysis
#
# Plot 1
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
# note: removed the transparent background which does not render correctly on all viewers
png(filename="plot1.png")

# plot the histogram
hist(data$global.active.power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

# close the png file
dev.off()