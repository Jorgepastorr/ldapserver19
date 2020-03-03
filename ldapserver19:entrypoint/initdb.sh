#!/bin/bash

rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/* 

cp /opt/docker/DB_CONFIG /var/lib/ldap/

slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d/  
