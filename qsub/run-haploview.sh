#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

HAPLOVIEW="java -jar /share/apps/haploview/4.2/haploview.jar -n"

# your code goes here

CHROM="chr1"

$HAPLOVIEW -memory 2048 -pedfile $CHROM.ped -info $CHROM.info -log $CHROM.log \
-hwcutoff 0 -minMAF 0.01 -maxDistance 500 -blockMAFThresh 0.01 -blockoutput ALL -dprime -check
