#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "You must provide the agent name to publish"
    exit 1
fi

USER="admin"
PWD="passw0rd"
DOMAIN=${ARTIFACTORY_JCR_DOMAIN:-artifactory-jcr.dev.local}
REPO="$DOMAIN/docker-local"
PREFIX="jenkins-agent"
AGENT=$1
VERSION=${2:-latest}
TAG="$REPO/$PREFIX-$AGENT:$VERSION"

docker build -t "$TAG" "$AGENT"
docker login -u $USER -p $PWD $DOMAIN
docker push "$TAG"
docker rmi "$TAG"
