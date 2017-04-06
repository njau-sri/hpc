#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

QTLNETWORK="/share/apps/qtlnetwork/20141226/QTLNetwork"

# your code goes here
$QTLNETWORK << _HERE_DOCUMENT_
RiceQTL.Map
RiceQTL.txt
RiceQTL.out
_HERE_DOCUMENT_
