## Exploratory Data Analysis - Week 4
## Plot 4

## Across the United States, how have emissions from
## coal combustion-related sources changed from 1999-2008?

library(ggplot2)
library(dplyr)

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_SCC <- left_join(NEI, SCC, by = "SCC")

NEI_SCC_coal <- NEI_SCC %>%
  filter(grepl("Fuel Comb.*Coal", EI.Sector))

NEI_SCC_coal_year <- NEI_SCC_coal %>%
  group_by(year) %>%
  summarise(`PM2.5 Emission` = sum(Emissions))

# Plot

ggplot(data = NEI_SCC_coal_year, aes(x = factor(year), y = `PM2.5 Emission`/1000)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "PM2.5 Emission (kilotons)",
       title = "Total PM2.5 Emission From Coal Combustion-related Sources (United States)") +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face ="bold"))

ggsave("plot4.png", width = 18, height = 12.2, units = "cm", dpi = 100)

dev.off()
