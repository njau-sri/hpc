#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

. /share/apps/java/jre/env.sh

TASSEL=/share/apps/tassel/latest


$TASSEL/run_pipeline.pl -Xms512m -Xmx4g -configFile glm-P.xml
