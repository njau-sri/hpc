library(ggplot2)

# CHR, BP, P
d <- read.table("data.txt", header=TRUE)

# chromosome color
col <- c("gray10", "gray60")

# genome-wide threshold line
threshold <- -log10(0.05/nrow(d))

d <- d[order(d$CHR,d$BP),]
d$logp <- -log10(d$P)

chrid <- unique(d$CHR)
d$idx <- rep.int(seq_along(chrid), times=tapply(d$BP,d$CHR,length))
d$pos <- NA

last <- 0
for (i in unique(d$idx)) {
    w <- d$idx == i
    d[w,]$BP <- d[w,]$BP - min(d[w,]$BP) + 1
    if (i == 1) {
        d[w,]$pos <- d[w,]$BP
    } else {
        last <- last + max(d[d$idx==(i-1),]$BP)
        d[w,]$pos <- d[w,]$BP + last
    }
}

x.ticks <- tapply(d$pos, d$idx, function(x) sum(range(x))/2)
y.ticks <- pretty(c(d$logp,threshold))
y.max <- ceiling(max(max(d$logp),threshold))

col <- rep(col, length.out=length(chrid))

p1 <-
ggplot(d, aes(pos,logp)) +
geom_point(size=0.5, aes(color=factor(idx)), show.legend=FALSE) +
geom_hline(yintercept=threshold, color="red") +
scale_x_continuous(breaks=x.ticks, labels=chrid, expand=expand_scale(mult=c(0.01,0.01))) +
scale_y_continuous(breaks=y.ticks, limits=c(0,y.max), expand=expand_scale(mult=c(0,0.01))) +
expand_limits(x=0, y=0) +
scale_color_manual(values=col) +
xlab("Chromosome") +
ylab(expression(-log[10](italic(p)))) +
theme_classic(base_size=10) +
theme(
line = element_line(lineend="square"),
axis.text = element_text(size=rel(0.8), color="black"),
axis.ticks = element_line(color="black")
)

p <- d$P
tmp <- data.frame(
    o = -log10(sort(p,decreasing=FALSE)),
    e = -log10(ppoints(length(p)))
)

p2 <-
ggplot(tmp, aes(e,o)) +
geom_point(size=0.5) +
geom_abline(intercept=0, slope=1, color="red") +
xlab(expression(Expected~~-log[10](italic(p)))) +
ylab(expression(Observed~~-log[10](italic(p)))) +
scale_x_continuous(expand=expand_scale(mult=c(0,0.01))) +
scale_y_continuous(breaks=y.ticks, limits=c(0,y.max), expand=expand_scale(mult=c(0,0.01))) +
theme_classic(base_size=10) +
theme(
line = element_line(lineend="square"),
axis.text = element_text(size=rel(0.8), color="black"),
axis.ticks = element_line(color="black")
)


#ggsave("p1.pdf", p1, width=14, height=5, units="cm")
ggsave("p1.tiff", p1, width=14, height=5, units="cm", compression="lzw")

#ggsave("p2.pdf", p2, width=6, height=5, units="cm")
ggsave("p2.tiff", p2, width=6, height=5, units="cm", compression="lzw")
