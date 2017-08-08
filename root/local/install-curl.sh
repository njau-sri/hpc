#!/bin/bash

VER=7.54.0

TOP=`pwd`

PREFIX=/share/apps/local

tar zxf curl-$VER.tar.gz
cd curl-$VER

env PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig ./configure --prefix=$PREFIX --with-ssl

make
make install

cd $TOP
rm -rf curl-$VER
