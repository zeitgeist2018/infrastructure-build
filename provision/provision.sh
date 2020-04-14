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
  sudo chmod +x ./configure.sh
  ./configure.sh "$HOST"
}

function provisionJenkins(){
  cd $PROVISION_FOLDER/jenkins
  echo "********** PROVISIONING JENKINS **********"
  sudo chmod +x ./configure.sh
  ./configure.sh "$HOST"
}

function provisionGitlab(){
  cd $PROVISION_FOLDER/jenkins
  echo "********** PROVISIONING JENKINS **********"
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
#provisionArtifactory $HOST
provisionJenkins
provisionGitlab $HOST
