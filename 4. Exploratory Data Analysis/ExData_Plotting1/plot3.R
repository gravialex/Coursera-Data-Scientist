dataFile <- "./data/household_power_consumption.txt" 
data <- read.csv(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings="?", quote='\"') 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
 

## Subsetting by data
sub_data <- subset(data, subset=(Date >="2007-02-01" & Date <= "2007-02-02")) 
dateTime <- paste(sub_data$Date, sub_data$Time)
# add DateTime column
sub_data$DateTime <- as.POSIXct(dateTime)
#str(sub_data)

# Set locale to English
Sys.setlocale(category = "LC_ALL", locale = "english")


## Plot 3 
png("plot3.png", width=480, height=480)
plot(sub_data$DateTime, sub_data$Sub_metering_1 , type="l",ylab="Energy sub metering", xlab="") 
lines(sub_data$Sub_metering_2 ~ sub_data$DateTime,col='Red') 
lines(sub_data$Sub_metering_3 ~ sub_data$DateTime,col='Blue') 

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,  
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

dev.off() 



