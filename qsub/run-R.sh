#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export OMP_NUM_THREADS=1

RSCRIPT="/share/apps/R/3.2.3/bin/Rscript"

# your code goes here

$RSCRIPT hello.R
