## Exploratory Data Analysis - Week 4
## Plot 1

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission
## from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_yearly <- aggregate(Emissions ~ year, NEI, sum)

# Plot

png("plot1.png", width=480, height=480, units="px", bg="white")

barplot(height = (NEI_yearly$Emissions/1000), names.arg = NEI_yearly$year,
        main="Total PM2.5 Emission (United States)",
        ylab = "PM2.5 Emission (kilotons)", xlab = "Year")

dev.off()
