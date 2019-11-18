# ldapserver19

- [ldapserver:base](#ldapserver:base)
- [ldapserver:multi](#ldapserver:multi)
- [ldapserver:acl](#ldapserver:acl)
- [ldapserver:schema](#ldapserver:schema)
- [ldapserver19:grups](#ldapserver19:grups)

- [phpldapadmin](#phpldapadmin)

- [hostpam19:base](#hostpam19:base)
- [hostpam19:auth](#hostpam19:auth)


## @jorgepastorr

Repositorio de creación de imágenes de servidor ldap. En todos los containers se rigen por el mismo modo de creación, en su interior el archivo `install.sh` que creara toda la configuración, y el archivo `startup.sh`  que pondrá el servicio en marcha.

### ldapserver:base 

Container con server ldap con uri `ldapserver` base `dc=edt,dc=org`  donde se cargan una serie de usuarios para pruebas.

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19:base
ldapsearch -x -LLL -h <ip-container> -b dc=edt,dc=org dn
```



### ldapserver:multi 

Container ldap con dos bases de datos base `dc=edt,dc=org` y `dc=m06,dc=cat`

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19:base
ldapsearch -x -LLL -h <ip-container> -b dc=edt,dc=org dn
ldapsearch -x -LLL -h <ip-container> -b dc=m06,dc=cat dn
```



### ldapserver:acl

Container con server ldap con uri `ldapserver` base `dc=edt,dc=org` , en su interior se encuentra el archivo `acl.ldif`  que modifica la acl de la base de datos.

```bash
ldapmodify -x -D 'cn=Sysadmin,cn=config' -w syskey -f acl.ldif
```



### ldapserver:schema

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
			- user03
			- user04
	- usuaris
		- user01
		...
		- user04
		
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

Container que autentifica usuarios tanto locales como procedentes de un server ldap con uri `ldapserver`  y base `dc=edt,dc=org` , también monta los directorios en el home como `hostpam19:base` .

```bash
docker run --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19
docker run --name pam -h pam --net ldapnet -it jorgepastorr/hostpam19:auth /bin/bash
[root@pam docker]\# bash startup.sh
```

