#!/bin/bash

bash /opt/docker/auth.sh
/sbin/nscd
/sbin/nslcd

bash /opt/docker/install.sh

/usr/sbin/exportfs -av
/usr/sbin/rpcbind 
/usr/sbin/rpc.statd
/usr/sbin/rpc.nfsd 
/usr/sbin/rpc.mountd -F
