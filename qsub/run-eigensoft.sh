#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

LIBGLS=/share/apps/gsl/2.1/lib

export LD_LIBRARY_PATH=$LIBGLS:$LD_LIBRARY_PATH

CONVERTF="/share/apps/eigensoft/6.0.1/convertf"
SMARTPCA="/share/apps/eigensoft/6.0.1/smartpca"

# your code goes here

$CONVERTF -p par.convertf.ped2eigenstrat
$SMARTPCA -p par.smartpca.pca
