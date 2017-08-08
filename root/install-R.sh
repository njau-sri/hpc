#!/bin/bash

VER=3.4.0

TOP=`pwd`

PREFIX=/share/apps/R/$VER

BLASROOT=/share/apps/openblas/LATEST
WITHBLAS="-L$BLASROOT/lib -lopenblas"

# zlib>=1.2.3, bzip2>=1.0.6, xz>=5.0.3, pcre>=8.10<=10.0&utf-8, curl>=7.22.0&ssl
LOCALROOT=/share/apps/local

export PKG_CONFIG_PATH=$LOCALROOT/lib/pkgconfig
export LD_LIBRARY_PATH=$BLASROOT/lib:$LD_LIBRARY_PATH
export CFLAGS="-I$LOCALROOT/include"
export LDFLAGS="-L$LOCALROOT/lib"

tar zxf R-$VER.tar.gz
cd R-$VER

./configure --prefix=$PREFIX --with-blas="$WITHBLAS" --disable-nls

make
make check
mkdir -p $PREFIX/lib64/R/lib
make install

cd $TOP
rm -rf R-$VER
