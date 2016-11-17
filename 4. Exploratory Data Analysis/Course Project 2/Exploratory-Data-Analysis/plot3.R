## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## create subset for Baltimore City, Maryland (fips == "24510")
BaltimoreNEI  <- NEI[NEI$fips=="24510", ]

library(ggplot2)

## ggplot to .png
png('plot3.png',width=680,height=480) 

g <- ggplot(BaltimoreNEI,aes(factor(year),Emissions,fill=type)) + 
      geom_bar(stat="identity") + 
      guides(fill=FALSE) + 
      facet_grid(.~type,scales = "free",space="free") +  
      labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
      labs(title=expression("Total PM2.5 Emissions From Baltimore City Sources by Type")) 

print(g) 

dev.off() 

