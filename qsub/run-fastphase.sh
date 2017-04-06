#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

FASTPHASE="/share/apps/fastphase/1.4.0/fastPHASE"

# your code goes here

#   usage: fastPHASE [options] <input-file>
#   -o<text>    prefix for output files ("fastphase")

$FASTPHASE -otest test.inp
