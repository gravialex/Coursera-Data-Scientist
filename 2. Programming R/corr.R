

corr <- function (directory, threshold = 0) {
    df = complete(directory)
    ids = df[df["nobs"] > threshold, ]$id
    correl = numeric()
    
    for (i in ids) {
        filename <- paste( directory, "/" , formatC(i, width = 3, flag = "0"), ".csv", sep="")
        filedata <- read.csv(filename)
        dff = filedata[complete.cases(filedata), ]
        correl = c(correl, cor(dff$sulfate, dff$nitrate))
    }
    return(correl)
}


cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
summary(cr)


cr <- corr("specdata")
summary(cr)
length(cr)