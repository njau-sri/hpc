#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

VCFTOOLS=/share/apps/vcftools/vcftools-0.1.15

# your code goes here

$VCFTOOLS --vcf geno.vcf --remove-indels --min-alleles 2 --max-alleles 2 \
    --maf 0.01 --min-meanDP 3 --max-missing 0.1 --minQ 30 --recode
