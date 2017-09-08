####################################################################################
# Creates a container with OpenJDK 8
####################################################################################

# Command reference:
# docker build -t avanzabank/ubuntu-openjdk8:0.0.1 -t avanzabank/ubuntu-openjdk8:latest .
# docker run -it avanzabank/ubuntu-openjdk8 /bin/bash


FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    openjdk-8-jdk=8u131-b11-2ubuntu1.16.04.3 && \
    rm -rf /var/lib/apt/lists

WORKDIR /opt
