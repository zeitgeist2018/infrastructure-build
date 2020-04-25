#!/bin/bash
set -e

function enableDockerApi(){
  sudo cp conf/docker.service /lib/systemd/system/docker.service
}

echo "********** INSTALLING DOCKER **********"
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null 2>&1
sudo apt-get install -y docker.io > /dev/null 2>&1
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant
sudo systemctl restart docker
enableDockerApi
sudo systemctl daemon-reload
sudo service docker restart
docker --version
curl localhost:4243/version

# Install docker compose
echo "********** INSTALLING DOCKER-COMPOSE **********"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  > /dev/null 2>&1
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
