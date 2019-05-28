#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

. /share/apps/python/3.7.3/env.sh

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1

# your code goes here

xpclr --out $HOME/xpclr --format vcf --input snp.vcf --samplesA samplesA.txt --samplesB samplesB.txt --map map.txt
