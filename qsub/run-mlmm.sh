#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1

RSCRIPT="/share/apps/R/3.2.3/bin/Rscript"

# your code goes here
$RSCRIPT run.mlmm.R X.txt Y.txt K.txt assoc.mlmm
