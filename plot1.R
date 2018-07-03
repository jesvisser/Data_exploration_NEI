# Please set your working directory and load these libraries
getwd()
dir()
library(dplyr)


# Read the two files with the National Emissions Inventory data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?


#Data preparations
NEI_totals <- NEI %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# (use the base plotting system)
png(filename = "plot1.png")
with(NEI_totals, plot(year, 
                      total_emissions, 
                      type = "l", 
                      main = "Decrease in total emissions in US", 
                      ylab = "total emissions in tons of PM2.5"))
dev.off()
