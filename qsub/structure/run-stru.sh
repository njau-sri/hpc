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


# your code goes here


MAXPOPS=5
NUMREPS=3


# genotype file in VCF format
vcf_file=snp.vcf


# LD-based SNP pruning
#
# 50   window size in variant count
# 10   step size in variant count
# 0.1  pairwise r^2 threshold
#
plink --allow-extra-chr --vcf $vcf_file --indep-pairwise 50 10 0.1
plink --allow-extra-chr --vcf $vcf_file --extract plink.prune.in --recode12 --out pruned


# prepare STRUCTURE infile
NUMINDS=$(wc -l pruned.ped | cut -d " " -f 1)
NUMLOCI=$(wc -l pruned.map | cut -d " " -f 1)
cut -d " " -f 2,7- pruned.ped > infile


# create output dir
rm -rf seed.txt
mkdir structureoutput


# run STRUCTURE
#
# -L  change the number of loci
# -N  change the number of individuals
# -K  change the number of populations
# -o  write results to a different output file
#
for K in $(seq $MAXPOPS)
do
    for R in $(seq $NUMREPS)
    do
        structure -L $NUMLOCI -N $NUMINDS -K $K -o structureoutput/outfile_K${K}_R${R}
    done
done
