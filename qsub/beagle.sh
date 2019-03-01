#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

JAVA=/share/apps/java/jre1.8.0_131/bin/java

# http://faculty.washington.edu/browning/beagle/beagle.html
BEAGLE=/share/apps/beagle/beagle.08Jun17.d8b.jar

# your code goes here

# soybean, window=10 -> 10cM -> 10Mb, overlap=1 -> 1cM -> 1Mb
$JAVA -Xmx8g -jar $BEAGLE  gt=test.vcf.gz  out=out.gt  nthreads=4  window=10  overlap=1  ne=10000
