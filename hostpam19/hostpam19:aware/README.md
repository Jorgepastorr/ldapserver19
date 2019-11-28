## jorgepastorr/hostpam19:aware

```bash
docker run --rm --name pam -h pam -it jorgepastorr/hosdtpam19:aware
```

contenedor con 2 usuarios jorge y anna. con las contraseñas igual al nombre. 

archivo `pamaware.py` que ejecuta una cuenta atras si le introduces un usuario unix valido.

```bash
/usr/bin/python /opt/docker/pamaware.py
```

chfn modificado con el modulo python.so y un script en `/opt/docker/pam_mates.py`, para que pregunte por un calculo matematico como autentificacion.

```bash
#%PAM-1.0
auth       optional     pam-echo.so [ auth ------- ]
auth       sufficient    pam_python.so /opt/docker/pam_mates.py

account     optional     pam-echo.so [ account ------- ]
account     sufficient    pam_python.so /opt/docker/pam_mates.py

password   include      pam_deny.so
session    include      pam_deny.so
```

```bash
root # su - jorge
jorge $ chfn
...
3*2=
2
sucesfull
```
