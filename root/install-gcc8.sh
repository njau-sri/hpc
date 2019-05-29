#!/bin/bash

GCC=gcc-8.3.0
PREFIX=/share/apps/gcc/8.3.0

TOP=$(pwd)

tar Jxf $GCC.tar.xz
cd $GCC
./contrib/download_prerequisites || exit 1

cd $TOP
mkdir $GCC-build && cd "$_"

$TOP/$GCC/configure --prefix=$PREFIX --enable-languages=c,c++,fortran --disable-multilib --disable-nls || exit

make -j4 || exit
make install

cd $TOP

# env

echo "export PATH=$PREFIX/bin:\$PATH" > $PREFIX/env.sh
echo "export LD_LIBRARY_PATH=$PREFIX/lib64:\$LD_LIBRARY_PATH" >> $PREFIX/env.sh
