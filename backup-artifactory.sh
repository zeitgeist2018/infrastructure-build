#!/bin/bash

HOST="http://192.168.1.100:8081"
MASTER_NAME="artifactory"
MASTER_ID=$(docker ps -aqf "name=^$MASTER_NAME$")
MASTER_FOLDER="./provision/artifactory"
BACKUP_PATH="/home/backup"
BACKUP_FILE_NAME="backup.zip"
COOKIES_FILE="artifactory-cookies"
USER="admin"
PWD="passw0rd"

function login() {
  printf "\n\nLOGIN INTO ARTIFACTORY"
  LOGIN_BODY="{\"user\": \"$USER\",\"password\": \"$PWD\",\"type\":\"login\"}"
  LOGIN_URL="$HOST/artifactory/ui/auth/login"
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST $LOGIN_URL -H "Content-Type: application/json" --data "$LOGIN_BODY" --cookie-jar $COOKIES_FILE)
  if [ $RESPONSE_CODE -eq 200 ]; then
    printf "${GREEN}Artifactory login successful${NC}"
  else
    printf "${RED}There has been an error while loging into Artifactory${NC}"
    exit 1
  fi
}

function backup() {
  echo "********** BACKING UP ARTIFACTORY **********"
  URL="$HOST/artifactory/ui/artifactexport/system"
  BACKUP_BODY="{\"path\":\"$BACKUP_PATH\",\"excludeContent\":false,\"excludeMetadata\":false,\"m2\":false,\"createArchive\":true,\"verbose\":false,\"action\":\"system\"}"
  RESPONSE_CODE=$(curl -X POST $URL -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -H "X-Requested-With: artUI" -H "Request-Agent: artifactoryUI" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1.2 Safari/605.1.15" --data "$BACKUP_BODY" --cookie $COOKIES_FILE)
  docker exec -t $MASTER_NAME mv "$BACKUP_PATH/*" "$BACKUP_PATH/$BACKUP_FILE_NAME"
  docker exec -i $MASTER_NAME ls $BACKUP_PATH | xargs mv $1 $BACKUP_PATH/$BACKUP_FILE_NAME
  docker cp $MASTER_ID:"$BACKUP_PATH"/jenkins_home/jobs $MASTER_FOLDER
  docker cp $MASTER_ID:/var/jenkins_home/config.xml $MASTER_FOLDER/config/config.xml
  docker cp $MASTER_ID:/var/jenkins_home/com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig.xml $MASTER_FOLDER/config/com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig.xml
  docker cp $MASTER_ID:/var/jenkins_home/plugins.txt $MASTER_FOLDER/plugins.txt
  sort $MASTER_FOLDER/plugins.txt -o $MASTER_FOLDER/plugins.txt
}

backup
