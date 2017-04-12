#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

BWA=/share/apps/bwakit/0.7.15/bwa

# your code goes here

# index the genome
$BWA index ref.fa

# alignment
$BWA mem ref.fa sample1-1.fa sample1-2.fa > sample1.sam
