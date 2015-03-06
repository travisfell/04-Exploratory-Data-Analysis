# plot2.R
# this script creates the global active power line graph .png file

# before running the script, download the zip file from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# to the same directory as this script, then extract

# load needed packages
#library(sqldf)
#library(tcltk)

# read in data for 2/1/2007 to 2/2/2007
path <- "./exdata-data-household_power_consumption/household_power_consumption.txt"
data <- read.table(path, header = TRUE, sep = ";", 
                   stringsAsFactors = FALSE)
data <- subset(data, Date == '1/2/2007'|Date == '2/2/2007')
# update columns with numeric values to numeric
data[,3:9] <- sapply(data[,3:9], as.numeric)
# drop row.names column
rownames(data) <- NULL

# create combined Date-Time column
data$DateTime <- paste(data$Date, data$Time, sep = " ")

# convert date-time columns to date/time data types
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S", tz = "GMT")

# create 2 variable line graph
global <- as.numeric(as.character(data$Global_active_power))
daytime <- data$DateTime
with(data, plot(daytime,global,
    type = "l",
    ylab = "Global Active Power (kilowatts)",
    xlab = ""))


# send to plot2.png
dev.copy(png, "plot2.png")
dev.off()
