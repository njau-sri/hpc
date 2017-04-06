#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

MEGACC=/share/apps/mega/7/megacc

# your code goes here

$MEGACC -a setting.mao -d alignment.meg -o outFile
