#!/bin/bash

source "$PROVISION_FOLDER/util.sh"

docker-compose up -d

MASTER_NAME="gitlab-master"
RUNNER_NAME="gitlab-runner-0"
MASTER_ID=$(docker ps -aqf "name=^$MASTER_NAME")
RUNNER_ID=$(docker ps -aqf "name=^$RUNNER_NAME")
MASTER_FOLDER="./master"
RUNNER_FOLDER="./runner"

function waitForReadiness() {
  PING_URL="$GITLAB_URL/users/sign_in" # TODO: Use actual /-/health endpoint, which currently doesn't work
#  PING_URL="$GITLAB_URL/-/health"
  echo -ne "Waiting for Gitlab to be ready"
  while :; do
    RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" $PING_URL)
    if [ $RESPONSE_CODE -eq 302 ] ; then
      break
    fi
    echo -ne "."
    echo "$PING_URL response: $RESPONSE_CODE"
    sleep 5
  done
  printf "\n${GREEN}Gitlab ready${NC}"
}

function restore() {
  echo "********** RESTORING GITLAB BACKUP **********"

  docker cp $MASTER_FOLDER/dump_gitlab_backup.tar $MASTER_ID:/var/opt/gitlab/backups/dump_gitlab_backup.tar
  docker exec -t $MASTER_NAME chown git.git /var/opt/gitlab/backups/dump_gitlab_backup.tar

  docker exec -t $MASTER_NAME gitlab-backup restore BACKUP=dump force=yes
  docker cp $MASTER_FOLDER/config/gitlab.rb $MASTER_ID:/etc/gitlab/gitlab.rb
  docker cp $MASTER_FOLDER/config/gitlab-secrets.json $MASTER_ID:/etc/gitlab/gitlab-secrets.json
  echo "Restarting gitlab"
  docker restart $MASTER_NAME

#  echo "Restoring runner"
#  docker cp $RUNNER_FOLDER/config.toml $RUNNER_ID:/etc/gitlab-runner/config.toml
#  docker restart $RUNNER_NAME
}

waitForReadiness
restore
waitForReadiness
