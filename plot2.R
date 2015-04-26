## Each functions starts with the importation of data into variables.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## We need to aggregate total emissions from Baltimore City based on intructions
baltimorePM <- NEI[NEI$fips=="24510",]
totals <- aggregate(Emissions ~ year, baltimorePM, sum)

## We can use the bar plot from the base plotting system like we did in plot1.r

barplot (
        totals$Emissions,
        names.arg=totals$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From All Baltimore City Sources"
        )

## Save as PNG
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()