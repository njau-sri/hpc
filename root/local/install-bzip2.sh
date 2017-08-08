#!/bin/bash

VER=1.0.6

TOP=`pwd`

PREFIX=/share/apps/local

tar zxf bzip2-$VER.tar.gz
cd bzip2-$VER

make
make install PREFIX=$PREFIX

cd $TOP
rm -rf R-$VER
