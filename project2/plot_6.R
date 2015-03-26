# plot6.R
# This script answers the question:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# This script assumes this file has been downloaded and extracted 
# to the exdata-data-NEI_data subdirectory in the same working directory:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(dplyr)
library(ggplot2)

nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds") 
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# disable scientific notation
options(scipen=999)

# set filtering variables: EI.Sector starts w/"Mobile", fips = 24510 or 06037
sccMotor <- scc[grep("^Mobile", scc$EI.Sector),]
neiBaltLA <- subset(nei, fips == "24510" | fips == "06037")

# merge data
BaltLAMotor <- merge(neiBaltLA, sccMotor, by.x = "SCC", by.y = "SCC")

# group and summarize
BaltLAMotorChg <- summarise(group_by(BaltLAMotor, fips, year), TotalEmissions = sum(Emissions))

# add column for city name
BaltLAMotorChg <- within(BaltLAMotorChg, {
  City = ifelse(fips == 24510, "Baltimore", "Los Angeles")
})

#plot results
png("plot6.png")
g <- ggplot(BaltLAMotorChg, aes(year, TotalEmissions))
g + geom_line(aes(color=City)) + ggtitle("Los Angeles PM2.5 Emissions Changes More Dramatic Than Baltimore") + labs(y = "Total PM2.5 Emissions (Tons)")
dev.off()
