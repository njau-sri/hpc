library(compiler)


source("/share/apps/gapit/20180818/emma.txt")
source("/share/apps/gapit/20180818/gapit_functions.txt")


# phenotype data, missing data -> NaN or NA
pheno.file <- "mdp_traits.txt"

# genotype data in HapMap format
geno.file <- "mdp_genotype_test.hmp.txt"


# covariate data, STRUCTURE or PCA or none

# structure file, disable = ""
structure.Q.file <- ""

# number of PCs, disable = 0
my.PCA.total <- 10


# DO NOT EDIT

my.Y <- read.table(pheno.file, header=TRUE)
my.G <- read.table(geno.file, header=FALSE)

my.CV <- NULL
if (structure.Q.file != "")
    my.CV <- read.table(structure.Q.file, header=TRUE)

GAPIT(Y=my.Y, G=my.G, CV=my.CV, model="MLM", PCA.total=my.PCA.total)
