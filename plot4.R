## Each functions starts with the importation of data into variables.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate coal combustion data for US. 
## We are pulling info from Level One and Level Four
comb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalcomb <- (comb & coal)
combSCC <- SCC[coalcomb,]$SCC
combNEI <- NEI[NEI$SCC %in% combSCC,]


## Plot using ggplot2
library(ggplot2)

plot <- ggplot(combNEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM 2.5 Emission (10^5 Tons)")) + 
        labs(title=expression("PM 2.5 Coal Combustion Source Emissions Across US from 1999-2008"))

print(plot)

## Save as PNG
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()