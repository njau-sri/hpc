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

$PLINK --vcf geno.vcf --allow-extra-chr --maf 0.2 --r2 dprime --ld-window-kb 500 --ld-window-r2 0
