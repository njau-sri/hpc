#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export OMP_NUM_THREADS=4

EXE=/share/apps/rtm-gwas/1.5.1/rtm-gwas-assoc

# your code goes here

$EXE --openmp --vcf snpldb.vcf --pheno pheno.txt --covar gsc.evec --alpha 0.01 --rsq 0.95 --out assoc.out
