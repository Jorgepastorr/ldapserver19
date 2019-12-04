#!/bin/bash

bash /opt/docker/install.sh

/sbin/nscd
/sbin/nslcd 

/usr/sbin/rpcbind
/usr/sbin/rpc.statd 

/bin/bash

