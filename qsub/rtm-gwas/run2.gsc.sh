#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export OMP_NUM_THREADS=2

EXE=/share/apps/rtm-gwas/1.5.1/rtm-gwas-gsc

# your code goes here

$EXE --openmp --vcf snpldb.vcf --out gsc.out
