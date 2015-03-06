# plot1.R
# this script creates the global active power histogram .png file

# before running the script, download the zip file from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# to the same directory as this script, then extract

# load needed packages
library(sqldf)
library(tcltk)

# read in data for 2/1/2007 to 2/2/2007
path <- "./exdata-data-household_power_consumption/household_power_consumption.txt"
data <- read.csv.sql(file = path,  
                      sql = "select * from file where Date = '2/1/2007' or Date = '2/2/2007'", sep = ";") 

# convert date and time columns to date/time data types
#data2$Date <- strptime(data2$Date, "%d-%m-%Y")
data$Date <- as.Date(data$Date, "%m/%d/%Y")
data$Time <- strptime(data$Time,"%H:%M:%S")

# create histogram
with(data, hist(Global_active_power, col = "red", 
                xlab = "Global Active Power (kilowatts)",
                main = "Global Active Power"))
# send to plot1.png
dev.copy(png, "plot1.png")
dev.off()
