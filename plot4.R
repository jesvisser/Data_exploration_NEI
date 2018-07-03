# Please set your working directory and load these libraries
getwd()
dir()
library(dplyr)
library(ggplot2)


# Read the two files with the National Emissions Inventory data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


#Data preparations
NEI_coal_combustion_related_sources <- NEI %>%
  left_join(SCC, by = "SCC") %>%
  filter(grepl("Coal", EI.Sector)) %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# (use the base plotting system)
png(filename = "plot4.png")

dev.off()
