## Each functions starts with the importation of data into variables.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate emission data for Baltimore City
baltimorePM <- NEI[NEI$fips=="24510",]
totals <- aggregate(Emissions ~ year, baltimorePM, sum)


## We have to plot 4 different source types to see which of the 4 decreased from 1999-2008
## We'll have to use ggplot2 in order to represent this data best.
library(ggplot2)
plot <- ggplot(baltimorePM,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE) +
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y=expression("Total PM 2.5 Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(plot)

## Save as PNG
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()