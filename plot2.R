## Exploratory Data Analysis - Week 4
## Plot 2

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system
## to make a plot answering this question.

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips == "24510", select = c( "Emissions", "year"))
NEI_baltimore_yearly <- aggregate(Emissions ~ year, NEI_baltimore, sum)

# Plot

png("plot2.png", width=480, height=480, units="px", bg = "white")

barplot(height = NEI_baltimore_yearly$Emissions, names.arg = NEI_baltimore_yearly$year,
        main="Total PM2.5 Emission (Baltimore City)",
        ylab = "PM2.5 Emission (tons)", xlab="Year")

dev.off()