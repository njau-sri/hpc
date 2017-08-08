#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

FASTPHASE=/share/apps/fastphase/fastPHASE-1.4

# your code goes here

$FASTPHASE -otest test.inp
