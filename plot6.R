## Exploratory Data Analysis - Week 4
## Plot 6

## Compare emissions from motor vehicle sources in Baltimore City
## with emissions from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time
## in motor vehicle emissions?

library(ggplot2)
library(dplyr)

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_baltimoreLA_road <- subset(NEI, fips %in% c("24510","06037") & type == "ON-ROAD", select = c("fips", "Emissions", "year"))

NEI_baltimoreLA_road_year <- NEI_baltimoreLA_road %>%
  mutate(fips = recode(fips, "06037" = "Los Angeles County", "24510" = "Baltimore City")) %>%
  group_by(fips, year) %>%
  summarise(`PM2.5 Emission` = sum(Emissions)) %>%
  rename(County = fips, Year = year)

# Plot

ggplot(data = NEI_baltimoreLA_road_year, aes(x = factor(Year), y = `PM2.5 Emission`, fill = County)) +
  geom_bar(stat = "identity") +
  facet_grid(County ~ ., scales = "free") +
  labs(x = "Year", y = "PM2.5 Emission (tons)",
       title = "Total PM2.5 Emission From Motor Vehicle Sources (Baltimore City and Los Angeles County)") +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face ="bold"))

ggsave("plot6.png", width = 25, height = 12.2, units = "cm", dpi = 100)

dev.off()
