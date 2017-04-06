#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

CLUSTALW="/opt/bio/clustalw/bin/clustalw2"

# your code goes here

$CLUSTALW -infile=sequence.fasta -align

$CLUSTALW -infile=sequence.aln -tree
