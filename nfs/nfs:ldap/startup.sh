#!/bin/bash

bash /opt/docker/auth.sh
/sbin/nscd
/sbin/nslcd

bash /opt/docker/install.sh
