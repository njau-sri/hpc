#!/bin/bash

VER=1.1.0e

TOP=`pwd`

PREFIX=/share/apps/local

tar zxf openssl-$VER.tar.gz
cd openssl-$VER

./config --prefix=$PREFIX --openssldir=$PREFIX/ssl

make
make install

cd $TOP
rm -rf openssl-$VER
