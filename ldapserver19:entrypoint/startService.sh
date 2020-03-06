
ulimit -n 1024

if [ $DEBUG > 0 ];then
    echo "Iniciando servicio" >> /dev/stderr
fi

/sbin/slapd -d0