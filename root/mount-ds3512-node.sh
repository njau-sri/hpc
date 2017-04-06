#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#

hostname

if [ $(id -u) -eq 0 ]; then
    if [ ! -d /ds3512 ]; then
        mkdir /ds3512
    fi
    if ! grep -q 10.1.1.1:/ds3512 /proc/mounts; then
        mount -t nfs 10.1.1.1:/ds3512 /ds3512
    fi
else
    echo 'ERROR: NO ROOT PRIVILEGE'
    exit 1
fi
