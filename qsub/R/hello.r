hello <- function(r=100) {
    # version of R
    print(R.version.string)
    
    # timing matrix multiplication
    ptm <- proc.time()
    n <- 1000
    a <- matrix(runif(n*n),n,n)
    b <- matrix(runif(n*n),n,n)
    c <- matrix(runif(n*n),n,n)
    for (i in 1:r)
        c = a %*% b
    print(proc.time() - ptm)
}

hello()
