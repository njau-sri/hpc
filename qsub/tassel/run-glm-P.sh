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

# population structure covariate, PCA
covar_file="pca.txt"


$PREFIX/run_pipeline.pl -Xmx8g \
-fork1 -importGuess $geno_file -fork2 -importGuess $pheno_file -fork3 -importGuess $covar_file \
-combine4 -input1 -input2 -input3 -intersect \
-FixedEffectLMPlugin -endPlugin \
-export glm_P_result
