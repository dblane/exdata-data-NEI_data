## Each functions starts with the importation of data into variables.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Here we subset the data for vehicles from the SCC and NEI data sets in Baltimore
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
vehiclesbaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesbaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesbaltimoreNEI,vehiclesLANEI)

## Plot using ggplot2
library(ggplot2)

plot <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="year", y=expression("Total PM 2.5 Emission (Kilo-Tons)")) + 
        labs(title=expression("PM 2.5 Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(plot)

## Save as PNG
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()