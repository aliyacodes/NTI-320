#!/bin/bash
apt-get update
apt install -y nfs-client
showmount -e 10.128.0.9
mkdir /mnt/test
echo "10.128.0.9:/var/nfsshare/testing     /mnt/test     nfs defaults 0 0" >> /etc/fstab
mount -a
