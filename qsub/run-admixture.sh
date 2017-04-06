#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

PLINK="/share/apps/plink/1.07/plink"
ADMIXTURE="/share/apps/admixture/1.3.0/admixture"

# your code goes here

K_MAX=20
PRUNE=1
GENO="geno"

if [ $PRUNE -ne 0 ]; then
    $PLINK --file $GENO --indep-pairwise 50 10 0.1
    $PLINK --file $GENO --extract plink.prune.in --recode12 --out pruned
    GENO="pruned"
fi

for K in $(seq $K_MAX)
do
    $ADMIXTURE -s 2015 -j4 --cv $GENO.ped $K | tee log$K.txt
done

grep -h CV log*.txt | tee cv.txt
