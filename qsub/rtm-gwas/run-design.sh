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

DESIGN="/share/apps/rtm-gwas/1.1/rtm-gwas design"

# your code goes here

$DESIGN --geno genofile --effect effectfile --out outfile --out-qam qamfile \
--cross single

# --cross single / three-way / double
# --unit 2.5e-6
