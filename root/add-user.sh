#!/bin/bash
# Script to add a user to Linux system
# -------------------------------------------------------------------------
# Copyright (c) 2007 nixCraft project <http://bash.cyberciti.biz/>
# This script is licensed under GNU GPL version 2.0 or above
# Comment/suggestion: <vivek at nixCraft DOT com>
# -------------------------------------------------------------------------
# See url for more info:
# http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
# -------------------------------------------------------------------------
#
# Modified by Jianbo He (2015-03-04)
#

if [ $(id -u) -eq 0 ]; then
    read -p "Enter username: " username
    egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "$username exists!"
        exit 1
    else
        password=$(cat /dev/urandom | tr -dc '0-9' | fold -w 8 | head -n 1)
        cryptpass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -d /ds3512/home/$username -p $cryptpass $username
        if [ $? -eq 0 ]; then
            rocks sync users
            echo "$username:$password has been added to system!"
            exit 0
        else
            echo "Failed to add $username!"
            exit 1
        fi
    fi
else
    echo "Only root may add a user to the system!"
    exit 2
fi
