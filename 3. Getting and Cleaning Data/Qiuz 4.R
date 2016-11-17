URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile = "./data/FdataFss06.csv")

fdata<-read.csv("./data/FdataFss06.csv")

list <-strsplit(names(fdata),split="wgtp")
list[[123]]

## 2
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(URL, destfile = "./data/FdataFGDP.csv")

fdata<-read.csv("./data/FdataFGDP.csv",skip=4, nrows=190)
head(fdata)
names(fdata)
cleanedData <- gsub(",","",fdata$X.4)
cleanedData <- (as.numeric(cleanedData,na.rm = TRUE))
mean(cleanedData,na.rm = TRUE)

## 3
countryNames <- fdata$X.3
grep("^United",countryNames)
countryNames [grep("^United",countryNames)]
summary(grepl("^United",countryNames))

## 4
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(URL, destfile = "./data/FGDP.csv")
fdata<-read.csv("./data/FGDP.csv",skip=4, nrows=190)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(URL, destfile = "./data/FEDSTATS_Country.csv")
educationaldata <-read.csv("./data/FEDSTATS_Country.csv")

head(educationaldata)
names(educationaldata)

mergedData <- merge(fdata,educationaldata,by.x="X", by.y="CountryCode")
fy.june <- grep('Fiscal year end: June', mergedData$Special.Notes)
length(fy.june)

## 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
##

library(TTR)
library(quantmod)

year2012 <- grepl('2012-*', sampleTimes)
sampleTimes2012 <- subset(sampleTimes, year2012)
day <- format(sampleTimes2012, '%A')
table(day)
table(year2012)
