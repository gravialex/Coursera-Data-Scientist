## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## create subset for Baltimore City, Maryland (fips == "24510")
BaltimoreNEI  <- NEI[NEI$fips=="24510", ]

## calculate Emissions sum by year for Baltimore
aggTotals <- aggregate(Emissions ~ year,BaltimoreNEI, sum)

## barplot to .png
png('plot2.png') 
barplot( 
    aggTotals$Emissions, 
    names.arg=aggTotals$year, 
    xlab="Year", 
    ylab="PM2.5 Emissions (Tons)", 
    main="Total PM2.5 Emissions From Baltimore City Sources" 
) 
dev.off() 
