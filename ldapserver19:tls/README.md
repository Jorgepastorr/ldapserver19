## Ldap tls

Ldap con conexiones seguras TLS/SSL  y startTLS.

### Generar cerificados

```bash
# genrar llaves privadas, del servidor.
openssl genrsa -out cakey.pem 2048
openssl genrsa -out serverkey.pem 2048

# genrar certificado propio de la entidad CA por 365 dias
openssl req -new -x509 -nodes -sha1 -days 365 -key cakey.pem -out cacrt.pem
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:ca
State or Province Name (full name) [Some-State]:Barcelona
Locality Name (eg, city) []:Barcelona
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Varitat Absoluta
Organizational Unit Name (eg, section) []:Dep de certificats
Common Name (e.g. server FQDN or YOUR name) []:VeritatAbsoluta
Email Address []:admin@edt.org

# generar una de  certificado request para enviar a la entidad certificadora CA
openssl req -new -key serverkey.pem -out servercsr.pem 

You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:ca
State or Province Name (full name) [Some-State]:Barcelona
Locality Name (eg, city) []:Barcelona
Organization Name (eg, company) [Internet Widgits Pty Ltd]:escola de mi casa 
Organizational Unit Name (eg, section) []:dep informatica
Common Name (e.g. server FQDN or YOUR name) []:ldap.edt.org
Email Address []:admin@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:request password
An optional company name []:edt

# Una entidad CA a de firmar el servercsr.pem y devolvernos un certificado.crt, como hago yo mismo de entidad
cat ca.conf 
basicConstraints = critical,CA:FALSE
extendedKeyUsage = serverAuth,emailProtection

# Autoridad CA firmando el certificado 
openssl x509 -CA cacrt.pem -CAkey cakey.pem -req -in servercsr.pem -days 365 -sha1 -extfile ca.conf -CAcreateserial -out servercrt.pem 

Signature ok
subject=C = ca, ST = Barcelona, L = Barcelona, O = escola de mi casa, OU = dep informatica, CN = ldap.edt.org, emailAddress = admin@edt.org
Getting CA Private Key

# archivos finales
➜  ll
total 60K
-rw-r--r-- 1 debian debian   83 abr  1 10:14 ca.conf
-rw-r--r-- 1 debian debian 1,5K abr  1 10:23 cacrt.pem
-rw-r--r-- 1 debian debian   41 abr  1 10:35 cacrt.srl
-rw------- 1 debian debian 1,7K abr  1 10:14 cakey.pem
-rw-r--r-- 1 debian debian 1,5K abr  1 10:35 servercrt.pem
-rw-r--r-- 1 debian debian 1,2K abr  1 10:32 servercsr.pem
-rw------- 1 debian debian 1,7K abr  1 10:14 serverkey.pem
```





### Configuración

```bash
slapd.conf
---
TLSCACertificateFile    /etc/openldap/certs/cacrt.pem
TLSCertificateFile      /etc/openldap/certs/servercrt.pem
TLSCertificateKeyFile   /etc/openldap/certs/serverkey.pem
TLSVerifyClient         never
TLSCipherSuite          HIGH:MEDIUM:LOW:+SSLv2
---

ldap.conf
---
TLS_CACERT /etc/openldap/certs/cacrt.pem
SASL_NOCANON	on
URI ldap://ldap.edt.org
BASE dc=edt,dc=org
---

startup.sh
---
/sbin/slapd -d0 -h "ldap:/// ldaps:/// ldapi:///" 
---
```

cliente `ldap.conf`

```bash
TLS_CACERT /etc/ldap/cacrt.pem
TLS_REQCERT allow

URI ldap://ldap.edt.org
BASE dc=edt,dc=org

SASL_NOCANON on
```



### Comprobaciones

```bash
ldapsearch -x -LLL -ZZ dn
ldapsearch -x -LLL -ZZ -h ldap.edt.org -b 'dc=edt,dc=org' dn
ldapsearch -x -LLL -H ldaps://ldap.edt.org dn
openssl s_client -connect ldap.edt.org:636
```



### Docker

```bash
➜ docker run --rm --name ldap.edt.org -h ldap.edt.org -p 389:389  -p 636:636 -d jorgepastorr/ldapserver19:tls 
```


