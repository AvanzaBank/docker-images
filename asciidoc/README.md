# asciidoc

Image containing asciidoc, pandoc, asciidoctor, asciidoctor-pdf etc.

This image can be used to easily create PDFs from asciidoc documentation (.adoc files).

Example of how to create PDFs using this Docker image:

```bash
#!/usr/bin/env bash

# Creates a PDF using asciidoctor-pdf

# This script is simply executing the "create-pdf-sh" script from within the docker container. This way, there is no
# need to install asciidoctor and asciidoctor-pdf on your local machine.

#################################################

pushd "${BASH_SOURCE%/*}/"

# Convert all .adoc files from current directory
docker run -it --rm -v $PWD:/opt/mydir avanzabank/asciidoc /bin/bash -c "cd /opt/mydir; /opt/bin/create-pdf.sh /opt/mydir"

```
