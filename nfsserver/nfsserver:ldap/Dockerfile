FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="nfs:ldap"

RUN dnf install -y vim nfs-utils nss-pam-ldapd authconfig

RUN mkdir /opt/docker

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker/

CMD /opt/docker/startup.sh