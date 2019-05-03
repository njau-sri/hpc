#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

PREFIX=/share/apps/R/3.5.3

export OMP_NUM_THREADS=1
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH

# your code goes here

$PREFIX/bin/Rscript hello.R
