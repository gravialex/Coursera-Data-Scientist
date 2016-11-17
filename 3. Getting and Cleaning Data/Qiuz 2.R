install.packages("httpuv")
library(httpuv)
if (!require("devtools")) install.packages("devtools")
devtools::install_github("rstudio/httpuv")

library(httr) 
oauth_endpoints("github") 

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.

myapp <- oauth_app("github", key="43e20eb91a1056b92219", secret="94649669c2f3a1f12c9a748dd8acdd0f83927687")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)


##########  2 Question 
install.packages("sqldf") 
library(sqldf) 

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
data<-read.csv(URL)    
acs <- data
str(acs)
# select the probability weights pwgtp1 with ages less than 50
sqldf("select pwgtp1 from acs where AGEP < 50")


##########  3 Question
sqldf("select distinct AGEP from acs") 
length(unique(acs$AGEP)) 


##########  4 Question
hurl <- "http://biostat.jhsph.edu/~jleek/contact.html" 
con <- url(hurl) 
htmlCode <- readLines(con) 
close(con) 

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

##########  5 Question
# read fixed width format
q5 <- read.fwf(file = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", 
               skip = 4, 
               widths = c(12, 7,4, 9,4, 9,4, 9,4))

# find the sum of forth column
head(q5)
sum(q5[, 4])


