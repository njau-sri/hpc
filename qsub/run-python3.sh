#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

PYTHON="/opt/python/bin/python3"

# your code goes here
$PYTHON hello.py
