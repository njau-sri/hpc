#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

eval "$(/share/apps/anaconda3/bin/conda shell.bash hook)"

# your code goes here

python --version
