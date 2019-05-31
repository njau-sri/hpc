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

# Documentation - https://github.com/hardingnj/xpclr

# [required] plain vcf file (.vcf)
#    or bgzip-compressed .vcf.gz (use bgzip, NOT gzip)
vcf=snp.vcf

# [required] sub-population file, each sample ID on a line
samplesA=samplesA.txt
samplesB=samplesB.txt

# --map  space delimited file. 6 columns: ID, chromosome, Genetic Distance (Morgan), Position, REF, ALT
map=map.txt

# if map is unavailable, please specify the recombination rate (Morgan) per base , eg. 1000Mb ~ 2500cM
rate=2.5e-8

# other parameters
maxsnps=1000
minsnps=10
size=100000
step=25000

# loop chromosomes

for chr in 1 2
do

if [[ ! -f $map ]]; then

xpclr -C $chr -O $output/$chr -I $vcf -Sa $samplesA -Sb $samplesB \
-R $rate -M $maxsnps -N $minsnps --size $size --step $step

else

xpclr -C $chr -O $output/$chr -I $vcf -Sa $samplesA -Sb $samplesB \
--map $map -M $maxsnps -N $minsnps --size $size --step $step

done
