#!/bin/bash

tar xzf jdk-8u201-linux-x64.tar.gz -C /share/apps/java/

cd /share/apps/java

rm -rf latest

ln -s jdk1.8.0_201 latest

cd
