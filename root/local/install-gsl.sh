#!/bin/bash

VER=2.3

TOP=`pwd`

tar zxf gsl-$VER.tar.gz
cd gsl-$VER

./configure --prefix=/share/apps/gsl/$VER || exit 1
make || exit 1
make install

cd $TOP
rm -rf gsl-$VER
