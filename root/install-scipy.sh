#!/bin/bash

VER=0.17.0

PYTHON=/opt/python/bin/python2
PREFIX=/share/apps/python

TOP=`pwd`

tar zxf scipy-$VER.tar.gz
cd scipy-$VER

export PYTHONPATH=$PREFIX/lib/python2.7/site-packages/
export PATH=$PREFIX/bin:$PATH

$PYTHON setup.py build -j 4
$PYTHON setup.py install --prefix $PREFIX

cd $TOP
rm -rf scipy-$VER
