#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

EXE=/share/apps/rtm-gwas/1.5.1/rtm-gwas-snpldb

# your code goes here

$EXE --vcf snp.vcf --out snpldb.out
