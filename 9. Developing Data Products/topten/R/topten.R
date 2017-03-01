#` biujgpejmef
#`
#` 2 function
#`
#` @param - param



topten <- function (x,y) {
    p <- ncols(x)
    if(p<10)
        stop("stop message")
    pvalues <- numeric(p)
    for( i  in seq_len(p)) {
        fit<- lm(y ~ x[,i])
        summ <- summary(fit)
        pvalues[i] <- summ$coefficients[2,4]
    }
    ord<-order(pvalues)
    ord<-ord[1:10]
    x10 <- x[,ord]
    fit<-lm(y ~ x10)
    coef(fit)
}

prdeict10 <- function (X , b) {
    X <- cbind(1,X)
    drop(X %*% b)
}

