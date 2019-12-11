#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=8G
#

. /share/apps/java/jre/env.sh

# TASSEL home directory
TASSEL=/share/apps/tassel/latest

# Initial and maximum memory size
XMS=-Xms512m
XMX=-Xmx4g

# XML configuration file
CONFIG1=kinship.xml
CONFIG2=mlm-K.xml




# !!! DO NOT MODIFY !!!

CP=$TASSEL/sTASSEL.jar
for i in $(ls $TASSEL/lib/*.jar)
do
  CP=$CP:$i
done

java -classpath "$CP" $XMS $XMX net.maizegenetics.pipeline.TasselPipeline -configFile $CONFIG1
java -classpath "$CP" $XMS $XMX net.maizegenetics.pipeline.TasselPipeline -configFile $CONFIG2
