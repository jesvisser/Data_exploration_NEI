# Please set your working directory and load these libraries
getwd()
dir()
library(dplyr)
library(ggplot2)


# Read the two files with the National Emissions Inventory data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 



#Data preparations
NEI_Baltimore_City <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Use the ggplot2 plotting system to make a plot answer this question.
png(filename = "plot3.png")
NEI_Baltimore_City %>%
  ggplot(aes(year ,total_emissions , col = type))+
  geom_line(size = 1) +
  ggtitle("Emission per source type in Baltimore City, Maryland \nFrom 1999-2008")+
  labs(y="total emissions in tons of PM2.5")
dev.off()
