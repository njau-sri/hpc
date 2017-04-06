#!/bin/bash

VER=3.2.1

TOP=`pwd`

PREFIX=/share/apps/R/$VER

BLAS_PATH=/share/apps/openblas/0.2.14/lib
WITH_BLAS="-L$BLAS_PATH -lopenblas"

export LD_LIBRARY_PATH=$BLAS_PATH:$LD_LIBRARY_PATH

tar zxf R-$VER.tar.gz
cd R-$VER

./configure --prefix=$PREFIX --with-blas="$WITH_BLAS" --disable-nls

make -j4
make check
mkdir -p $PREFIX/lib64/R/lib
make install

cd $TOP
rm -rf R-$VER
