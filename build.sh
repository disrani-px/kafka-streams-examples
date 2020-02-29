#!/bin/sh

STREAMS_VERSION=5.4.0
ARTIFACT_ID=kafka-streams-examples

mvn -DskipTests=true clean package
sudo docker build -f Dockerfile.rhel8 . -t ${DOCKER_HUB_REPO}/${DOCKER_HUB_IMAGE}:${DOCKER_HUB_TAG}
