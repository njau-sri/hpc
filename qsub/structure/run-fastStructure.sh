#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export OMP_NUM_THREADS=1

export PYTHONPATH=/share/apps/python/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH=/share/apps/fastStructure/1.0:$PYTHONPATH

PYTHON=/opt/python/bin/python2
STRUCTURE=/share/apps/fastStructure/1.0/structure.py

# your code goes here

$PYTHON $STRUCTURE -K 3 --input=testdata --output=testoutput_simple --full --seed=100
