source("/share/apps/mlmm/emma.R")
source("/share/apps/mlmm/mlmm.R")

run.mlmm <- function(geno.file, pheno.file, kin.file, out.file) {
    X <- t(as.matrix(read.table(geno.file,row.names=1,stringsAsFactors=FALSE)))
    cat("genotype:",dim(X),"\n")

    Y <- as.matrix(read.table(pheno.file,header=TRUE,row.names=1,stringsAsFactors=FALSE))
    cat("phentype:",dim(Y),"\n")

    K <- as.matrix(read.table(kin.file,row.names=1,stringsAsFactors=FALSE))
    cat("kinship:",dim(K),"\n")

    n.phe <- ncol(Y)
    phe.names <- colnames(Y)

    ofs <- file(out.file,"w")

    for (i in 1:n.phe) {
        cat("processing",phe.names[i],"\n")
        res <- mlmm(Y[,i], X, K, 2, 100)
        writeLines(paste(">",phe.names[i],sep=""),ofs)
        writeLines(res$opt_mbonf$cof,ofs)
        writeLines("",ofs)
        flush(ofs)
    }

    close(ofs)
}

main.mlmm <- function() {
    argv <- commandArgs(trailingOnly=TRUE)
    if (length(argv) != 4) {
        cat("usage: Rscript run.mlmm.R geno.file pheno.file kin.file out.file\n")
    } else {
        cat("MLMM started\n")
        run.mlmm(argv[1],argv[2],argv[3],argv[4])
    }
    cat("MLMM finished\n")
}

main.mlmm()
