
d <- read.table("stru.txt")

maxval <- apply(d, 1, max)
matchval <- max.col(d)
ord <- order(matchval, -maxval)
d <- d[ord,]

barplot(t(d), border=NA, space=0, col=2:7)
