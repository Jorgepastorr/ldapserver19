FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="hostpam19:multi"

RUN dnf install -y passwd nss-pam-ldapd authconfig \
                 nfs-utils pam_mount 

RUN mkdir /opt/docker
WORKDIR /opt/docker/

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh

CMD /opt/docker/startup.sh