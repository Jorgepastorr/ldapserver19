# ldapserver19

- [ldapserver:base](#ldapserverbase)
- [ldapserver:multi](#ldapservermulti)
- [ldapserver:acl](#ldapserveracl)
- [ldapserver:schema](#ldapserverschema)
- [ldapserver19:grups](#ldapserver19grups)
- [phpldapadmin](#phpldapadmin)
- [hostpam19:base](#hostpam19base)
- [hostpam19:auth](#hostpam19auth)
- [hostpam19:samba](#hostpam19samba)




## @jorgepastorr

Repositorio de creación de imágenes de servidor ldap. En todos los containers se rigen por el mismo modo de creación, en su interior el archivo `install.sh` que creara toda la configuración, y el archivo `startup.sh`  que pondrá el servicio en marcha.

### ldapserver19:base 

Container con server ldap con uri `ldapserver` base `dc=edt,dc=org`  donde se cargan una serie de usuarios para pruebas.

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19:base
ldapsearch -x -LLL -h <ip-container> -b dc=edt,dc=org dn
```



### ldapserver19:multi 

Container ldap con dos bases de datos base `dc=edt,dc=org` y `dc=m06,dc=cat`

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19:base
ldapsearch -x -LLL -h <ip-container> -b dc=edt,dc=org dn
ldapsearch -x -LLL -h <ip-container> -b dc=m06,dc=cat dn
```



### ldapserver19:acl

Container con server ldap con uri `ldapserver` base `dc=edt,dc=org` , en su interior se encuentra el archivo `acl.ldif`  que modifica la acl de la base de datos.

```bash
ldapmodify -x -D 'cn=Sysadmin,cn=config' -w syskey -f acl.ldif
```



### ldapserver19:schema

Container ldap con diferentes esquemas personalizados.

```bash
ldapserver19:schema
├── DB_CONFIG
├── Dockerfile
├── edt.org.ldif
├── futbolista-A.schema
├── futbolista-B.schema
├── futbolista-C.schema
├── futbolistesA.ldif
├── futbolistesB.ldif
├── futbolistesC.ldif
├── install.sh
├── ldap.conf
├── slapd.conf
└── startup.sh
```



### ldapserver19:grups

Container con servidor ldap con un arbol de usuarios y grupos bien asignados

```markdown
- edt.org
	- grups
		- hisx1
			- user01
			- user02
		- hisx2
		- hisx3
		- hisx4
	- usuaris
		- user01
		...
		- user08
		
```





### phpldapadmin

Container con server phpldapadmin, que conecta con un servidor ldap con uri `ldapserver`  y base `dc=edt,dc=org` 

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19
docker run --name phpldapadmin -h phpldapadmin --net ldapnet -p 80:80 -d jorgepastorr/phpldapadmin19
```

Desde el navegador `localhost/phpldapserver`



### hostpam19:base

Container donde al iniciar sesión con un usuario se montan dos directorios dentro de su home:

- Un directorio tmp via tmpfs
- Un directorio `%(USER)/man` via nfs de `172.17.0.1:/usr/share/man`

Este container se tiene que arrancar con `--privileged` para su correcto funcionamiento, e su interior ejecutar `bash startup.sh`





### hostpam19:auth

Container que autentifica usuarios tanto locales como procedentes de un server ldap con uri `ldapserver`  y base `dc=edt,dc=org` , y monta un directorio tmp en el home via tmpfs.

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19
docker run --name pam -h pam --net ldapnet --privileged -it jorgepastorr/hostpam19:auth /bin/bash
[root@pam docker]\# bash startup.sh
```



### hostpam19:samba

Container que autentifica usuarios con un servidor ldapserver, y al inicio de sesión de los usuarios ldap monta un recurso samba en el home del usuario. ( para su correcto funcionamiento es necesario ldapserver19 y samba19:pam)

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19
docker run --rm --name samba -h samba --net ldapnet --privileged -d jorgepastorr/samba19:pam
docker run --rm --name pam -h pam --net ldapnet --privileged -it jorgepastorr/hostpam19:samba
```

