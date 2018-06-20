#!/bin/bash

VERSION=3.4.4

PREFIX=/share/apps/

TOP=`pwd`

if [ ! -f microsoft-r-open-$VERSION.tar.gz ]; then
    wget https://mran.blob.core.windows.net/install/mro/$VERSION/microsoft-r-open-$VERSION.tar.gz
fi

tar zxf microsoft-r-open-$VERSION.tar.gz
cd microsoft-r-open
rpm -ivh --prefix=$PREFIX ./rpm/microsoft-r-open-mro-$VERSION.rpm
rpm -ivh --prefix=$PREFIX ./rpm/microsoft-r-open-mkl-$VERSION.rpm

cd $TOP
rm -rf microsoft-r-open
