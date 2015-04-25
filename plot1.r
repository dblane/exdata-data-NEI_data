## Each functions starts with the importation of data into variables.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregating the data so our data is lumped together in the right groups.
totals <- aggregate(Emissions ~ year, NEI, sum)

## Using the base plot system, barplot we can see 4 groups of data where the emissions are viewable by year.
barplot(
        (totals$Emissions)/10^6,
        names.arg=totals$year,
        xlab="Year",
        ylab="PM2.5 Emissions",
        main="Totals PM2.5 Emmissions From All Us Sources"
        )
## Save as PNG
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()