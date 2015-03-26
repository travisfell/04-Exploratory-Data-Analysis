# This script assumes this file has been downloaded and extracted 
# to the exdata-data-NEI_data subdirectory in the same working directory:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(dplyr)

nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds") 

# disable scientific notation
options(scipen=999)

# group by year and summarize emissions
byYear <- summarise(group_by(filter(nei, fips == 24510), year), TotalEmissions = sum(Emissions))
png("plot2.png")

with(byYear, plot(year,TotalEmissions,
                  type = "l",
                  ylab = "Total PM2.5 Emissions (Tons)",
                  main = "PM2.5 Emissions Baltimore, MD PM2.5 Trending Down"))
dev.off()