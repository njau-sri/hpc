#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

VCFTOOLS=/share/apps/vcftools/0.1.14/bin/vcftools

# your code goes here

$VCFTOOLS --vcf input_file.vcf --remove-indels --min-alleles 2 --max-alleles 2
