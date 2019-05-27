#!/bin/bash

## QSUB OPTIONS
#$ -cwd
#$ -j y
#$ -S /bin/bash
#$ -l mem_free=4G

## BSUB OPTIONS
#BSUB -n 4
#BSUB -e %J.err
#BSUB -o %J.out

export OMP_NUM_THREADS=4

export PATH=/share/apps/rtm-gwas/latest:$PATH

# your code goes here

rtm-gwas-snpldb --openmp --vcf snp.vcf --maxlen 100000 --maf 0.01 --out snpldb.out
