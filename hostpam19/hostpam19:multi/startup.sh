#!/bin/bash

bash /opt/docker/install.sh


/usr/sbin/rpcbind
/usr/sbin/rpc.statd 


/sbin/nscd
/sbin/nslcd -d

