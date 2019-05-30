source("emma.r")

xy <- read.csv("xy.csv")
K <- read.csv("k.csv",header=FALSE)

stopifnot(ncol(xy) > 1)
stopifnot(diff(dim(K)) == 0)
stopifnot(nrow(xy) == nrow(K))

n <- nrow(xy)
m <- ncol(xy) - 1

X <- as.matrix(xy[-ncol(xy)])
X[X==0] <- -1
X <- cbind(intercept=1, X)
y <- as.matrix(xy[ncol(xy)])
K <- as.matrix(K)

eq <- paste(colnames(X), collapse=' + ')
eq <- paste("0 + ", eq, sep="")
eq <- paste(colnames(y), eq, sep=" ~ ")

cat("***************\n")
cat("* Linear Model\n")
cat("***************\n")
d <- as.data.frame(cbind(X,y))
fit <- lm(as.formula(eq), data=d)
print(summary(fit))
print(anova(fit))

cat("\n\n")

cat("*********************\n")
cat("* Linear Mixed Model\n")
cat("*********************\n")

reml <- emma.REMLE(y,X,K)
V <- reml$vg * K + reml$ve * diag(n)

W <- V / reml$ve
W <- backsolve(chol(W), diag(n))
W <- t(W)
X1 <- W %*% X
y1 <- W %*% y

d <- as.data.frame(cbind(X1,y1))
fit <- lm(as.formula(eq), data=d)
print(summary(fit))
print(anova(fit))
