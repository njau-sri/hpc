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

rtm-gwas-gsc --openmp --vcf snpldb.vcf --out gsc.out
