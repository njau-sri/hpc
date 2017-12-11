#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

TASSEL="/share/apps/tassel/5.2.40/run_pipeline.pl -Xmx8g"

# your code goes here

$TASSEL -fork1 -importGuess geno.vcf -fork2 -importGuess pheno.txt \
    -fork3 -importGuess evec.txt -fork4 -importGuess kinship.txt \
    -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 \
    -mlm -mlmVarCompEst P3D -mlmCompressionLevel None -export mlm_output \
    -runfork1 -runfork2 -runfork3 -runfork4
