#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo "ERROR: permission denied"
    exit 1
fi

read -p "Enter Expiration Date (months): " expire

if [[ -z "$expire" ]]; then
    echo "ERROR: expiration date is empty"
    exit 1
fi

expire=$(date -d "$expire months" +"%Y-%m-%d")

chage -E $expire $1

rocks sync users
