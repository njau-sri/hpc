#!/bin/bash

VER=5.2.3

TOP=`pwd`

PREFIX=/share/apps/local

tar zxf xz-$VER.tar.gz
cd xz-$VER

./configure --prefix=$PREFIX

make
make install

cd $TOP
rm -rf xz-$VER
