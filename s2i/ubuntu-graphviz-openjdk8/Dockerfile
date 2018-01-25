####################################################################################
# Creates a container to use with OpenShift source-to-image (s2i)
####################################################################################

# Command reference:
# docker build -t avanzabank/ubuntu-graphviz-openjdk8:0.0.1 -t avanzabank/ubuntu-graphviz-openjdk8 .
# docker run -it avanzabank/ubuntu-graphviz-openjdk8 /bin/bash


FROM avanzabank/ubuntu-graphviz-openjdk8:0.0.1

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="Java 8 with graphviz builder image" \
    io.k8s.display-name="Java 8 with graphviz s2i" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,java,graphviz" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

# Copy the S2I scripts to /usr/libexec/s2i since we set the label that way
COPY  ["run", "assemble", "usage", "/usr/libexec/s2i/"]

# Modify the usage script in your application dir to inform the user how to run
# this image.
CMD ["/usr/libexec/s2i/usage"]

RUN chgrp -R 0 /usr/libexec/s2i \
  && chmod -R g+rwx /usr/libexec/s2i

RUN chgrp -R 0 /opt \
  && chmod -R g+rwx /opt

RUN chown -R 1001:0 /opt && \
    chown -R 1001:0 /usr/libexec/s2i/assemble

USER 1001

EXPOSE 8080
