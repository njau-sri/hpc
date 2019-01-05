#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo "ERROR: permission denied"
    exit 1
fi

usermod -L -e 1 $1

rocks sync users
