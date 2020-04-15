#!/bin/bash

MASTER_NAME="jenkins-master"
MASTER_ID=$(docker ps -aqf "name=^$MASTER_NAME")
MASTER_FOLDER="./provision/jenkins/master"

function backup() {
  echo "********** BACKING UP JENKINS **********"
  docker cp $MASTER_ID:/var/jenkins_home/jobs $MASTER_FOLDER
  docker cp $MASTER_ID:/var/jenkins_home/config.xml $MASTER_FOLDER/config/config.xml
  docker cp $MASTER_ID:/var/jenkins_home/com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig.xml $MASTER_FOLDER/config/com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig.xml
  docker cp $MASTER_ID:/var/jenkins_home/plugins.txt $MASTER_FOLDER/plugins.txt
  sort $MASTER_FOLDER/plugins.txt -o $MASTER_FOLDER/plugins.txt
}

backup
