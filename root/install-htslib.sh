#!/bin/bash

PREFIX=/share/apps/htslib/1.9

XZ=xz-5.2.4
HTSLIB=htslib-1.9
BCFTOOLS=bcftools-1.9
SAMTOOLS=samtools-1.9

export CFLAGS=-I$PREFIX/include
export LDFLAGS=-L$PREFIX/lib

TOP=$(pwd)

# liblzma - wget https://tukaani.org/xz/$XZ.tar.gz
cd $TOP
tar zxf $XZ.tar.gz || exit 1
cd $XZ
./configure --prefix=$PREFIX
make install || exit 1

# htslib
cd $TOP
tar jxf $HTSLIB.tar.bz2 || exit 1
cd $HTSLIB
./configure --prefix=$PREFIX
make install || exit 1

# bcftools
cd $TOP
tar jxf $BCFTOOLS.tar.bz2 || exit 1
cd $BCFTOOLS
./configure --prefix=$PREFIX
make install || exit 1

# samtools
cd $TOP
tar jxf $SAMTOOLS.tar.bz2 || exit 1
cd $SAMTOOLS
./configure --prefix=$PREFIX
make install || exit 1

# env
echo "export PATH=$PREFIX/bin:\$PATH" > $PREFIX/env.sh
echo "export LD_LIBRARY_PATH=$PREFIX/lib:\$LD_LIBRARY_PATH" >> $PREFIX/env.sh
