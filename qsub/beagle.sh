#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

JAVA=/share/apps/java/jre1.8.0_131/bin/java
BEAGLE=/share/apps/beagle/beagle.08Jun17.d8b.jar

# your code goes here

$JAVA -Xmx8g -jar $BEAGLE  gt=test.vcf.gz  out=out.gt  nthreads=2  window=10000  overlap=1000  ne=1000
