#!/bin/bash

PREFIX=/share/apps/java/jre

tar zxf OpenJDK11U-jre_x64_linux_hotspot_11.0.3_7.tar.gz -C $PREFIX

echo "export PATH=$PREFIX/jdk-11.0.3+7-jre/bin:\$PATH" > $PREFIX/env.sh
echo "java -version" >> $PREFIX/env.sh
