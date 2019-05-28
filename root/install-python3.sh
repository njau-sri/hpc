#!/bin/bash

export PATH=/share/apps/gcc/4.8.5/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/gcc/4.8.5/lib64:$LD_LIBRARY_PATH

PYTHON=Python-3.7.3
PREFIX=/share/apps/python/3.7.3

ZLIB=zlib-1.2.11
XZ=xz-5.2.4
OPENSSL=openssl-1.1.1b
SQLITE=sqlite-autoconf-3280000
FFI=libffi-3.2.1

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export CFLAGS="-I$PREFIX/include -I$PREFIX/include/openssl"
export CPPFLAGS="-I$PREFIX/include -I$PREFIX/include/openssl"
export LDFLAGS="-L$PREFIX/lib -L$PREFIX/lib64"
export LIBFFI_INCLUDEDIR=$PREFIX/lib/$FFI/include
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH

TOP=$(pwd)

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
tar zxf $OPENSSL.tar.gz
cd $OPENSSL
./config --prefix=$PREFIX --openssldir=$PREFIX/ssl
make install || exit 1

cd $TOP
tar zxf $SQLITE.tar.gz
cd $SQLITE
./configure --prefix=$PREFIX
make install || exit 1

cd $TOP
tar zxf $FFI.tar.gz
cd $FFI
./configure --prefix=$PREFIX
make install || exit 1

cd $TOP
tar zxf $PYTHON.tgz
cd $PYTHON
./configure --prefix=$PREFIX --enable-optimizations

make || exit 1
make install

# env

echo 'PREFIX=/share/apps/python/3.7.3' > $PREFIX/env.sh
echo 'export LD_LIBRARY_PATH=/share/apps/gcc/4.8.5/lib64:$LD_LIBRARY_PATH' >> $PREFIX/env.sh
echo 'export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH' >> $PREFIX/env.sh
echo 'export PATH=$PREFIX/bin:$PATH' >> $PREFIX/env.sh
echo 'python3 --version' >> $PREFIX/env.sh
