#!/bin/bash
# install ldapserver

rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/* 

cp /opt/docker/DB_CONFIG /var/lib/ldap/
cp /opt/docker/samba.schema /etc/openldap/schema/samba.schema
cp  /opt/docker/ldap.conf /etc/openldap/ldap.conf

slaptest  -F /etc/openldap/slapd.d/ -f /opt/docker/slapd.conf  
slapadd -F /etc/openldap/slapd.d -l /opt/docker/edt.org.ldif

chown -R ldap:ldap /etc/openldap/slapd.d/
chown -R ldap:ldap /var/lib/ldap/   

cp /opt/docker/ldap.conf /etc/openldap/.

