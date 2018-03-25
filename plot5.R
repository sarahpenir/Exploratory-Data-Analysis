## Exploratory Data Analysis - Week 4
## Plot 5

## How have emissions from motor vehicle sources changed
## from 1999-2008 in Baltimore City?

library(ggplot2)
library(dplyr)

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_baltimore_road <- subset(NEI, fips == "24510" & type == "ON-ROAD", select = c("Emissions", "year"))

NEI_baltimore_road_year <- NEI_baltimore_road %>%
  group_by(year) %>%
  summarise(`PM2.5 Emission` = sum(Emissions))

# Plot

ggplot(data = NEI_baltimore_road_year, aes(x = factor(year), y = `PM2.5 Emission`)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "PM2.5 Emission (tons)",
       title = "Total PM2.5 Emission From Motor Vehicle Sources (Baltimore City)") +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face ="bold"))

ggsave("plot5.png", width = 18, height = 12.2, units = "cm", dpi = 100)

dev.off()
