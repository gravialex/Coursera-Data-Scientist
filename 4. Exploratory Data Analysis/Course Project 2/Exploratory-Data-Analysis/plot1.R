## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## calculate Emissions sum by year
aggTotals <- aggregate(Emissions ~ year,NEI, sum)

## barplot to .png
png('plot1.png') 
barplot( 
    (aggTotals$Emissions)/10^6, 
    names.arg=aggTotals$year, 
    xlab="Year", 
    ylab="PM2.5 Emissions (10^6 Tons)", 
    main="Total PM2.5 Emissions From All US Sources" 
) 
dev.off() 
