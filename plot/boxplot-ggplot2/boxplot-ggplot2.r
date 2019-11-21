library(ggplot2)

d <- read.table("data.txt", header=TRUE)

dlong <- stack(d)

p1 <-
ggplot(dlong, aes(ind,values)) +
geom_boxplot(outlier.size=1) +
xlab("Treatment") +
ylab("Plant height") +
theme_classic(base_size=10) +
theme(
line = element_line(lineend="square"),
axis.text = element_text(size=rel(0.8), color="black"),
axis.ticks = element_line(color="black")
)

# ggsave("p1.pdf", p1, width=4, height=6, units="cm")
ggsave("p1.tiff", p1, width=4, height=6, units="cm", compression="lzw")
