####################################################################################
# Creates a container with Oracle JDK 9
####################################################################################

# Command reference:
# docker build -t avanzabank/ubuntu-oraclejdk9:local .
# docker run -it --rm avanzabank/ubuntu-oraclejdk9:local /bin/bash
#
# See published packages here: https://launchpad.net/~webupd8team/+archive/ubuntu/java
#

FROM ubuntu:17.10

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    software-properties-common && \
    rm -rf /var/lib/apt/lists

RUN echo oracle-java9-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && apt-get install -y \
    oracle-java9-installer=9.0.4-1~webupd8~0 && \
    rm -rf /var/lib/apt/lists

WORKDIR /opt
