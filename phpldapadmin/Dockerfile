# phpldapadmin
FROM fedora:27  
LABEL version="1.0"
LABEL author="@jorgepastorr"
                            
RUN  dnf -y install phpldapadmin php-xml httpd
RUN mkdir /opt/docker

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh

WORKDIR /opt/docker
CMD /opt/docker/startup.sh
                                                    
