

complete <- function (directory, id = 1:332) {
    data = numeric()
    for (i in id) {
        filename <- paste( directory, "/" , formatC(i, width = 3, flag = "0"), ".csv", sep="")
        filedata <- read.csv(filename)
        data <- c(data , sum(complete.cases(filedata)))
    }
    return(data.frame(id, nobs=data))
  
}



complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)
