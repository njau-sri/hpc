#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    usermod -e 99999 -U $1
    rocks sync users
else
    echo "ERROR: NO ROOT PRIVILEGE!"
    exit 1
fi
