#!/bin/bash

VER=8.40

TOP=`pwd`

PREFIX=/share/apps/local

tar zxf pcre-$VER.tar.gz
cd pcre-$VER

./configure --prefix=$PREFIX --enable-utf8

make
make install

cd $TOP
rm -rf pcre-$VER
