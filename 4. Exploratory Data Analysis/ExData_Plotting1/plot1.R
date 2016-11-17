dataFile <- "./data/household_power_consumption.txt" 
data <- read.csv(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings="?", quote='\"') 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

sub_data <- subset(data, subset=(Date >="2007-02-01" & Date <= "2007-02-02")) 

png("plot1.png", width=480, height=480) 
hist(sub_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)") 
dev.off() 


