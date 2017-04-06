#!/bin/bash

VER=1.10.4

PYTHON=/opt/python/bin/python2
PREFIX=/share/apps/python

TOP=`pwd`

tar zxf numpy-$VER.tar.gz
cd numpy-$VER

export PYTHONPATH=$PREFIX/lib/python2.7/site-packages/
export PATH=$PREFIX/bin:$PATH

$PYTHON setup.py build -j 4
$PYTHON setup.py install --prefix $PREFIX

cd $TOP
rm -rf numpy-$VER
