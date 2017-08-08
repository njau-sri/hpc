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

$VCFTOOLS --vcf geno.vcf --weir-fst-pop pop1.txt --weir-fst-pop pop2.txt --out pop1.pop2.loc

$VCFTOOLS --vcf geno.vcf --weir-fst-pop pop1.txt --weir-fst-pop pop2.txt --out pop1.pop2.win \
    --fst-window-size 100000 --fst-window-step 25000
