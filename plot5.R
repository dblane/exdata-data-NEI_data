## Each functions starts with the importation of data into variables.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Here we subset the data for vehicles from the SCC and NEI data sets in Baltimore
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,] 
baltimoreVehicles <- vehiclesNEI[vehiclesNEI$fips==24510,]


## Plot using ggplot2
library(ggplot2)
plot <- ggplot(baltimoreVehicles,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM 2.5 Emission (10^5 Tons)")) + 
        labs(title=expression("PM 2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(plot)

## Save as PNG
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()