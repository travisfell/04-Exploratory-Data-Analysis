# plot5.R
# This script answers the question:
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# This script assumes this file has been downloaded and extracted 
# to the exdata-data-NEI_data subdirectory in the same working directory:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(dplyr)
library(ggplot2)

nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds") 
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# disable scientific notation
options(scipen=999)

# set filtering variable: EI.Sector starts w/"Mobile", fips = 24510
sccMotor <- scc[grep("^Mobile", scc$EI.Sector),]
neiBalt <- subset(nei, fips == "24510")

# merge data
BaltMotor <- merge(neiBalt, sccMotor, by.x = "SCC", by.y = "SCC")

# group and summarize
BaltMotorChg <- summarise(group_by(BaltMotor, year), TotalEmissions = sum(Emissions))

#plot results
png("plot5.png")
qplot(year, TotalEmissions, 
      data = BaltMotorChg,
      geom = "line",
      main = "Baltimore Motor Vehicle Emissions Trending Down w/Slight 2008 Rise",
      ylab = "Total PM2.5 Emissions (Tons)"
)
dev.off()