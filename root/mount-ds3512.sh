#!/bin/bash

if [ ! -d /ds3512 ]; then
    mkdir /ds3512
fi

ME=`hostname`
EXECHOSTS=`qconf -sel`

for TARGETHOST in $EXECHOSTS; do
    if [ "$ME" != "$TARGETHOST" ]; then
        qsub -q all.q@$TARGETHOST mount-ds3512-node.sh
    fi
done
