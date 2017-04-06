#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

PLINK="/share/apps/plink/1.07/plink --noweb"

# your code goes here
$PLINK --help
