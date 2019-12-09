#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#


. /share/apps/plink/env.sh
. /share/apps/structure/env.sh


#####################################
#
# 50   window size in variant count
# 10   step size in variant count
# 0.1  pairwise r^2 threshold
#
#####################################


plink --allow-extra-chr --vcf mdp282_snp.vcf --indep-pairwise 50 10 0.1
plink --allow-extra-chr --vcf mdp282_snp.vcf --extract plink.prune.in --recode vcf-iid
plink --allow-extra-chr --vcf plink.vcf --maf 0.4 --recode vcf-iid
plink --allow-extra-chr --vcf plink.vcf --thin-count 10 --recode12 --out pruned


NUMINDS=$(wc -l pruned.ped | cut -d " " -f 1)
NUMLOCI=$(wc -l pruned.map | cut -d " " -f 1)
cut -d " " -f 2,7- pruned.ped > infile


#################################################
#
# -i  read data from a different input file
# -L  change the number of loci
# -N  change the number of individuals
# -K  change the number of populations
# -o  write results to a different output file
#
#################################################

MAXPOPS=5
NUMREPS=3

for K in $(seq $MAXPOPS)
do
    for R in $(seq $NUMREPS)
    do
        structure -L $NUMLOCI -N $NUMINDS -K $K -o outfile_K${K}_R${R}
    done
done
