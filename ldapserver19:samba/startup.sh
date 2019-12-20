#!/bin/bash

bash /opt/docker/install.sh

#unlimit -n 1024
/sbin/slapd -d0
