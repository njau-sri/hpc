#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

BLASTN="/share/apps/ncbi-blast+/2.3.0/blastn"

# your code goes here
$BLASTN -h
