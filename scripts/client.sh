#!/bin/bash

sudo yum install -y openldap-clients nss-pam-ldapd authconfig
sudo authconfig --enableldap --enableldapauth --ldapserver=$LDAP_IP_ADDRESS --ldapbasedn="dc=devopsldab,dc=com" --enablemkhomedir --update
sudo getent passwd