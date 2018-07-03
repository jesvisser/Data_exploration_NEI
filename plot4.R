# Please set your working directory and load these libraries
getwd()
dir()
library(dplyr)
library(ggplot2)


# Read the two files with the National Emissions Inventory data, and join them
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI %>% 
  left_join(SCC, by = "SCC") %>%
  select(-c(10,11,16:20))


# Question:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


#Data preparations
coal_combustion_sources <- unique(grep("Coal", SCC$EI.Sector, value = TRUE))
NEI_coal <- NEI %>%
  filter(EI.Sector %in% coal_combustion_sources) %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions, na.rm = TRUE)) %>%
  ungroup()


# Make a plot showing the total PM2.5 emission from all coal combustion-related sources from 1999–2008
png(filename = "plot4.png")
NEI_coal %>% 
  ggplot(aes(year, total_emissions)) +
  geom_line(size = 1) +
  ggtitle("Total emission in US from all coal combustion-related sources",
          subtitle = "From 1999-2008")+
  labs(y = "total emission in tons of PM2.5")
dev.off()
