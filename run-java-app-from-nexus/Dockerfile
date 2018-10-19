#
# Creates an image that will download an artifact from Nexus and then run it as a java app
# What artifact to download is controlled by environment variables
#

FROM avanzabank/ubuntu-openjdk8:0.1.2

ENV GROUP_ID my.group.id
ENV ARTIFACT_ID some-artifact
ENV VERSION LATEST
ENV CLASSIFIER ""
ENV TYPE "jar"
ENV REPOSITORY "snapshots"
ENV NEXUS_URI "http://example.com"
ENV JAVA_ARGS ""

ADD run-app.sh /opt/
RUN chmod +x /opt/run-app.sh

ENTRYPOINT /opt/run-app.sh $GROUP_ID $ARTIFACT_ID $VERSION $CLASSIFIER $TYPE $REPOSITORY $NEXUS_URI $JAVA_ARGS
