#!/bin/bash

home=/ds3512/home

if [[ $(id -u) -ne 0 ]]; then
    echo "ERROR: permission denied"
    exit 1
fi

read -p "Enter Username: " username

if [[ -z "$username" ]]; then
    echo "ERROR: username is empty"
    exit 1
fi

read -p "Enter Expiration Date (years): " expire

if [[ -z "$expire" ]]; then
    echo "ERROR: expiration date is empty"
    exit 1
fi

if id -u "$username" >/dev/null 2>&1; then
    echo "ERROR: $username already exists"
    exit 1
fi

expire=$(date -d "$expire years" +"%Y-%m-%d")

password="${username}$(date +"%Y%m%d")"

cryptpass=$(perl -e 'print crypt($ARGV[0], "password")' $password)

useradd -d $home/$username -e $expire -p $cryptpass $username

if [[ $? -ne 0 ]]; then
    echo "ERROR: failed to add $username"
    exit 1
fi

rocks sync users

echo
echo "$username:$password has been added to system"
echo
