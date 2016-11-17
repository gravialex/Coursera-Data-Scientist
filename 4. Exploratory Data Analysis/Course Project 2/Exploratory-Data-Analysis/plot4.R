## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge the two data sets  
NEI_SCC <- merge(NEI, SCC, by="SCC") 

head(NEI_SCC)

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?  
# fetch all NEIxSCC records with Short.Name (SCC) Coal 
coalMatches  <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE) 
subsetNEISCC <- NEI_SCC[coalMatches, ] 
aggTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum) 



## ggplot to .png
png('plot4.png',width=680,height=480) 

g <- ggplot(aggTotalByYear,aes( factor(year), Emissions/10^3 , fill=year )) + 
      geom_bar(stat="identity") + 
      labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Kilo Tons)")) +  
      labs(title=expression("Total PM2.5 Emissions From coal")) 

print(g) 

dev.off() 

