#!/bin/bash

USERS="$(cat userlist.txt)"

if [ $(id -u) -eq 0 ]; then
    for u in $USERS
    do
        useradd -d /ds3512/home/$u $u
        echo "$u:111111" | chpasswd
    done
    rocks sync users
else
    echo 'ERROR: NO ROOT PRIVILEGE'
    exit 1
fi
