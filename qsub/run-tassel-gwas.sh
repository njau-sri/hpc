#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

TASSEL="/share/apps/tassel/3.0.167/run_pipeline.pl -Xmx4g"

# your code goes here
$TASSEL -configFile tassel-glm-config.xml
$TASSEL -configFile tassel-mlm-config.xml
