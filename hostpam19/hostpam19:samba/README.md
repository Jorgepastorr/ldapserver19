# Puesta en marcha

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19

docker run --rm --name samba -h samba --net ldapnet -v homes:/tmp/home --privileged -d jorgepastorr/samba19:pam

docker run --rm --name pam -h pam --net ldapnet --privileged -it jorgepastorr/hostpam19:samba
```





## Modificaciones

En el host nos interesa, tener conexión con ldap para la autentificación y con samba para crear el punto de montaje.

###  Paquetes 

```bash
dnf install -y passwd nss-pam-ldapd authconfig samba-client cifs-utils pam_mount
```



### Conexión ldap

```bash
authconfig --enableshadow --enablelocauthorize \
   --enableldap \
   --enableldapauth \
   --ldapserver='ldapserver' \
   --ldapbase='dc=edt,dc=org' \
   --enablemkhomedir \
   --updateall
```

```bash
/sbin/nscd
/sbin/nslcd
```



### Usuarios locales

```bash
useradd local1
useradd local2
useradd local3

echo 'local1' | passwd local1 --stdin
echo 'local2' | passwd local2 --stdin
echo 'local3' | passwd local3 --stdin
```



### Montaje automático

Para que monte automáticamente, el recurso samba en el home hay que modificar `system-auth` y `pam_mount.conf.xml`.

*/etc/pam.d/system-auth* 

```bash
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        optional      pam_mount.so
auth        required      pam_faildelay.so delay=2000000
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
auth        sufficient    pam_ldap.so use_first_pass
auth        required      pam_deny.so

account     required      pam_unix.so broken_shadow
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 1000 quiet
account     [default=bad success=ok user_unknown=ignore] pam_ldap.so
account     required      pam_permit.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
password    sufficient    pam_ldap.so use_authtok
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     optional      pam_mkhomedir.so umask=0077
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
session     optional      pam_ldap.so

session     [success=ignore default=1] pam_succeed_if.so uid >= 7000
session     optional      pam_mount.so
```

Se a añadido el modulo `pam_mount.so` con  una condición, de que si el usuario tiene un `uid >= 7000` ( los de ldap) se active.



*/etc/security/pam_mount.conf.xml*

```bash
...		
		<!-- Volume definitions -->
<volume user="*" fstype="cifs" server="samba" path="%(USER)" mountpoint="~/%(USER)" options="user=%(USER)" />
...
```

Se este archivo le decimos que montar y donde.

- `server=samba` y `path="%(USER)"` es equivalente a `//server/user` , donde el user sera el que inicia sesión.
- `mountpoint"~/%(USER)"` donde se montara.
- `options="user=%(USER)"`  el usuario con el que hará la petición al recurso samba.

