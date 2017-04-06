#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

STRUCTURE="/share/apps/structure/2.3.4/structure"

# your code goes here

MAXPOPS=5
NUMREPS=3
INFILE="infile"

for i in $(seq $MAXPOPS)
do
    for j in $(seq $NUMREPS)
    do
        $STRUCTURE -i $INFILE -K $i -o outfile_K${i}_${j}
    done
done
