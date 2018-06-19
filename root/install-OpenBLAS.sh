#!/bin/bash

VERSION=0.3.0

TOP=`pwd`

PREFIX=/share/apps/openblas/$VERSION

tar zxf OpenBLAS-$VERSION.tar.gz
cd OpenBLAS-$VERSION

make -j4 USE_THREAD=1 NUM_THREADS=4 GEMM_MULTITHREADING_THRESHOLD=50 NO_AFFINITY=1
make -j4 install PREFIX=$PREFIX

cd $TOP
rm -rf OpenBLAS-$VERSION
