#!/bin/bash

VER=1.4
XZ=xz-5.2.3

TOP=`pwd`

tar zxf $XZ.tar.gz
cd $XZ
./configure --prefix=$HOME/$XZ --disable-shared
make
make install

cd $TOP
tar jxf samtools-$VER.tar.bz2
cd samtools-$VER
./configure --prefix=/share/apps/samtools/$VER CFLAGS="-I$HOME/$XZ/include" LDFLAGS="-L$HOME/$XZ/lib"
make
make install

cd $TOP
tar jxf bcftools-$VER.tar.bz2
cd bcftools-$VER
make CFLAGS="-I$HOME/$XZ/include" LDFLAGS="-L$HOME/$XZ/lib"
make prefix=/share/apps/bcftools/$VER install

cd $TOP
rm -rf $XZ*
rm -rf samtools-$VER*
rm -rf bcftools-$VER*
