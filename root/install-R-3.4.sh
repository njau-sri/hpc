#!/bin/bash

VERSION=3.4.4

PREFIX=/share/apps/R/$VERSION

ZLIB=zlib-1.2.11
XZ=xz-5.2.4
BZIP2=bzip2-1.0.6
PCRE=pcre-8.42
OPENSSL=openssl-1.1.0h
CURL=curl-7.60.0

BLAS="-L/share/apps/openblas/default/lib -lopenblas"
export LD_LIBRARY_PATH=$PREFIX/lib:/share/apps/openblas/default/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

TOP=`pwd`

if [ ! -f R-$VERSION.tar.gz ]; then
    wget https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/base/R-3/R-$VERSION.tar.gz || exit 1
fi

if [ ! -f $ZLIB.tar.gz ]; then
    wget http://www.zlib.net/$ZLIB.tar.gz || exit 1
fi

if [ ! -f $XZ.tar.gz ]; then
    wget https://www.tukaani.org/xz/$XZ.tar.gz || exit 1
fi

if [ ! -f $BZIP2.tar.gz ]; then
    wget http://www.bzip.org/1.0.6/$BZIP2.tar.gz || exit 1
fi

if [ ! -f $PCRE.tar.gz ]; then
    wget https://ftp.pcre.org/pub/pcre/$PCRE.tar.gz || exit 1
fi

if [ ! -f $OPENSSL.tar.gz ]; then
    wget https://www.openssl.org/source/$OPENSSL.tar.gz || exit 1
fi

if [ ! -f $CURL.tar.gz ]; then
    wget https://curl.haxx.se/download/$CURL.tar.gz || exit 1
fi

cd $TOP
tar zxf $ZLIB.tar.gz
cd $ZLIB
./configure --prefix=$PREFIX
make install

cd $TOP
tar zxf $XZ.tar.gz
cd $XZ
./configure --prefix=$PREFIX
make install

cd $TOP
tar zxf $BZIP2.tar.gz
cd $BZIP2
make install PREFIX=$PREFIX

cd $TOP
tar zxf $PCRE.tar.gz
cd $PCRE
./configure --prefix=$PREFIX --enable-utf
make install

cd $TOP
tar zxf $OPENSSL.tar.gz
cd $OPENSSL
./config --prefix=$PREFIX --openssldir=$PREFIX/ssl
make install

cd $TOP
tar zxf $CURL.tar.gz
cd $CURL
./configure --prefix=$PREFIX --with-ssl=$PREFIX
make install

cd $TOP
tar zxf R-$VERSION.tar.gz
cd R-$VERSION
./configure --prefix=$PREFIX --with-blas="$BLAS" --disable-nls --disable-openmp --with-x=no

make
make check
make install

cd $TOP
rm -rf $ZLIB $XZ $BZIP2 $PCRE $OPENSSL $CURL R-$VERSION
