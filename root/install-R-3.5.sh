#!/bin/bash

VERSION=3.5.3

PREFIX=/share/apps/R/$VERSION

BZIP2=bzip2-1.0.6
ZLIB=zlib-1.2.11
XZ=xz-5.2.4
PCRE=pcre-8.43
OPENSSL=openssl-1.1.1b
CURL=curl-7.64.1

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export CFLAGS=-I$PREFIX/include
export CPPFLAGS=-I$PREFIX/include
export LDFLAGS=-L$PREFIX/lib
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH

TOP=$(pwd)

if [[ ! -f $BZIP2.tar.gz ]]; then
    echo "http://vault.centos.org/centos/7/os/Source/SPackages/bzip2-1.0.6-13.el7.src.rpm"
    echo "rpm2cpio bzip2-1.0.6-13.el7.src.rpm | cpio -i bzip2-1.0.6.tar.gz bzip2-1.0.6.tar.gz"
    exit 1
fi

if [[ ! -f R-$VERSION.tar.gz ]]; then
    wget http://mirrors.ustc.edu.cn/CRAN/src/base/R-3/R-$VERSION.tar.gz || exit 1
fi

if [[ ! -f $ZLIB.tar.gz ]]; then
    wget http://www.zlib.net/$ZLIB.tar.gz || exit 1
fi

if [[ ! -f $XZ.tar.gz ]]; then
    wget https://www.tukaani.org/xz/$XZ.tar.gz || exit 1
fi

if [[ ! -f $PCRE.tar.gz ]]; then
    wget https://ftp.pcre.org/pub/pcre/$PCRE.tar.gz || exit 1
fi

if [[ ! -f $OPENSSL.tar.gz ]]; then
    wget https://www.openssl.org/source/$OPENSSL.tar.gz || exit 1
fi

if [[ ! -f $CURL.tar.gz ]]; then
    wget https://curl.haxx.se/download/$CURL.tar.gz || exit 1
fi

rm -rf $PREFIX

cd $TOP
tar zxf $ZLIB.tar.gz
cd $ZLIB
./configure --prefix=$PREFIX
make install || exit 1

cd $TOP
tar zxf $XZ.tar.gz
cd $XZ
./configure --prefix=$PREFIX
make install || exit 1

cd $TOP
tar zxf $BZIP2.tar.gz
cd $BZIP2
make install PREFIX=$PREFIX || exit 1

cd $TOP
tar zxf $PCRE.tar.gz
cd $PCRE
./configure --prefix=$PREFIX --enable-utf --enable-unicode-properties --enable-jit --disable-cpp
make install || exit 1

cd $TOP
tar zxf $OPENSSL.tar.gz
cd $OPENSSL
./config --prefix=$PREFIX --openssldir=$PREFIX/ssl
make install || exit 1

cd $TOP
tar zxf $CURL.tar.gz
cd $CURL
./configure --prefix=$PREFIX --with-ssl=$PREFIX
make install || exit 1

cd $TOP
tar zxf R-$VERSION.tar.gz
cd R-$VERSION
./configure --prefix=$PREFIX --disable-nls --disable-openmp --with-x=no

make || exit 1
make check
make install

cd $TOP
rm -rf $ZLIB $XZ $BZIP2 $PCRE $OPENSSL $CURL R-$VERSION
