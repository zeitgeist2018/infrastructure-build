#!/bin/bash

set -e

export HOST="$1"
export HOME="/home/vagrant"

function exportEnvironment(){
cat <<EOF > $HOME/.bash_profile
export HOST="$HOST"
export HOME="/home/vagrant"
export PROVISION_FOLDER="$HOME/provision"
export DATA_FOLDER="$HOME/data"
export DOCKER_API_PORT="4243"

export JENKINS_PORT="8080"
export ARTIFACTORY_PORT="8081"
export ARTIFACTORY_JCR_PORT="8082"
export GITLAB_PORT="8083"

export BASE_DOMAIN="dev.local
export JENKINS_DOMAIN="jenkins.$BASE_DOMAIN"
export ARTIFACTORY_DOMAIN="artifactory.$BASE_DOMAIN"
export ARTIFACTORY_JCR_DOMAIN="artifactory-jcr.$BASE_DOMAIN"
export GITLAB_DOMAIN="gitlab.$BASE_DOMAIN"

export JENKINS_URL="https://$JENKINS_DOMAIN"
export ARTIFACTORY_URL="http://$ARTIFACTORY_DOMAIN"
export ARTIFACTORY_JCR_URL="https://$ARTIFACTORY_JCR_DOMAIN"
export GITLAB_URL="http://$GITLAB_DOMAIN"
EOF
}

function allowInsecureCurl(){
cat <<EOF > $HOME/.curlrc
insecure
EOF
}

function createDataFolders(){
  mkdir -p "$DATA_FOLDER"/artifactory-jcr/backups
  mkdir -p "$DATA_FOLDER"/jenkins/master
  sudo chmod 777 -R $DATA_FOLDER/*
}

function provisionArtifactory(){
  cd "$PROVISION_FOLDER"/artifactory
  echo "********** PROVISIONING ARTIFACTORY **********"
  sudo chmod +x ./configure.sh
  ./configure.sh
}

function provisionArtifactoryJCR(){
  cd "$PROVISION_FOLDER"/artifactory-jcr
  echo "********** PROVISIONING ARTIFACTORY JCR **********"
  sudo chmod +x ./configure.sh
  ./configure.sh
}

function provisionContainerRegistry(){
  cd "$PROVISION_FOLDER"/artifactory-jcr
  echo "********** PROVISIONING ARTIFACTORY CONTAINER REGISTRY **********"
  sudo chmod +x ./configure.sh
  ./configure.sh
}

function provisionJenkins(){
  cd "$PROVISION_FOLDER"/jenkins
  echo "********** PROVISIONING JENKINS **********"
  sudo chmod +x ./configure.sh
  ./configure.sh
}

function provisionGitlab(){
  cd "$PROVISION_FOLDER"/gitlab
  echo "********** PROVISIONING GITLAB **********"
  sudo chmod +x ./configure.sh
  ./configure.sh
}

function provisionDnsServer(){
  cd "$PROVISION_FOLDER"/dns-server
  echo "********** PROVISIONING DNS SERVER **********"
  sudo chmod +x ./configure.sh
  ./configure.sh
}

function installDocker(){
  cd "$PROVISION_FOLDER/docker"
  ./install-docker.sh
}

echo "PROVISIONING HOST $HOST"

exportEnvironment

source $HOME/.bash_profile
cd "$PROVISION_FOLDER"
source ./util.sh

createDataFolders
installTpl
parseTplTemplates "$PROVISION_FOLDER"
allowInsecureCurl
installDocker

provisionDnsServer
#provisionArtifactory
provisionArtifactoryJCR
provisionJenkins
#provisionGitlab

printf "\n\n\n${GREEN}The build platform is ready for you to use :)"
printf "\nARTIFACTORY URL: $ARTIFACTORY_URL"
printf "\nARTIFACTORY JCR URL: $ARTIFACTORY_JCR_URL"
printf "\nJENKINS URL: $JENKINS_URL"
printf "\nGITLAB URL: $GITLAB_URL${NC}"
