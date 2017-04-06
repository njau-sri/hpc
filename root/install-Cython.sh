#!/bin/bash

VER=0.23.4

PYTHON=/opt/python/bin/python2
PREFIX=/share/apps/python

TOP=`pwd`

tar zxf Cython-$VER.tar.gz
cd Cython-$VER

$PYTHON setup.py build -j 4
$PYTHON setup.py install --prefix $PREFIX

cd $TOP
rm -rf Cython-$VER
