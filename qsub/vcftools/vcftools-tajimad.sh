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

$VCFTOOLS --vcf geno.vcf --TajimaD 100000
