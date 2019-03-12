#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export PATH=/opt/python/bin:$PATH
export PATH=/share/apps/java/latest/bin:$PATH
export PATH=/share/apps/gatk/4.1.0.0:$PATH

# your code goes here

gatk --version

gatk --list

