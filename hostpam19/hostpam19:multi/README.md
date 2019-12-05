# hostpam19:nfs

host que autentifica con un server ldapserver y monta dentro del home del usuario un directorio personal del servidor nfsserver.

## Requisitos

Es necesario un volumen exports para el servidor nfs, este guardara los directorios personales en dicho volumen.

## Puesta en marcha

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19

docker run --rm --name nfsserver -h nfsserver --net ldapnet -v exports:/tmp/home/ --privileged -d jorgepastorr/nfsserver:ldap

docker run --rm --name pam -h pam --privileged --net ldapnet -it jorgepastorr/hostpam19:nfs
```

```bash
...
Unable to find image 'jorgepastorr/hostpam19:nfs' locally
nfs: Pulling from jorgepastorr/hostpam19
b93b55b43f66: Already exists 
...


[root@pam docker]# 
[root@pam docker]# su - local1
[local1@pam ~]$ su - user01
pam_mount password:
Creating directory '/tmp/home/hisx1/user01'.
[user01@pam ~]$ ls
user01
[user01@pam ~]$ ls user01/
soyuser1

```