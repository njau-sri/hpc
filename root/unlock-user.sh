#!/bin/bash

USERS="$(ls /ds3512/home)"

if [ $(id -u) -eq 0 ]; then
    for u in $USERS
    do
        passwd -u $u
    done
else
    echo 'ERROR: NO ROOT PRIVILEGE'
    exit 1
fi
