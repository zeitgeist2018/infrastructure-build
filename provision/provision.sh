#!/bin/bash
set -e

HOST=$1
HOME="/home/vagrant"
PROVISION_FOLDER="$HOME/provision"
DATA_FOLDER="$HOME/data"

function createDataFolders(){
  cd $HOME
  mkdir -p data/artifactory
  mkdir -p data/artifactory-postgresql
  sudo chmod 777 data/*
}

function provisionArtifactory(){
  cd $PROVISION_FOLDER/artifactory
  echo "********** PROVISIONING ARTIFACTORY **********"
  docker-compose -f artifactory-postgres.yml up -d
  sudo chmod +x ./configure.sh
  ./configure.sh "$HOST"
}

function installDocker(){
  cd $PROVISION_FOLDER
  ./install-docker.sh
}

echo "PROVISIONING HOST $HOST"

createDataFolders
installDocker
provisionArtifactory
