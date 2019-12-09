#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#


. /share/apps/java/jre/env.sh

PREFIX=/share/apps/tassel/latest


# your code goes here


# genotype file
geno_file="geno.vcf"

# phenotype file
pheno_file="pheno.txt"


$PREFIX/run_pipeline.pl -Xmx8g \
-fork1 -importGuess $geno_file -fork2 -importGuess $pheno_file \
-combine3 -input1 -input2 -intersect \
-FixedEffectLMPlugin -endPlugin \
-export glm_N_result
