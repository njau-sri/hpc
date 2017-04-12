#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

SAMTOOLS=/share/apps/bwakit/0.7.15/samtools

# your code goes here

$SAMTOOLS 
