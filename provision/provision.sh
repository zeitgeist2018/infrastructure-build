#!/bin/bash
set -e

cd /home/vagrant/provision

mkdir -p data/artifactory
mkdir -p data/postgresql
sudo chmod 777 data/artifactory
sudo chmod 777 data/postgresql

docker-compose up -d

sudo chmod +x ./restore.sh
./restore.sh
