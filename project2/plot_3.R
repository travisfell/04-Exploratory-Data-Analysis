# This script assumes this file has been downloaded and extracted 
# to the exdata-data-NEI_data subdirectory in the same working directory:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(dplyr)
library(ggplot2)

nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds") 

# disable scientific notation
options(scipen=999)

# group by type, year and summarize emissions
typeByYear <- summarise(group_by(filter(nei, fips == 24510), type, year), TotalEmissions = sum(Emissions))

#plot results
png("plot3.png")
qplot(year, TotalEmissions, 
      data = typeByYear,
      color = type,
      geom = "line",
      main = "Only Point Source Increased for Baltimore, MD",
      ylab = "Total PM2.5 Emissions (Tons)")
dev.off()