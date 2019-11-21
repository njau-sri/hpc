library(ggplot2)

base_size <- 10

p <-
ggplot(mtcars, aes(wt,mpg)) +
geom_point() +
theme_classic(base_size=base_size)

###

p1 <- p +
theme(
line = element_line(lineend="square"),
axis.text = element_text(size=rel(0.8), color="black"),
axis.ticks = element_line(color="black")
)

#ggsave("p1.pdf", p1, width=6, height=5, units="cm")
ggsave("p1.tiff", p1, width=6, height=5, units="cm", compression="lzw")

###

p2 <- p +
theme(
line = element_line(lineend="square"),
axis.text = element_text(size=rel(0.8), color="black"),
axis.ticks = element_line(color="black"),
axis.ticks.length = unit(-base_size/4,"pt"),
axis.text.x = element_text(margin=margin(t=base_size/2)),
axis.text.y = element_text(margin=margin(r=base_size/2))
)

#ggsave("p2.pdf", p2, width=6, height=5, units="cm")
ggsave("p2.tiff", p2, width=6, height=5, units="cm", compression="lzw")

###

p3 <- p1 +
expand_limits(x=c(0,6),y=c(0,36))

#ggsave("p3.pdf", p3, width=6, height=5, units="cm")
ggsave("p3.tiff", p3, width=6, height=5, units="cm", compression="lzw")

###

p4 <- p3 +
scale_x_continuous(expand=expand_scale(mult=c(0,0.05))) +
scale_y_continuous(expand=expand_scale(mult=c(0,0.05)))

#ggsave("p4.pdf", p4, width=6, height=5, units="cm")
ggsave("p4.tiff", p4, width=6, height=5, units="cm", compression="lzw")
