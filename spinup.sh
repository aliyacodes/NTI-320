#!/bin/bash

gcloud compute instances create rsyslog \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./rsyslog_server.sh \
--private-network-ip=10.128.0.2

gcloud compute instances create postgres \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./postgres_on_centos_7.sh \
--private-network-ip=10.128.0.3

gcloud compute instances create ldap \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./ldap_server.sh \
--private-network-ip=10.128.0.8

gcloud compute instances create django \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./django.sh \
--private-network-ip=10.128.0.13

gcloud compute instances create nfs \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./nfs_server.sh \
--private-network-ip=10.128.0.9

gcloud compute instances create cacti \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./cacti_server.sh \
--private-network-ip=10.128.0.4

gcloud compute instances create nagios \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-central1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./nagios_server.sh \
--private-network-ip=10.128.0.11

gcloud compute instances create client-1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-central1-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./ubuntu_client.sh \
--private-network-ip=10.128.0.16

gcloud compute instances create client-2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-central1-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=./ubuntu_client.sh \
--private-network-ip=10.128.0.22
