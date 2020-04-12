#!/bin/bash

RED='\n\033[0;31m'
GREEN='\n\033[0;32m'
NC='\033[0m'

HOME="/home/vagrant"
HOST=$1
ARTIFACTORY_PORT="8081"
ARTIFACTORY_URL="$HOST:$ARTIFACTORY_PORT"
COOKIES_FILE="artifactory-cookies"
BACKUP_FILE="$HOME/provision/artifactory/backup.zip"
CONTAINER_BACKUP_FILE="/home/backup.zip"
DEFAULT_USER="admin"
DEFAULT_PWD="password"

function waitForReadiness() {
  PING_URL="$ARTIFACTORY_URL/artifactory/api/system/ping"
  echo -ne "Waiting for artifactory to be ready"
  while :; do
    RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" $PING_URL)
    if [ $RESPONSE_CODE -eq 200 ] || [ $RESPONSE_CODE -eq 401 ]; then
      break
    fi
    echo -ne "."
    sleep 2
  done
  printf "\n${GREEN}Artifactory ready${NC}"
}

function login() {
  printf "\n\nLOGIN INTO ARTIFACTORY"
  LOGIN_BODY="{\"user\": \"$DEFAULT_USER\",\"password\": \"$DEFAULT_PWD\",\"type\":\"login\"}"
  LOGIN_URL="$ARTIFACTORY_URL/artifactory/ui/auth/login"
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST $LOGIN_URL -H "Content-Type: application/json" --data "$LOGIN_BODY" --cookie-jar $COOKIES_FILE)
  if [ $RESPONSE_CODE -eq 200 ]; then
    printf "${GREEN}Artifactory login successful${NC}"
  else
    printf "${RED}There has been an error while loging into Artifactory${NC}"
    exit 1
  fi
}

function restoreBackup() {
  printf "\n\nRESTORING BACKUP"
  RESTORE_URL="$ARTIFACTORY_URL/artifactory/ui/artifactimport/system"
  RESTORE_BODY="{\"path\": \"$CONTAINER_BACKUP_FILE\",\"excludeContent\":false,\"excludeMetadata\":false,\"verbose\":false,\"zip\":true,\"action\":\"system\"}"
  CONTAINER_ID=$(docker ps -aqf "name=^artifactory$")
  docker cp $BACKUP_FILE "$CONTAINER_ID":$CONTAINER_BACKUP_FILE
  RESPONSE_CODE=$(curl -X POST $RESTORE_URL -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -H "X-Requested-With: artUI" -H "Request-Agent: artifactoryUI" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1.2 Safari/605.1.15" --data "$RESTORE_BODY" --cookie $COOKIES_FILE)
  if [ $RESPONSE_CODE -eq 200 ]; then
    printf "${GREEN}Artifactory has been configured successfully!${NC}"
  else
    printf "${RED}There has been an error while restoring artifactory backup. Code: $RESPONSE_CODE ${NC}"
  fi
  rm $COOKIES_FILE
}

waitForReadiness
login
restoreBackup
