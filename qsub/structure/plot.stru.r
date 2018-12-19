
Q <- read.table("stru.txt", header=T)

threshold <- 0.45

# color
col <- c("#D2802E", "#D6C92F", "#3AD123", "#239AD1", "#AF23D1", "#D123A4", "#D1234A", "#E79C9C", "#9CC4E7", "#873600")


idx <- NULL
pop <- NULL
kmax <- ncol(Q)

Q1 <- Q
for (k in 1:kmax) {
    ord <- do.call(order, -Q1[,k:kmax,drop=F])
    Q1 <- Q1[ord,]

    if (k != kmax) {
        m <- which(Q1[,k] < threshold)[1]
        Q2 <- Q1[m:nrow(Q1),]
        Q1 <- Q1[1:(m-1),]
    }
    else {
        Q2 <- NULL
    }

    idx <- c(idx, as.integer(rownames(Q1)))
    pop <- c(pop, rep(k,nrow(Q1)))

    Q1 <- Q2
}

Q <- Q[idx,]
Q.col <- NULL

for (i in 1:nrow(Q)) {
    w <- order(-Q[i,])
    k <- pop[i]
    w <- c(w[w==k],w[w!=k])
    Q[i,] <- Q[i,w]
    Q.col <- rbind(Q.col, w)
}


# plot

pdf("plot.stru.pdf", width=16/2.54, height=5/2.54)

par(mar=c(0.5,3,0.5,0.5), xaxs="i", yaxs="i", las=1)

plot.new()
plot.window(xlim=c(0,nrow(Q)), ylim=c(0,1))

x1 <- seq(1, nrow(Q)) - 1
x2 <- seq(1, nrow(Q))

y <- 0
for (i in 1:kmax) {
    y1 <- y
    y2 <- y + Q[,i]
    rect(x1, y1, x2, y2, border=NA, col=col[Q.col[,i]])
    y <- y + Q[,i]
}

axis(2)

dev.off()
