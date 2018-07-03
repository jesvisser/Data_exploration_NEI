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
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California. 
# Which city has seen greater changes over time in motor vehicle emissions?


# Data preparations
motor_vehicle_sources <- unique(grep("Vehicle", SCC$EI.Sector, value = TRUE))

NEI_vehicle_Baltimore_LA <- NEI %>%
  filter(fips == "24510" | fips=="06037") %>%
  mutate(US.County = ifelse(fips=="24510", "Baltimore City, Maryland",
                            ifelse(fips=="06037", "Los Angeles County, California", "Other"))) %>%
  filter(EI.Sector %in% motor_vehicle_sources) %>%
  group_by(year, US.County) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Using the ggplot2 plotting system to answer this question.
png(filename = "plot6.png")
NEI_vehicle_Baltimore_LA %>%
  ggplot(aes(year,total_emissions, col = US.County))+
  geom_line(size = 1) +
  ggtitle("Emissions from vehicle sources from 1999-2008 \nBaltimore City, Maryland and Los Angeles County, California")+
  labs(y="total emissions in tons of PM2.5")
dev.off()
