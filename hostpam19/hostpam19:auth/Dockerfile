FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="hostpam"

RUN dnf install -y vim procps iproute nmap util-linux-user finger passwd \
                        pam_mount nss-pam-ldapd nfs-utils
RUN mkdir /opt/docker

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker/

CMD /opt/docker/startup.sh