#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#


export PATH=/share/apps/java/latest/bin:$PATH

PREFIX=/share/apps/tassel/latest


# your code goes here


# genotype file, required
geno_file="geno.vcf"

# phenotype file, required
pheno_file="pheno.txt"

# kinship file will be computed if not specified
kinship_file=""

# population structure covariate, MLM-PK, MLM-QK, MLM-K
# chonse ONE between PCA and STRUCTURE Q
covar_pca_file=""
covar_q_file=""


if [[ ! -f $kinship_file ]]; then

    kinship_file="kinship_centered_ibs.txt"

    $PREFIX/run_pipeline.pl -Xmx8g \
        -importGuess $geno_file \
        -KinshipPlugin -method Centered_IBS -endPlugin \
        -export $kinship_file -exportType SqrMatrix

fi


if [[ -f $covar_pca_file ]]; then

    $PREFIX/run_pipeline.pl -Xmx8g \
        -fork1 -importGuess $geno_file \
        -fork2 -importGuess $pheno_file \
        -fork3 -importGuess $covar_pca_file \
        -fork4 -importGuess $kinship_file \
        -combine5 -input1 -input2 -input3 -intersect \
        -combine6 -input5 -input4 \
        -mlm -mlmVarCompEst P3D -mlmCompressionLevel None \
        -export mlm_pk_result

elif [[ -f $covar_q_file ]]; then

    $PREFIX/run_pipeline.pl -Xmx8g \
        -fork1 -importGuess $geno_file \
        -fork2 -importGuess $pheno_file \
        -fork3 -importGuess $covar_q_file -excludeLastTrait \
        -fork4 -importGuess $kinship_file \
        -combine5 -input1 -input2 -input3 -intersect \
        -combine6 -input5 -input4 \
        -mlm -mlmVarCompEst P3D -mlmCompressionLevel None \
        -export mlm_qk_result

else

    $PREFIX/run_pipeline.pl -Xmx8g \
        -fork1 -importGuess $geno_file \
        -fork2 -importGuess $pheno_file \
        -fork3 -importGuess $kinship_file \
        -combine4 -input1 -input2 -intersect \
        -combine5 -input4 -input3 \
        -mlm -mlmVarCompEst P3D -mlmCompressionLevel None \
        -export mlm_k_result

fi
