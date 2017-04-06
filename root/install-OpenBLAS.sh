#!/bin/bash

VER=0.2.14

TOP=`pwd`

PREFIX=/share/apps/openblas/$VER

tar zxf OpenBLAS-$VER.tar.gz
cd OpenBLAS-$VER

make -j4 USE_THREAD=1 USE_OPENMP=1 NUM_THREADS=4
make -j4 install PREFIX=$PREFIX

cd $TOP
rm -rf OpenBLAS-$VER
