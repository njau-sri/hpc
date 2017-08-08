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

$PLINK --vcf geno.vcf --blocks no-pheno-req --blocks-max-kb 200 --blocks-min-maf 0.01
