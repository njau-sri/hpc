#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

MATLAB="/share/apps/matlab/R2012a/bin/matlab -nodisplay -singleCompThread"

# your code goes here
# tips: use addpath to add folders to search path
$MATLAB -r "hello(); exit"
