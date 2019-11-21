source("colorRamps.R")

col.map <- blue2red(1024)
col.pop <- c("#E41A1C","#377EB8","#4DAF4A","#984EA3","#FF7F00","#FFFF33","#A65628","#F781BF","#999999")

# phenotype data

pheno <- read.table("pheno.txt", header=TRUE)

y <- aggregate(y ~ ind, pheno, mean, na.rm=TRUE)
y <- y[order(y[,2]),]
rownames(y) <- y[,1]
y <- y[,2,drop=FALSE]

y.ticks <- sprintf("%.0f", quantile(y[,1], na.rm=TRUE))

# population

pop <- read.table("pop.txt", header=TRUE)

ord <- match(rownames(y), pop[,1])
pop <- pop[ord,2]

# QTL-allele matrix

qam <- read.table("qam.txt", header=TRUE, check.names=FALSE)
qam <- na.omit(qam)

# extream value
ex <- head(sort(qam[,5]),2)
if (ex[1]/ex[2] > 2) {
    cat("detected extream value", ex, "\n")
    qam[qam[,5]==ex[1],5] <- ex[2]
}
ex <- tail(sort(qam[,5]),2)
if (ex[2]/ex[1] > 2) {
    cat("detected extream value", ex, "\n")
    qam[qam[,5]==ex[2],5] <- ex[1]
}

G <- as.matrix(qam[,6:ncol(qam)])
E <- matrix(qam[,5], nrow(G), ncol(G))
A <- G * E
B <- NULL
loc <- qam[!duplicated(qam[,1]),1]
for (e in loc) {
    w <- which(qam[,1] == e)
    B <- rbind(B, colSums(A[w,]))
}
rownames(B) <- loc
write.csv(B, "qam.gv.csv", quote=FALSE)

# sort row
ord <- order(rowSums(B))
B <- B[ord,]

# sort column
ord <- match(rownames(y), colnames(B))
B <- B[,ord]
write.csv(B, "qam.gv.sort.csv", quote=FALSE)

# adjust color

a <- abs(min(B))
b <- abs(max(B))
if (a != b) {
    if (a > b) {
        k <- round(quantile(1:length(col.map), (a+b)/(2*a)))
        col.map <- col.map[1:k]
    } else {
        k <- round(quantile(1:length(col.map), 1-(a+b)/(2*b)))
        col.map <- col.map[k:length(col.map)]
    }
}

# plot

tiff("qam.tif", width=14, height=10, units="cm", pointsize=10, res=300, compression="lzw")

layout(matrix(c(1,2,3,0),2,2), widths=c(9,1.1), height=c(5,1))

# heatmap

par(mar=c(0.5,2,0.5,0.5), lend=2, cex=1)
image(t(B), col=col.map, axes=FALSE)
title(ylab="QTL", line=0.6)

# accession colorbar

par(mar=c(3,2,0,0.5), lend=2, cex=1)
image(cbind(1:nrow(y)), col=col.pop[c(pop)], axes=FALSE)
axis(1, at=seq(0,1,0.25), labels=y.ticks, lwd=0, lwd.ticks=1, tcl=-0.3, mgp=c(0,0.5,0))
title(xlab="Accession", line=1.5)

# effect colorbar

par(mar=c(0.5,0,0.5,2.5), lend=2, cex=1)
x <- seq(min(B), max(B), length=length(col.map))
image(x=1, y=x, z=t(x), axes=FALSE, col=col.map)
axis(4, las=2, lwd=0, lwd.ticks=1, tcl=0.3, mgp=c(0,0.5,0))

dev.off()

tiff("pop-color.tif", width=4, height=4, units="cm", pointsize=10, res=300, compression="lzw")
par(mar=c(1,1,1,1))
pie(rep(1,length(levels(pop))), labels=levels(pop), col=col.pop, border=NA)
dev.off()
