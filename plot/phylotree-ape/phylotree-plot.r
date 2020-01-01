library(ape)

tr <- read.tree("tree.nwk")

print(summary(tr$edge.length))

# tr$tip.label
# tr <- root(tr, "Struthioniformes")

tiff("tree.tif", width=8, height=8, units="cm", pointsize=10, res=300, compression="lzw")

par(lend=2)

plot(tr, type="un", show.tip.label=FALSE, no.margin=TRUE)

add.scale.bar(length=5)

dev.off()
