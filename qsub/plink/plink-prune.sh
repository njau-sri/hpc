#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

PLINK=/share/apps/plink/plink-1.90b4.3

# your code goes here

$PLINK --vcf geno.vcf --maf 0.05 --indep-pairwise 50 5 0.2

$PLINK --vcf geno.vcf --extract plink.prune.in --recode vcf-iid --out pruned
