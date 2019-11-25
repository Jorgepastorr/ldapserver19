FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="hostpam19:scratch"

RUN dnf install -y passwd nss-pam-ldapd authconfig

RUN mkdir /opt/docker
WORKDIR /opt/docker/

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh

CMD /opt/docker/startup.sh