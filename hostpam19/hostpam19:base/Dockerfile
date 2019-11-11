FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="hostpam"

RUN dnf install -y vim procps iproute nmap util-linux-user finger passwd
RUN mkdir /opt/docker

RUN useradd anna -p anna
RUN useradd pere -p pere
RUN useradd pau -p pau

WORKDIR /opt/docker/