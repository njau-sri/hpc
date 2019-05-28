#!/bin/bash

GCC=gcc-4.9.4
PREFIX=/share/apps/gcc/4.9.4

TOP=$(pwd)

tar jxf $GCC.tar.bz2
cd $GCC
./contrib/download_prerequisites || exit 1

cd $TOP
mkidr $GCC-build && cd "$_"

$TOP/$GCC/configure --prefix=$PREFIX --enable-languages=c,c++,fortran --disable-multilib --disable-nls || exit

make -j4 || exit
make install

cd $TOP

# env

echo "export PATH=$PREFIX/bin:\$PATH" > $PREFIX/env.sh
echo "export LD_LIBRARY_PATH=$PREFIX/lib64:\$LD_LIBRARY_PATH" >> $PREFIX/env.sh
