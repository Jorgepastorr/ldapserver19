Entrypoint ldap

Modificar la imatge ldapserver:latest (​ ldapserver:entrypoint ​ ) de manera que tingui un script startup.sh de entrypoint que permeti:

- initdb : ​ inicialitzar la base de dades ldap sense dades i engegar el servei.
- initdbedt : ​ initiclitzar la base de dades ldap amb les dades per defecte usuals i engegar el servei.
- listdn ​ : llistar els dn de la base de ddaes ldap usant una comanda de baix nivell “slapcat | grep dn”.
- res o start : ​ engegar el servei ldap la base de dades, amb dades o sense, ha d’existir prèviament).
- *​ : qualsevol altre conjunt de paràmetres que es passin com a CMDi s’executarà usant ​ eval​

```bash
docker run --rm --name ldap.edt.org -h ldap.edt.org -v ldap-data:/var/lib/ldap -v ldap-conf:/etc/openldap --net mynet -d jorgepastorr/ldapserver19:entrypoint initdb
docker run --rm --name ldap.edt.org -h ldap.edt.org -v ldap-data:/var/lib/ldap -v ldap-conf:/etc/openldap --net mynet -d jorgepastorr/ldapserver19:entrypoint initdbedt
docker run --rm --name ldap.edt.org -h ldap.edt.org -v ldap-data:/var/lib/ldap -v ldap-conf:/etc/openldap --net mynet -d jorgepastorr/ldapserver19:entrypoint
docker run --rm --name ldap.edt.org -h ldap.edt.org -v ldap-data:/var/lib/ldap -v ldap-conf:/etc/openldap --net mynet -it jorgepastorr/ldapserver19:entrypoint listdn
docker run --rm --name ldap.edt.org -h ldap.edt.org -v ldap-data:/var/lib/ldap -v ldap-conf:/etc/openldap --net mynet -it jorgepastorr/ldapserver19:entrypoint ls /etc/openldap
```