#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

CP="/share/apps/b2g4pipe/blast2go.jar:/share/apps/b2g4pipe/ext/*"
BLAST2GO="java -Xmx4g -cp $CP es.blast2go.prog.B2GAnnotPipe"

# your code goes here

$BLAST2GO -in 10_BlastResults_2011.xml -v -annot -dat -img -annex -goslim
