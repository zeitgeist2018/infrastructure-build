#!/bin/bash

set -e

export HOST="$1"
export HOME="/home/vagrant"
export PROVISION_FOLDER="$HOME/provision"
export DATA_FOLDER="$HOME/data"

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
  prefixOutput "[provision-artifactory]" ./configure.sh &
}

function provisionJenkins(){
  cd $PROVISION_FOLDER/jenkins
  echo "********** PROVISIONING JENKINS **********"
  sudo chmod +x ./configure.sh
  prefixOutput "[provision-jenkins]" ./configure.sh &
}

function provisionGitlab(){
  cd $PROVISION_FOLDER/gitlab
  echo "********** PROVISIONING GITLAB **********"
  sudo chmod +x ./configure.sh
  prefixOutput "[provision-gitlab]" ./configure.sh &
}

function installDocker(){
  cd $PROVISION_FOLDER
  prefixOutput "[install-docker]" ./install-docker.sh
}

echo "PROVISIONING HOST $HOST"

createDataFolders
installTpl
parseTplTemplates $PROVISION_FOLDER
installDocker
provisionArtifactory
provisionJenkins
provisionGitlab

wait

echo "${GREEN}The build platform is ready for you to use :)"
echo "ARTIFACTORY URL: $ARTIFACTORY_URL"
echo "JENKINS URL: $JENKINS_URL"
echo "GITLAB URL: $GITLAB_URL${NC}"
