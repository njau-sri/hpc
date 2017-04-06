#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export OMP_NUM_THREADS=4

PLINK="/share/apps/plink/1.07/plink"
EMMAX="/share/apps/emmax/20120210/emmax-intel64"
EMMAXKIN="/share/apps/emmax/20120210/emmax-kin-intel64"

# your code goes here
ped="geno"
tped="geno"
pheno="pheno"
out="emmax_assoc"

# Preparing Input Genotype Files
$PLINK --file $ped --recode12 --output-missing-genotype 0 --transpose --out $tped

# Creating Marker-Based Kinship Matrix
# BN (Balding-Nichols): [tped].aBN.kinf
$EMMAXKIN -v -d 10 $tped
# IBS matrix: [tped].aIBS.kinf
# $EMMAXKIN -v -s -d 10 $tped

# Run EMMAX Association
# [out].reml, [out].ps
$EMMAX -v -d 10 -t $tped -p $pheno -k $tped.aBN.kinf -o $out
