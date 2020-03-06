#!/bin/bash



case $1 in
    "initdb") 
        bash /opt/docker/initdb.sh 
        bash /opt/docker/permisos.sh 
        bash /opt/docker/startService.sh ;;
    "initdbedt") 
        bash /opt/docker/initdb.sh 
        bash /opt/docker/usuarios.sh 
        bash /opt/docker/permisos.sh 
        bash /opt/docker/startService.sh ;;
    "listdn") 
        slapcat | grep dn ;;
    ""|"start") 
        bash /opt/docker/startService.sh ;;
     *) 
        eval "$@" ;;
esac
