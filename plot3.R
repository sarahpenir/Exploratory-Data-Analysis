## Exploratory Data Analysis - Week 4
## Plot 3

## Of the four types of sources indicated by the type
## (point, nonpoint, onroad, nonroad) variable, which of these four sources
## have seen decreases in emissions from 1999-2008 for Baltimore City?
## Which have seen increases in emissions from 1999-2008?
## Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
library(dplyr)

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips == "24510", select = c("Emissions", "type", "year"))
NEI_baltimore_sources <- NEI_baltimore %>%
  group_by(type, year) %>%
  summarise(`PM2.5 Emission` = sum(Emissions))

# Plot

#png("plot3.png", width=480, height=480, units="px", bg="transparent")

ggplot(data = NEI_baltimore_sources, aes(x = factor(year), y = `PM2.5 Emission`, fill = type)) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ type) +
  labs(x = "Year", y = "PM2.5 Emission (tons)",
       title = "Total PM2.5 Emission According to Source (Baltimore City)",
       fill = "Source") +
  theme(plot.title = element_text(hjust = 0.5, size = 11, face ="bold"))

ggsave("plot3.png", width = 20, height = 12.2, units = "cm", dpi = 100)

dev.off()
