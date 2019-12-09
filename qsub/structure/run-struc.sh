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

vcf_file=snp.vcf


plink --allow-extra-chr --vcf $vcf_file --indep-pairwise 50 10 0.1
plink --allow-extra-chr --vcf $vcf_file --extract plink.prune.in --recode12 --out pruned


NUMINDS=$(wc -l pruned.ped | cut -d " " -f 1)
NUMLOCI=$(wc -l pruned.map | cut -d " " -f 1)
cut -d " " -f 2,7- pruned.ped > infile


for K in $(seq $MAXPOPS)
do
    for R in $(seq $NUMREPS)
    do
        structure -L $NUMLOCI -N $NUMINDS -K $K -o outfile_K${K}_R${R}
    done
done
