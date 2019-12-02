FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="hostpam19:samba"

RUN dnf install -y passwd nss-pam-ldapd authconfig samba-client cifs-utils pam_mount

RUN mkdir /opt/docker
WORKDIR /opt/docker/

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh

CMD /opt/docker/startup.sh