#!/bin/bash

useradd local1
useradd local2
useradd local3

echo 'local1' | passwd local1 --stdin
echo 'local2' | passwd local2 --stdin
echo 'local3' | passwd local3 --stdin



authconfig --enableshadow --enablelocauthorize \
   --enableldap \
   --enableldapauth \
   --ldapserver='ldapserver' \
   --ldapbase='dc=edt,dc=org' \
   --enablemkhomedir \
   --updateall


cp /opt/docker/system-auth /etc/pam.d/system-auth
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml