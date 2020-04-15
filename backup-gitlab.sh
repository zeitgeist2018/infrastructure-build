#!/bin/bash

MASTER_NAME="gitlab-master"
RUNNER_NAME="gitlab-runner-0"
MASTER_ID=$(docker ps -aqf "name=^$MASTER_NAME")
RUNNER_ID=$(docker ps -aqf "name=^$RUNNER_NAME")
MASTER_FOLDER="./provision/gitlab/master"
RUNNER_FOLDER="./provision/gitlab/runner"

function backup() {
  echo "********** BACKING UP GITLAB **********"
  docker exec -t $MASTER_NAME gitlab-backup create BACKUP=dump
  docker cp $MASTER_ID:/var/opt/gitlab/backups/dump_gitlab_backup.tar $MASTER_FOLDER/dump_gitlab_backup.tar
  docker cp $MASTER_ID:/etc/gitlab/gitlab-secrets.json $MASTER_FOLDER/config/gitlab-secrets.json
  docker cp $MASTER_ID:/etc/gitlab/gitlab.rb $MASTER_FOLDER/config/gitlab.rb
}

function restore() {
  echo "********** RESTORING GITLAB BACKUP **********"
  docker cp $MASTER_FOLDER/dump_gitlab_backup.tar $MASTER_ID:/var/opt/gitlab/backups/dump_gitlab_backup.tar
  docker exec -t $MASTER_NAME chown git.git /var/opt/gitlab/backups/dump_gitlab_backup.tar
  echo "Executing restore"
  docker exec -it $MASTER_NAME gitlab-backup restore BACKUP=dump
  docker cp $MASTER_FOLDER/config/gitlab-secrets.json $MASTER_ID:/etc/gitlab/gitlab-secrets.json
  echo "Restarting gitlab"
  docker restart $MASTER_NAME

  echo "Restoring runner"
#  docker cp $RUNNER_FOLDER/config.toml $RUNNER_ID:/etc/gitlab-runner/config.toml
#  docker restart $RUNNER_NAME
}

backup
#restore
