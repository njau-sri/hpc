#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#

hostname

echo "/-    /etc/auto.ds3512    --timeout=1200" >> /etc/auto.master
echo "/ds3512    10.1.1.1:/ds3512" > /etc/auto.ds3512

/sbin/service autofs reload
