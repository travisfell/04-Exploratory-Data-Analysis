# plot4.R
# this script creates the 4 panel plot and .png file

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

# plot line graph
daytime <- data$DateTime
#png("plot4.png")
with(data, plot(daytime, Sub_metering_1, 
                type = "n",
                ylab = "Energy sub metering",
                xlab = "",
                cex=0.5))
with(data, lines(daytime, Sub_metering_1))
with(data, lines(daytime, Sub_metering_2, col = "red"))
with(data, lines(daytime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# send to plot4.png
dev.copy(png, "plot4.png")
dev.off()
