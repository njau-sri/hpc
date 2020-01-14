library(ape)

tr <- read.tree("njtree.nwk")

len <- median(tr$edge.length)

if (len < 0.1) {
    len <- floor(len*100)/100
} else if (len < 1) {
    len <- floor(len*10)/10
} else {
    len <- floor(len)
}

print(len)

# tr$tip.label
# tr <- root(tr, "Struthioniformes")

tiff("tree.tif", width=8, height=8, units="cm", pointsize=10, res=300, compression="lzw")

par(lend=2)

plot(tr, type="un", show.tip.label=FALSE, no.margin=TRUE)

add.scale.bar(length=len)

dev.off()
