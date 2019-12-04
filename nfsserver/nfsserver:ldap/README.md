# nfsserver:ldap

Servidor nfs que interactua con ldapserver y exporta los homes de ciertos usuarios, desde `/exports/tmp/home`

```bash
/exports/tmp/home 	*(rw,sync)
```

## Requisitos

Es necesario un volumen exports para el servidor nfs, este guardara los directorios personales en dicho volumen.

## Puesta en marcha

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19

docker run --rm --name nfsserver -h nfsserver --net ldapnet -v exports:/exports --privileged -d jorgepastorr/nfsserver:ldap
```