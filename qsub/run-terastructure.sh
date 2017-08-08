#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export LD_LIBRARY_PATH=/share/apps/gsl/LATEST/lib:$LD_LIBRARY_PATH
TERASTRUCTURE=/share/apps/TeraStructure/1.0/terastructure

# your code goes here

for k in $(seq 2 5)
do
    for r in $(seq 3)
    do
        $TERASTRUCTURE -file hapmap_r23a.bed -n 270 -l 4098136 -k $k -rfreq 25000 -nthreads 4 -label r${r}
    done
done
