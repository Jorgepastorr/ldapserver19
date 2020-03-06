#!/bin/bash

cp /opt/docker/ldap.conf /etc/openldap/.

rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/* 

cp /opt/docker/DB_CONFIG /var/lib/ldap/

slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d/  
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d/  -u

if [ $? -eq 0 ] && [ $DEBUG -gt 0 ];then
    echo "Iniciar base de datos Ok" >> /dev/stderr
fi