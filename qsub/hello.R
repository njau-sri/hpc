hello <- function() {
    # version of R
    print(R.version.string)
    
    # timing matrix multiplication
    ptm <- proc.time()
    n <- 1000
    a <- matrix(runif(n*n),n,n)
    b <- matrix(runif(n*n),n,n)
    c <- matrix(runif(n*n),n,n)
    for (i in 1:100)
        c = a %*% b
    print(proc.time() - ptm)
}

hello()
