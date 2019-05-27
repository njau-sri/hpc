#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export PATH=/share/apps/java/jre/latest/bin:$PATH

FASTQC=/share/apps/fastqc/v0.11.8/fastqc

# your code goes here

$FASTQC a.fq
