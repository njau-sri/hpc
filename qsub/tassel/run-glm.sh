#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#


export PATH=/share/apps/java/jre/latest/bin:$PATH

PREFIX=/share/apps/tassel/latest


# your code goes here


# genotype file, required
geno_file="geno.vcf"

# phenotype file, required
pheno_file="pheno.txt"

# population structure covariate, GLM-P, GLM-Q, GLM
# chonse ONE between PCA and STRUCTURE Q
covar_pca_file=""
covar_q_file=""


if [[ -f $covar_pca_file ]]; then

    $PREFIX/run_pipeline.pl -Xmx8g \
        -fork1 -importGuess $geno_file \
        -fork2 -importGuess $pheno_file \
        -fork3 -importGuess $covar_pca_file \
        -combine4 -input1 -input2 -input3 -intersect \
        -FixedEffectLMPlugin -endPlugin \
        -export glm_p_result

elif [[ -f $covar_q_file ]]; then

    $PREFIX/run_pipeline.pl -Xmx8g \
        -fork1 -importGuess $geno_file \
        -fork2 -importGuess $pheno_file \
        -fork3 -importGuess $covar_q_file -excludeLastTrait \
        -combine4 -input1 -input2 -input3 -intersect \
        -FixedEffectLMPlugin -endPlugin \
        -export glm_q_result

else

    $PREFIX/run_pipeline.pl -Xmx8g \
        -fork1 -importGuess $geno_file \
        -fork2 -importGuess $pheno_file \
        -combine3 -input1 -input2 -intersect \
        -FixedEffectLMPlugin -endPlugin \
        -export glm_result

fi
