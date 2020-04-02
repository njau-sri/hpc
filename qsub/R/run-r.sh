#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

. /share/apps/R/3.6.3/env.sh

# your code goes here

Rscript hello.r
