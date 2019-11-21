library(ggplot2)

set.seed(123)
d <- data.frame(y=rnorm(1000))

breaks <- hist(d$y, breaks=30, plot=FALSE)$breaks

p1 <-
ggplot(d, aes(y)) +
geom_histogram(breaks=breaks, color="black", size=0.5, fill=NA, aes(y=100*(..count..)/sum(..count..))) +
scale_x_continuous(expand=expand_scale(mult=c(0,0.01))) +
scale_y_continuous(expand=expand_scale(mult=c(0,0.01))) +
ylab("Percent") +
theme_classic(base_size=10) +
theme(
line = element_line(lineend="square"),
axis.text = element_text(size=rel(0.8), color="black"),
axis.ticks = element_line(color="black")
)

#ggsave("p1.pdf", p1, width=6, height=5, units="cm")
ggsave("p1.tiff", p1, width=6, height=5, units="cm", compression="lzw")
