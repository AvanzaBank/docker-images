####################################################################################
# Creates a container with Oracle JDK 8
####################################################################################

# Command reference:
# docker build -t avanzabank/ubuntu-oraclejdk8:local .
# docker run -it avanzabank/ubuntu-oraclejdk8:local /bin/bash
#
# See published packages here: https://launchpad.net/~webupd8team/+archive/ubuntu/java
#

FROM ubuntu:17.10

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    software-properties-common && \
    rm -rf /var/lib/apt/lists

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && apt-get install -y \
    oracle-java8-installer=8u181-1~webupd8~1 && \
    rm -rf /var/lib/apt/lists

WORKDIR /opt
