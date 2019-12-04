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

mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock
