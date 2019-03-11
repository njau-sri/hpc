#!/bin/bash

## mkdir /ds3512
## echo "UUID=d1e2958d-b0e3-49d8-be5f-a9d3dc87d377 /ds3512 ext4 defaults 0 0" >> /etc/fstab
## mount -a

for host in $(qconf -sel); do
    if [[ $host != $(hostname) ]]; then
        qsub -q all.q@$host autofs.ds3512.sh
    fi
done
