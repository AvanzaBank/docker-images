#!/bin/bash -e

GROUP_ID=$1
ARTIFACT=$2
VERSION=$3
CLASSIFIER=$4
TYPE=$5
REPOSITORY=$6
NEXUS_URI=$7 # e.g. http://nexus.example.com
JAVA_ARGS=$8


# Script for getting artifacts from Nexus
# Originally from https://gist.github.com/sawano/a73cb9a26075439ecf23f220bc0a9464
function getArtifact() {
    # http://redsymbol.net/articles/unofficial-bash-strict-mode/
    set -euo pipefail
    IFS=$'\n\t'

    groupId=$1
    artifactId=$2
    version=$3

    # optional
    classifier=${4:-}
    type=${5:-jar}
    repo=${6:-snapshots}

    # Nexus 2
    #base="http://nexus.example.com/service/local/repositories/${repo}/content"
    # Nexus 3
    base="${NEXUS_URI}/service/local/repositories/${repo}/content"
    if [[ $classifier != "" ]]; then
      classifier="-${classifier}"
    fi

    groupIdUrl="${groupId//.//}"
    filename="${artifactId}-${version}${classifier}.${type}"

    if [[ "${version}" == "LATEST" || "${version}" == *SNAPSHOT* ]] ; then
      if [[ "${version}" == "LATEST" ]] ; then
        metadataUri="${base}/${groupIdUrl}/${artifactId}/maven-metadata.xml"
        echo "Fetching metadata from: ${metadataUri} ..."
        version=$(grep -oPm1 "(?<=<latest>)[^<]+" <(curl -s ${metadataUri})) || true
        if [[ -z "${version}" ]] ; then
            # If there's only one artifact in Nexus then there's no <latest> tag
            version=$(grep -oPm1 "(?<=<version>)[^<]+" <(curl -s ${metadataUri}))
        fi
        echo "LATEST version is: ${version}"
      fi
      versionSpecificMetadataUri="${base}/${groupIdUrl}/${artifactId}/${version}/maven-metadata.xml"
      echo "Fetching metadata for version ${version} from: ${versionSpecificMetadataUri}..."
      metadata=$(curl -s ${versionSpecificMetadataUri})
      timestamp=$(grep -oPm1 "(?<=<timestamp>)[^<]+" <<<"${metadata}")
      buildnumber=$(grep -oPm1 "(?<=<buildNumber>)[^<]+" <<<"${metadata}")
      url="${base}/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${version%-SNAPSHOT}-${timestamp}-${buildnumber}${classifier}.${type}"
      echo "Fetching jar from ${url} ..."
      curl -s -L -o ${filename} ${url}
    else
      url="${base}/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${version}${classifier}.${type}"
      echo "Fetching jar from ${url} ..."
      curl -s -L -o ${filename} ${url}
    fi

    echo "Renaming ${filename} to app.jar"
    mv "${filename}" app.jar
}

cd /opt

echo "Downloading artifact: '${GROUP_ID}:${ARTIFACT}:${VERSION}:${TYPE}:${CLASSIFIER}' from repository: '${REPOSITORY}' using Nexus at: '${NEXUS_URI}'"
getArtifact ${GROUP_ID} ${ARTIFACT} ${VERSION} ${CLASSIFIER} ${TYPE} ${REPOSITORY}
ls -l

echo "Starting app..."
set -x
java ${JAVA_ARGS} -jar app.jar
set +x
