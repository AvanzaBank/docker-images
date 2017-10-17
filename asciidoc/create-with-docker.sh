#!/usr/bin/env bash

# Creates a PDF using asciidoctor-pdf

# This script is simply executing the "create-pdf-sh" script from within the docker container. This way, there is no
# need to install asciidoctor and asciidoctor-pdf on your local machine.

#################################################

pushd "${BASH_SOURCE%/*}/"

# Map current directory to /opt/avanza
docker run -d --name aza-pdf-creation -it -v $PWD:/opt/avanza avanzabank/asciidoc

# Create PDFs from all adoc files found in /opt/avanza
docker exec aza-pdf-creation /opt/bin/create-pdf.sh /opt/avanza

docker stop aza-pdf-creation
docker rm aza-pdf-creation
