#!/bin/bash

. /share/apps/python/3.7.3/env.sh

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1

# your code goes here

python3 hello.py
