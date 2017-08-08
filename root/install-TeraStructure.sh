#!/bin/bash

VER=1.0

INC=/share/apps/gsl/LATEST/include
LIB=/share/apps/gsl/LATEST/lib

TOP=`pwd`

unzip terastructure-master.zip
cd terastructure-master

g++ -o terastructure -s -O2 -Wall -I$INC-L$LIB -lgsl -lgslcblas -lpthread *.cc

mkdir -p /share/apps/TeraStructure/$VER
cp terastructure /share/apps/TeraStructure/$VER/

cd $TOP
rm -rf terastructure-master
