# ldapserver19

## @jorgepastorr

Repositorio de creación de imágenes de servidor ldap:  

**ldapserver.base** servidor ldap básico  

**ldapserver:multi** servidor con múltiples bases de datos  

**ldapserver:acl** servidor con archivo de modificación de ejemplo acl permisos por defecto modificados  

**ldapserver:schema**: servidor con diferentes schemas personalizados

**ldapserver:practica**: servidor con schema master personalizado 

**ldapserver19:grups**:  servidor con usuarios asignados a diferentes grupos



**phpldapadmin**: servidor apache que conecta con un host ldapserver de su misma red



**hostpam19:base**: container preparado para montar un directorio tmp dentro de el home de cualquier usuario nuevo al iniciar sesión.

**hostpam19:consultas**: container preparado para hacer consultas ldap con getent a un server ldapserver con base `dc=edt,dc=org`

**hostpam19:auth**: container que autentifica con usuarios ldap con uri ldapserver y base `dc=edt,dc=org`