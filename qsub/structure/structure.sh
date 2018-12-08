#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

PLINK=/share/apps/plink/plink-1.90b6.7
STRUCTURE=/share/apps/structure/2.3.4/structure

# your code goes here

VCF=snp.vcf

MAXPOPS=5
NUMREPS=3

$PLINK --vcf $VCF -allow-extra-chr --indep-pairwise 50 10 0.3

$PLINK --vcf $VCF -allow-extra-chr --extract plink.prune.in --recode12 --out pruned
cut -d " " -f 2,7- pruned.ped > infile

NUMINDS=$(wc -l infile | cut -d " " -f 1)
NUMLOCI=$(head -n 1 infile | awk '{print NF}')
NUMLOCI=$(expr $NUMLOCI - 1)
NUMLOCI=$(expr $NUMLOCI / 2)

for i in $(seq $MAXPOPS)
do
    for j in $(seq $NUMREPS)
    do
        $STRUCTURE -i infile -L $NUMLOCI -N $NUMINDS -K $i -o outfile_K${i}_${j}
    done
done
