#!/bin/bash

useradd anna
useradd jorge

echo 'anna' | passwd anna --stdin
echo 'jorge' | passwd jorge --stdin

cp /opt/docker/pam_python.so /usr/lib64/security/
cp /opt/docker/login.defs /etc/login.defs
cp /opt/docker/chfn /etc/pam.d/