

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile = "./data/data.csv")

# 1
data<-read.csv("./data/data.csv")

v24 <- subset(data, VAL==24)

nrow(v24)

# 2
fes <- data[["FES"]]
unique(fes)
summary(fes)
table(fes)


# 3 
install.packages("xlsx")
library(xlsx)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(URL, destfile = "./data/FDATA.gov_NGAP.xlsx")
rowIndex <- 18:23
colIndex <- 7:15


# 4
library(XML)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
##download.file(URL, destfile = "./data/Frestaurants.xml")
doc <- xmlTreeParse(URL)
rootNode <- xmlRoot(doc)
names(rootNode)


#5
install.packages("data.table")
library(data.table)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
DT <- fread(input=URL, sep=",")


system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))




