# run-java-app-from-nexus

Image used to run an executable java application that is available from a Nexus instance. The application is downloaded
from Nexus using the provided coordinates and then started in the container – passing any provided arguments to the java
application at startup.

The image can be configured with the following environment variables:

* `GROUP_ID` - the group id of the artifact to run
* `ARTIFACT_ID` - the id of the artifact to run
* `VERSION` - the version of the artifact to run
* `JAVA_ARGS`- arguments to pass to the java application at startup (optional)
* `CLASSIFIER` - classifier of the artifact to run (optional)
* `TYPE` - the type of the artifact to run (optional, defaults to `jar`)
* `REPOSITORY` - the Nexus repository to use. Defaults to `snapshots`.
* `NEXUS_URI` - the URI to the Nexus server. E.g. `http://example.com`.


## Examples

### Run with Script

````
#!/bin/bash -e

pushd "${BASH_SOURCE%/*}/.."

BASE_IMAGE=avanzabank/run-java-app-from-nexus

function runWithArtifact() {
    GROUP_ID=$1
    ARTIFACT=$2
    VERSION=$3
    CLASSIFIER=$4
    JAVA_ARGS=$5
    DOCKER_ARGS=$6

    NAME="my-test-${ARTIFACT}"
    NEXUS_URI="http://nexus.example.com"

    echo "Cleaning up any existing containers for: '${NAME}'"
    docker rm -f -v "${NAME}" || true
    echo "Running docker image for ${ARTIFACT}"
    set -x
    docker run -d -i -t --rm --name "${NAME}" --env GROUP_ID="${GROUP_ID}" --env ARTIFACT_ID="${ARTIFACT}" --env VERSION="${VERSION}" --env CLASSIFIER="${CLASSIFIER}" --env JAVA_ARGS="${JAVA_ARGS}" --env NEXUS_URI="${NEXUS_URI}" ${DOCKER_ARGS} "${BASE_IMAGE}"
    set +x
    exit;
}

runWithArtifact "my.group.id" "my-artifact" "LATEST" "executable" "-Dlogging.level.org.springframework.boot.web.embedded=DEBUG" "-p 8188:8188 -p 8189:8189"

#docker logs -f "my-test-my-artifact"
````

### Run with docker-compose

````
version: '3'
services:
  my-service:
    image: avanzabank/run-java-app-from-nexus
    environment:
      GROUP_ID: 'my.group.id'
      ARTIFACT_ID: 'my-service'
      VERSION: 'LATEST'
      CLASSIFIER: 'executable'
      JAVA_ARGS: '-Dlogging.level.org.springframework.boot.web=DEBUG'
      NEXUS_URI: "http://nexus.example.com"
    ports:
      - 8181:8181
      - 8180:8180 # actuator port e.g. http://localhost:8181/actuator/
    depends_on:
      - my-other-service
  my-other-service:
    image: avanzabank/run-java-app-from-nexus
    environment:
      GROUP_ID: 'my.group.id'
      ARTIFACT_ID: 'my-other-service'
      VERSION: 'LATEST'
      CLASSIFIER: 'executable'
      JAVA_ARGS: ''
      NEXUS_URI: "http://nexus.example.com"
    ports:
      - 8080:8080
      - 8081:8081 # actuator port e.g. http://localhost:8081/actuator/  
````
