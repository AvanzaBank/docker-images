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
TBD
````


### Run with docker-compose

````
TBD
````
