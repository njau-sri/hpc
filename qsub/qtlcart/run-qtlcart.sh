#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

RMAP=/share/apps/qtlcart/Rmap
RCROSS=/share/apps/qtlcart/Rcross
SRMAPQTL=/share/apps/qtlcart/SRmapqtl
ZMAPQTL=/share/apps/qtlcart/Zmapqtl
EQTL=/share/apps/qtlcart/Eqtl

# your code goes here

MAP=rauhmap.inp
CROSS=rauhall.inp

$RMAP -A -i $MAP -f 2

$RCROSS -A -i $CROSS

$SRMAPQTL -A -M 2 -F 0.05 -B 0.05

$ZMAPQTL -A -M 6 -d 1

$ZMAPQTL -A -M 6 -d 1 -r 1000

$EQTL -A -I PZ
