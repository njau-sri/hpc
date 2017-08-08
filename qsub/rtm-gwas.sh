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

RTM_GWAS=/share/apps/rtm-gwas/default/rtm-gwas

# your code goes here

$RTM_GWAS gsc --vcf geno.vcf --out out

$RTM_GWAS assoc --geno geno.vcf --pheno pheno.txt --covar out.evec.txt --out out --alpha 0.01
