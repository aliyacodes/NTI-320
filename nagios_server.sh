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
echo "[nti-310-extras]
name=NTI310 EXTRAS
baseurl=http://104.197.59.12/extras/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
echo "[nti-310-updates]
name=NTI310 UPDATES
baseurl=http://104.197.59.12/updates/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo

yum -y install nagios       # Install, start and enable nagios
systemctl enable nagios
systemctl start nagios

setenforce 0               # Turn off SElinux, so it doesn't trip us up
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config # Disable it permanently

systemctl enable httpd      # Enable and start apache
systemctl start httpd

yum -y install nrpe          # Install, enable, and start nrpe, the nagios client
systemctl enable nrpe
systemctl start nrpe
yum -y install nagios-plugins-all
yum -y install nagios-plugins-nrpe

htpasswd -b /etc/nagios/passwd nagiosadmin nagiosadmin  # set the nagios admin password
sed -i 's,allowed_hosts=127.0.0.1,allowed_hosts=127.0.0.1\,10.128.0.0\/20,g' /etc/nagios/nrpe.cfg
# the above enables connections from your subnet, please adjust to be your subnet!

sed -i 's,dont_blame_nrpe=0,dont_blame_nrpe=1,g' /etc/nagios/nrpe.cfg
# enable NRPE monitoring

mkdir /etc/nagios/servers
# create a directory for our server configuration and enable it in the config file
sed -i 's,#cfg_dir=/etc/nagios/servers,cfg_dir=/etc/nagios/servers,g' /etc/nagios/nagios.cfg
echo 'define command{
                                command_name check_nrpe
                                command_line /usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
                                }' >> /etc/nagios/objects/commands.cfg

systemctl restart nagios

yum -y install wget
cd /etc/nagios
wget https://raw.githubusercontent.com/nic-instruction/hello-nti-320/master/generate_config.sh

chmod 775 /etc/nagios/servers
usermod -a -G root aliyaasken

# Now take a break, and spin up a machine called example-a with all the nrpe plugins installed and a properly configured
# to nagios
# put its ip address into the generate_config.sh


# Further configuration:
# https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/monitoring-publicservices.html (Links to an external site.)


# verify 
# /usr/sbin/nagios -v /etc/nagios/nagios.cfg

# nagios.sh
