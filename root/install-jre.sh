#!/bin/bash

tar xzf jre-8u201-linux-x64.tar.gz -C /share/apps/java/

cd /share/apps/java

rm -rf latest

ln -s jre1.8.0_201 latest

cd
