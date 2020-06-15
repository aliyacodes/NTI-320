#!/bin/bash

for file in $( ls /etc/yum.repos.d/ ); do mv /etc/yum.repos.d/$file /etc/yum.repos.d/$file.bak; done
echo "[nti-310-epel]
name=NTI310 EPEL
baseurl=http://104.197.59.12/epel
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
echo "[nti-310-base]
name=NTI310 BASE
baseurl=http://104.197.59.12/base
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
echo "[nti-320]
name=Extra Packages for Centos from NTI-320 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch <- example epel repo
# Note, this is putting repodata at packages instead of 7 and our path is a hack around that.
baseurl=http://10.128.0.7/centos/7/extras/x86_64/Packages/
enabled=1
gpgcheck=0
" > /etc/yum.repos.d/NTI-320.repo

yum install -y nfs-utils
mkdir /var/nfsshare
mkdir /var/nfsshare/devstuff
mkdir /var/nfsshare/testing
mkdir /var/nfsshare/home_dirs
chmod -R 777 /var/nfsshare/
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
cd /var/nfsshare/

echo "/var/nfsshare/home_dirs *(rw,sync,no_all_squash)
/var/nfsshare/devstuff *(rw,sync,no_all_squash)
/var/nfsshare/testing *(rw,sync,no_all_squash)" >> /etc/exports

systemctl restart nfs-server
#install net tools to get ifconfig
yum -y install net-tools
