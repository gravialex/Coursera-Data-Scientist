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



## Plot 4 
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) 
with(sub_data, { 
    plot(Global_active_power~DateTime, type="l",  ylab="Global Active Power", xlab="") 
    plot(Voltage~DateTime, type="l",  ylab="Voltage", xlab="") 
    plot(Sub_metering_1~DateTime, type="l",  ylab="Energy sub metering", xlab="") 
    lines(Sub_metering_2~DateTime,col='Red') 
    lines(Sub_metering_3~DateTime,col='Blue') 
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
    plot(Global_reactive_power~DateTime, type="l") 
}) 

dev.off() 



