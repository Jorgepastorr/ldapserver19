#!/bin/bash


# creo homes de usuarios
for num in {01..08}
do 
    liniaget=$( getent passwd user$num )
    uid=$( echo $liniaget | cut -d: -f 3 )
    gid=$( echo $liniaget | cut -d: -f 4 )
    homedir=$( echo $liniaget | cut -d: -f 6 )

    if [ ! -d $homedir ];then
        mkdir -p /exports$homedir
        chown -R $uid:$gid /exports$homedir
    fi

done

cp /opt/docker/exports /etc/exports

exportfs -ra

rpcbind -i
/sbin/rpc.statd --no-notify --port 32765 --outgoing-port 32766
/sbin/rpc.nfsd -V3 -N2 -N4 -d 8
/sbin/rpc.mountd -V3 -N2 -N4 --port 32767 -F

# /exports/tmp/home/hisx4/user08