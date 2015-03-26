# plot4.R
# This script answers the question:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

# This script assumes this file has been downloaded and extracted 
# to the exdata-data-NEI_data subdirectory in the same working directory:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(dplyr)
library(ggplot2)

nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds") 
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# disable scientific notation
options(scipen=999)

# set filtering variable to 
sccCoal <- scc[grep("Coal", scc$Short.Name),]

# merge data
neiCoal <- merge(nei, sccCoal, by.x = "SCC", by.y = "SCC")

# group by type, year and summarize emissions
coalByYear <- summarise(group_by(neiCoal, year), TotalEmissions = sum(Emissions))

#plot results
png("plot4.png")
qplot(year, TotalEmissions, 
      data = coalByYear,
      geom = "line",
      main = "Nationwide PM2.5 Emissions from Coal Decreasing",
      ylab = "Total PM2.5 Emissions (Tons)")
dev.off()
