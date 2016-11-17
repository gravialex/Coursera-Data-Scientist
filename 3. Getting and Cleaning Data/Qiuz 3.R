URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile = "./data/idaho.csv")

idaho<-read.csv("./data/idaho.csv")
str(idaho)
head(idaho)
nrow(idaho)


# Create a logical vector that identifies the households on greater than 10 acres  
# who sold more than $10,000 worth of agriculture products. Assign that logical  
# vector to the variable agricultureLogical. Apply the which() function  
# like this to identify the rows of the data frame where the logical vector is TRUE.  
# which(agricultureLogical) What are the first 3 values that result? 
agricultureLogical <- with(idaho, ACR == 3 & AGS ==6)
which(agricultureLogical)[1:3]

### QUESTION 2.
install.packages("jpeg")
library(jpeg)


imgURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg" 
imgFile <- tempfile() 
download.file(imgURL, imgFile, mode = "wb")
 

## Read file 
img <- readJPEG(imgFile, native = TRUE) 
## Get quantiles at 30% and 80% 
quantile(img, probs = c(0.3, 0.8)) 

### QUESTION 3.
gdpURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
eduURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" 
gdpFile <- tempfile() 
eduFile <- tempfile() 
 

download.file(gdpURL, gdpFile) 
download.file(eduURL, eduFile)  

## Read 190 ranked countries 
gdpData <- read.csv(gdpFile, skip = 5, nrows = 190, stringsAsFactors = F, header = F) 
eduData <- read.csv(eduFile, stringsAsFactors = F) 


## Subset only needed data, name columns in gdpData and convert GDP Value to numeric 
gdpData <- gdpData[, c(1, 2, 4, 5)] 
colnames(gdpData) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value") 
gdpData$GDP.Value <- as.numeric(gsub(",", "", gdpData$GDP.Value)) 
 

## Merge data by country codes 
matchedData <- merge(gdpData, eduData, by.x = "CountryCode", by.y = "CountryCode") 
## Number of matched countries 
dim(matchedData)[1] 


## Arrange by GDP rank (descending) and get the name of the 13th country 
library(plyr) 
arrange(matchedData, desc(Rank))[13, 3] 

### QUESTION 4 - 
mean(subset(matchedData, Income.Group %in% "High income: nonOECD", select = c(Rank))$Rank)


breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]
