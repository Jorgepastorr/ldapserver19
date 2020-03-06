#!/bin/bash

slapadd -F /etc/openldap/slapd.d -l /opt/docker/edt.org.ldif

if [ $? -eq 0 ] && [ $DEBUG -gt 0 ];then
    echo "Anadido de usuarios Ok" >> /dev/stderr
fi