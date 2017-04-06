#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=16G
#

PYTHON=/opt/python/bin/python2
NPUTEDIR=/share/apps/npute/v2

export PYTHONPATH=$NPUTEDIR:$PYTHONPATH

# your code goes here

# NPUTE test
## $PYTHON $NPUTEDIR/NPUTE.py -m 1 -r 5:30 -i sample_data.csv -o out_test.csv

# NPUTE impute
$PYTHON $NPUTEDIR/NPUTE.py -m 0 -w 12 -i sample_data.csv -o out_impute.csv
