#!/bin/bash

VER=4.9.4

PREFIX=/share/apps/gcc/$VER

TOP=`pwd`

tar jxf gcc-$VER.tar.bz2
cd gcc-$VER
./contrib/download_prerequisites

cd $TOP
mkidr gcc-$VER-bin
cd gcc-$VER-bin
../gcc-$VER/configure --prefix=$PREFIX --enable-languages=c,c++,fortran --disable-multilib --disable-nls || exit
make -j4 || exit
make install

cd $TOP
