#!/bin/bash

home=/ds3512/home

expire=$(date -d "3 years" +"%Y-%m-%d")

if [ $(id -u) -ne 0 ]; then
    echo "ERROR: permission denied"
    exit 1
fi

read -p "Enter Username: " username

egrep "^$username" /etc/passwd >/dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: $username already exists"
    exit 1
fi

password=$(cat /dev/urandom | tr -dc '0-9' | fold -w 8 | head -n 1)

cryptpass=$(perl -e 'print crypt($ARGV[0], "password")' $password)

useradd -d $home/$username -e $expire -p $cryptpass $username

if [ $? -eq 0 ]; then
    echo "ERROR: failed to add $username"
    exit 1
fi

rocks sync users

echo
echo "$username:$password has been added to system"
echo
