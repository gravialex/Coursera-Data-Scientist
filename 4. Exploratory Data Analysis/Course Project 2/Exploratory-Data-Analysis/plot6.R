## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
vehicles <- grepl("vehicle", NEI_SCC$SCC.Level.Two, ignore.case=TRUE) 
vehiclesSCC <- NEI_SCC[vehicles,]$SCC 
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,] 
 

# Subset the vehicles NEI data to Baltimore's fip 
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",] 
baltimoreVehiclesNEI$city <- "Baltimore City"

# Subset the vehicles NEI data to LA's fip 
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame 
bothNEI <- rbind(baltimoreVehiclesNEI,vehiclesLANEI) 


## ggplot to .png
png('plot6.png',width=680,height=480) 

g <- ggplot(bothNEI,aes( factor(year), Emissions ,fill=city )) + 
      geom_bar(stat="identity",fill="grey",width=0.75) + 
      facet_grid(scales="free", space="free", .~city) +
      labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
      labs(title=expression("Motor Vehicle Source Emissions in Baltimore & LA from 1999-2008")) 

print(g) 

dev.off() 

