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

$VCFTOOLS --vcf geno.vcf --site-pi

$VCFTOOLS --vcf geno.vcf --window-pi 100000 --window-pi-step 25000
