# Please set your working directory and load these libraries
getwd()
dir()
library(dplyr)
library(ggplot2)


# Read the two files with the National Emissions Inventory data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI %>% 
  left_join(SCC, by = "SCC") %>%
  select(-c(10,11,16:20))


# Question:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City 


# Data preparations
motor_vehicle_sources <- unique(grep("Vehicle", SCC$EI.Sector, value = TRUE))

NEI_vehicle_Baltimore <- NEI %>%
  filter(fips == "24510") %>%
  filter(EI.Sector %in% motor_vehicle_sources) %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Using the ggplot2 plotting system to answer this question.
png(filename = "plot5.png")
NEI_vehicle_Baltimore %>%
  ggplot(aes(year,total_emissions))+
  geom_line(size = 1) +
  ggtitle("Emissions from vehicle sources in Baltimore City, Maryland \nFrom 1999-2008")+
  labs(y="total emissions in tons of PM2.5")
dev.off()
