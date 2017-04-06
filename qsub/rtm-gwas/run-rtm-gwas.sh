#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1

RTM_GWAS="/share/apps/rtm-gwas/1.1/rtm-gwas"

# your code goes here

GENO="genofile"
PHENO="phenofile"
COVAR=""

if [ -z $COVAR ]; then
    COVAR="eigvec.txt"
    $RTM_GWAS eigen --geno $GENO --top 10 --out $COVAR
fi

$RTM_GWAS assoc --geno $GENO --pheno $PHENO --covar $COVAR --out output.txt --out-fit output-fit.txt \
--method stepwise --beta 0.05 --alpha 0.05 --multtest bonf
