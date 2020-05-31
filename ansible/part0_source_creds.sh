#!/bin/bash
#
# author: Gary A. Stafford
# site: https://programmaticponderings.com
# license: MIT License
# purpose: Source Ansible/GCP credentials
# usage: source ./ansible_gcp_creds.sh
# Constants - CHANGE ME!
export GCP_PROJECT='nti-320-aliyas-project'
export GCP_AUTH_KIND='serviceaccount'
export GCP_SERVICE_ACCOUNT_FILE='/home/aliyaasken/ansible/nti-320-aliyas-project-031a9a1f63dc.json'
export GCP_SCOPES='https://www.googleapis.com/auth/compute'