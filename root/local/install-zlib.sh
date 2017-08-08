#!/bin/bash

VER=1.2.11

TOP=`pwd`

PREFIX=/share/apps/local

tar zxf zlib-$VER.tar.gz
cd zlib-$VER

./configure --prefix=$PREFIX

make
make install

cd $TOP
rm -rf zlib-$VER
