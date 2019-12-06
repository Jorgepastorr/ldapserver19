# hostpam19:multi

host que autentifica con un server ldapserver y monta dentro del home del usuario un directorio personal del servidor nfsserver o samba.

## Requisitos

Es necesario un volumen homes para el servidor nfs y samba, este guardara los directorios personales en dicho volumen.

## Puesta en marcha

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19

docker run --rm --name nfsserver -h nfsserver --net ldapnet -v homes:/tmp/home/ --privileged -d jorgepastorr/nfsserver:ldap

docker run --rm --name samba -h samba --net ldapnet -v homes:/tmp/home --privileged -d jorgepastorr/samba19:pam

docker run --rm --name pam -h pam --privileged --net ldapnet -it jorgepastorr/hostpam19:nfs
```
