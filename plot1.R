# plot1.R
# this script creates the global active power histogram .png file

# before running the script, download the zip file from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# to the same directory as this script, then extract
# ensure the directory in which the script and the data is stored is set as the working directory


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

# create histogram
png("plot1.png")
with(data, hist(Global_active_power, col = "red", 
                xlab = "Global Active Power (kilowatts)",
                main = "Global Active Power"))
# send to plot1.png
#dev.copy(png, "plot1.png")
dev.off()
