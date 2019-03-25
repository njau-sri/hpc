#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

JAVAEXE=/share/apps/java/latest/bin/java
FASTQC=/share/apps/fastqc/v0.11.8/fastqc

# your code goes here

$FASTQC --java $JAVAEXE a.fq
