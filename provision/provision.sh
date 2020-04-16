#!/bin/bash

set -e

#HOST=$1
#PROVISION_FOLDER="$HOME/provision"
#DATA_FOLDER="$HOME/data"

export HOST="$1"
export HOME="/home/vagrant"
export PROVISION_FOLDER="$HOME/provision"
export DATA_FOLDER="$HOME/data"
#export HOME="$HOME"

export JENKINS_PORT="8080"
export ARTIFACTORY_PORT="8081"
export GITLAB_PORT="8082"
export JENKINS_URL="http://$HOST:$JENKINS_PORT"
export ARTIFACTORY_URL="http://$HOST:$ARTIFACTORY_PORT"
export GITLAB_URL="http://$HOST:$GITLAB_PORT"

cd "$PROVISION_FOLDER"
source ./util.sh


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
  cd $PROVISION_FOLDER/gitlab
  echo "********** PROVISIONING GITLAB **********"
  sudo chmod +x ./configure.sh
  ./configure.sh "$HOST"
}

function installDocker(){
  cd $PROVISION_FOLDER
  ./install-docker.sh
}

echo "PROVISIONING HOST $HOST"

createDataFolders
installTpl
parseTplTemplates $PROVISION_FOLDER
installDocker
#provisionArtifactory
#provisionJenkins
provisionGitlab
