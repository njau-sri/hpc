#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

. /share/apps/python/3.7.3/env.sh
. /share/apps/htslib/1.9/env.sh

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1

mkdir xpclr-output
output=$(pwd)/xpclr-output

# your code goes here

# vcf file
vcf=snp.vcf.gz

# --map  space delimited file. 6 columns: ID, chromosome, Genetic Distance, Position, REF, ALT
map=map.txt

# sample list file
samplesA=samplesA.txt
samplesB=samplesB.txt

for chr in 1 2
do

xpclr --chr $chr --out $output/$chr --input $vcf --map $map \
--samplesA $samplesA --samplesB $samplesB \
--maxsnps 2000 --minsnps 2 --size 100000 --step 50000

done
