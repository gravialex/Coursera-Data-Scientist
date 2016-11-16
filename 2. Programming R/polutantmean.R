
data = numeric()

pollutantmean <- function (directory, pollutant, id = 1:332) {
    for (i in id) {
        filename <- paste( directory, "/" , formatC(i, width = 3, flag = "0"), ".csv", sep="")
        filedata <- read.csv(filename)
        data <- c(data , filedata[[pollutant]])
    }
    return(mean(data, na.rm = TRUE))   
}


pollutantmean("specdata", "nitrate", 23)

pollutantmean("specdata", "sulfate", 1:10)

pollutantmean("specdata", "nitrate", 70:72)

