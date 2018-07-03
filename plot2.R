# Please set your working directory and load library "dplyr"
getwd()
dir()
library(dplyr)


# Read the two files with the National Emissions Inventory data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland fips=="24510" from 1999 to 2008?


# Data preparations
NEI_Baltimore_City <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Make a plot answering the question
# (use the base plotting system)
png(filename = "plot2.png")
with(NEI_Baltimore_City, plot(year,
                              total_emissions, 
                              type = "l", 
                              main = "Decrease in total emissions in Baltimore City, Maryland", 
                              ylab = "total emissions in tons of PM2.5"))
dev.off()
