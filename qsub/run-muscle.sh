#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

MUSCLE="/share/apps/muscle/3.8.31/muscle"

# your code goes here

$MUSCLE -in sequence.fasta -out result.fasta
